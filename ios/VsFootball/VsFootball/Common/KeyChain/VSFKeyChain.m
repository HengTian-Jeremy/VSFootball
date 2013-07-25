//
//  VSFKeyChain.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFKeyChain.h"

@implementation VSFKeyChain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)query
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            query, (id)kSecAttrService,
            query, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)query data:(id)data
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:query];
    //Delete old item
    SecItemDelete(( CFDictionaryRef)keychainQuery);
    //Add new object
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:( id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd(( CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)query
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:query];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:( id)kSecReturnData];
    [keychainQuery setObject:( id)kSecMatchLimitOne forKey:( id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching(( CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:( NSData *)keyData];
        } @catch (NSException *e) {
           
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)query
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:query];
    SecItemDelete(( CFDictionaryRef)keychainQuery);
}

@end
