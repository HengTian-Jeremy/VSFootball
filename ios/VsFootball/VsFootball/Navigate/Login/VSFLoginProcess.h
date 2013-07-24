//
//  VSFLoginProcess.h
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFResponseEntity;

@protocol VSFLoginProcessDelegate <NSObject>

@optional
- (void)setLoginResult:(VSFResponseEntity *)respEntity;

@end

@interface VSFLoginProcess : NSObject

@property (nonatomic, retain) id<VSFLoginProcessDelegate> delegate;

- (void)login:(NSString *)username withPassword:(NSString *)password;

@end
