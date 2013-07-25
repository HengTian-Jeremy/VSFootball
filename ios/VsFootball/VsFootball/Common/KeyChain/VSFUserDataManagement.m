//
//  VSFUserDataManagement.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFUserDataManagement.h"
#import "VSFKeyChain.h"

static NSString * const KEY_IN_KEYCHAIN = @"engagemobile.vsfootball.app";
static NSString * const KEY_EMAIL = @"engagemobile.vsfootball.app.email";
static NSString * const KEY_PASSWORD = @"engagemobile.vsfootball.app.password";
static NSString * const KEY_USERNAME = @"engagemobile.vsfootball.app.username";

@implementation VSFUserDataManagement

+(void)saveUserEmail:(NSString *)email
{
    NSMutableDictionary *emailKVPairs = [[NSMutableDictionary alloc] init];
    [emailKVPairs setObject:email forKey:KEY_EMAIL];
    [VSFKeyChain save:KEY_IN_KEYCHAIN data:emailKVPairs];
    
    [emailKVPairs release], emailKVPairs = nil;
}

+(NSString *)readEmail
{
    NSMutableDictionary *emailKVPairs = (NSMutableDictionary *)[VSFKeyChain load:KEY_IN_KEYCHAIN];
    NSString *email=[emailKVPairs objectForKey:KEY_EMAIL];
    return email;
}

+(void)saveUserPassWord:(NSString *)username password:(NSString *)password
{
    NSMutableDictionary *userKVPairs = [[NSMutableDictionary alloc] init];
    [userKVPairs setObject:username forKey:KEY_USERNAME];
    [userKVPairs setObject:password forKey:KEY_PASSWORD];
    [VSFKeyChain save:KEY_IN_KEYCHAIN data:userKVPairs];
    
    [userKVPairs release], userKVPairs = nil;
}

+(NSMutableArray *)readUsernameAndPassword
{
    NSMutableDictionary *userKVPairs = (NSMutableDictionary *)[VSFKeyChain load:KEY_IN_KEYCHAIN];
    NSMutableArray *userArray=[NSMutableArray arrayWithObjects:[userKVPairs objectForKey:KEY_USERNAME],[userKVPairs objectForKey:KEY_PASSWORD], nil];
    return userArray;
}

+(void)deleteUsernameAndPassword
{
    [VSFKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
