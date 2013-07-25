//
//  VSFSingleton.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFSingleton.h"

@implementation VSFSingleton

+(VSFSingleton *)sharedSingleton
{
    static VSFSingleton *sharedSingleton;
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[VSFSingleton alloc] init];
        return sharedSingleton;
    }
}

@end
