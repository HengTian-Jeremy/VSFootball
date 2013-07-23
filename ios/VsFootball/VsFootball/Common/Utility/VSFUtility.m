//
//  VSFUtility.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 Jessie Hu. All rights reserved.
//

#import "VSFUtility.h"

#import "Reachability.h"
#import <CommonCrypto/CommonDigest.h>

@implementation VSFUtility

+ (NSString *)encrypt:(NSString *)password
{
    const char *cstr = [password cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:password.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


+ (NSString *)validateSignInInfo:(NSString *)name withPassword:(NSString *)pwd;
{
    NSString *result = @"ERROR";
    BOOL flag = NO;
    
    if (0 == name.length) {
        result = @"USERNAME_EMPTY";
    } else if (100 < name.length) {
        result = @"USERNAME_OUT_OF_RANGE";
    } else {
        flag = YES;
    }
    
    if (flag && 0 == pwd.length) {
        result = @"PASSWORD_EMPTY";
    } else if (flag && 20 < pwd.length) {
        result = @"PASSWORD_OUT_OF_RANGE";
    } else  if (flag) {
        result = @"SUCCESS";
    }
    
    return result;
}

+ (NSString *)validateSignUpInfo:(VSFSignUpInfo *)info;
{
    NSString *result = @"SUCCESS";
    
    return result;
}

+ (int)checkNetwork
{
    Reachability *reach = [[Reachability reachabilityForInternetConnection] retain];
    NetworkStatus status = [reach currentReachabilityStatus];
    NSString *string;
    switch (status) {
        case NotReachable:
            string = @"NotReachable";
            break;
        case ReachableViaWiFi:
            string = @"ReachableViaWiFi";
            break;
        case ReachableViaWWAN:
            string = @"ReachableViaWWAN";
            break;
        default:
            string = @"error";
            break;
    }
    NSLog(@"current network: %@", string);
    return status;
}

@end
