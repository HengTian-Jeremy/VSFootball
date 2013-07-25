//
//  VSFForgotPasswordProcess.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFResponseEntity;

@protocol VSFForgotPasswordProcessDelegate <NSObject>

@optional
- (void)setForgotPasswordResult:(VSFResponseEntity *)respEntity;
@end

@interface VSFForgotPasswordProcess : NSObject

@property (nonatomic, retain) id<VSFForgotPasswordProcessDelegate> delegate;

- (void)forgotPassword:(NSString *)email;

@end
