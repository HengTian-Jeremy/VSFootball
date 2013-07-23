//
//  VSFNetIndicator.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
    @class ERNetIndicator
 
    @abstract network Indicator manager
 
    @discussion network Indicator manager
*/
@interface VSFNetIndicator : NSObject {

    NSInteger activeCount;

    NSCondition *countLock;

    BOOL isActived;
}

@property (nonatomic, readwrite, assign) BOOL isVisible;

+ (VSFNetIndicator *)defaultIndicator;

+ (void)releasedefaultIndicator;

@end
