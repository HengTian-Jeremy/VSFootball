//
//  VSFUserDataManagement.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VSFKeyChain.h"

@interface VSFUserDataManagement : NSObject

+(void)saveUserEmail:(NSString *)email;
+(NSString *)readEmail;

+(void)saveUserPassWord:(NSString *)username password:(NSString *)password;
+(NSMutableArray *)readUsernameAndPassword;
+(void)deleteUsernameAndPassword;

@end
