//
//  VSFFacebookFriends.h
//  VsFootball
//
//  Created by Jessie Hu on 13-8-6.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSFFacebookFriends : NSObject

@property (nonatomic, retain) NSArray *friendsList;

+ (VSFFacebookFriends *)getFacebookFriends;

@end
