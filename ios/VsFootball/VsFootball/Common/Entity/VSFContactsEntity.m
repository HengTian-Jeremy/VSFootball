//
//  VSFContactsEntity.m
//  VsFootball
//
//  Created by hjy on 8/6/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFContactsEntity.h"

@implementation VSFContactsEntity
@synthesize firstName, lastName, email, phone;

- (id)init
{
    self = [super init];
    if (self) {
        firstName = [[NSString alloc] init];
        lastName = [[NSString alloc] init];
        email = [[NSString alloc] init];
        phone = [[NSString alloc] init];
    }
    return self;
}


@end
