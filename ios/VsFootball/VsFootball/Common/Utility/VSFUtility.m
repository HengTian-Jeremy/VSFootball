//
//  VSFUtility.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 Jessie Hu. All rights reserved.
//

#import "VSFUtility.h"

#import "VSFSignUpEntity.h"
#import "Reachability.h"
#import <CommonCrypto/CommonDigest.h>

@interface VSFUtility ()

+ (BOOL)checkEmailFormat:(NSString *)email;

@end

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
        result = @"USERNAME EMPTY";
    } else if (100 < name.length) {
        result = @"USERNAME OUT OF RANGE";
    } else {
        flag = YES;
    }
    
    if (flag && 0 == pwd.length) {
        result = @"PASSWORD EMPTY";
    } else if (flag && 20 < pwd.length) {
        result = @"PASSWORD OUT OF RANGE";
    } else  if (flag) {
        result = @"SUCCESS";
    }
    
    return result;
}

+ (NSString *)validateSignUpInfo:(VSFSignUpEntity *)entity;
{
    NSString *result = @"ERROR";
    BOOL flag = NO;
    
    if (0 == entity.email.length) {
        result = @"EMAIL EMPTY";
    } else if (100 < entity.email.length) {
        result = @"EMAIL OUT OF RANGE";
    } else if (![self checkEmailFormat:entity.email]) {
        result = @"EMAIL FORMAT ERROR";
    } else {
        flag = YES;
    }
    
    if (flag) {
        flag = NO;
        if (0 == entity.password.length) {
            result = @"PASSWORD EMPTY";
        } else if (20 < entity.password.length) {
            result = @"PASSWORD OUT OF RANGE";
        } else {
            flag = YES;
        }
        
        if (flag) {
            flag = NO;
            if (0 == entity.confirmPassword.length) {
                result = @"CONFIRM PASSWORD EMPTY";
            } else if (50 < entity.firstname.length) {
                result = @"CONFIRM PASSWORD OUT OF RANGE";
            } else if (![entity.password isEqualToString:entity.confirmPassword]) {
                result = @"TWO PASSWORDS NOT MATCH";
            } else {
                flag = YES;
            }
            
            if (flag) {
                flag = NO;
                if (0 == entity.firstname.length) {
                    result = @"FIRSTNAME EMPTY";
                } else if (50 < entity.firstname.length) {
                    result = @"FIRSTNAME OUT OF RANGE";
                } else {
                    flag = YES;
                }
                
                if (flag) {
                    if (0 == entity.lastname.length) {
                        result = @"LASTNAME EMPTY";
                    } else if (50 < entity.lastname.length) {
                        result = @"LASTNAME OUT OF RANGE";
                    } else {
                        result = @"SUCCESS";
                    }
                }
            }
        }
    }
    return result;
}

+ (int)checkNetwork
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
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

#pragma mark - Private Methods

+ (BOOL)checkEmailFormat:(NSString *)email
{
    NSString *regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [emailTest evaluateWithObject:email];
}

@end
