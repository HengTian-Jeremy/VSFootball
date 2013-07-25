//
//  VSFKeyChain.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSFKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)query;
+ (void)save:(NSString *)query data:(id)data;
+ (id)load:(NSString *)query;
+ (void)delete:(NSString *)query;

@end
