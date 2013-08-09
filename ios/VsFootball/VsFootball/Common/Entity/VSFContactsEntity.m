//
//  VSFContactsEntity.m
//  VsFootball
//
//  Created by hjy on 8/6/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFContactsEntity.h"

@implementation VSFContactsEntity
@synthesize name, email, phone;

- (id)init
{
    self = [super init];
    if (self) {
        name = [[NSString alloc] init];
        email = [[NSString alloc] init];
        phone = [[NSString alloc] init];
    }
    return self;
}


@end
