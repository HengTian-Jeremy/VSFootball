//
//  VSFSignUpProcess.h
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFSignUpEntity;
@class VSFResponseEntity;

@protocol VSFSignUpProcessDelegate <NSObject>

@optional
- (void)setSignUpResult:(VSFResponseEntity *)respEntity;

@end

@interface VSFSignUpProcess : NSObject

@property (nonatomic, retain) id<VSFSignUpProcessDelegate> delegate;

- (void)signUp:(VSFSignUpEntity *)entity;

@end
