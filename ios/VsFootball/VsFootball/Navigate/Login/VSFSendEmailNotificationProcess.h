//
//  VSFSendEmailNotificationProcess.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-25.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFResponseEntity;

@protocol VSFSendEmailNotificationProcessDelegate <NSObject>
- (void)setSendEmailNotificationResult:(VSFResponseEntity *)respEntity;

@end

@interface VSFSendEmailNotificationProcess : NSObject

@property (nonatomic, retain) id<VSFSendEmailNotificationProcessDelegate> delegate;

- (void)SendEmailNotification:(NSString *)email;

@end