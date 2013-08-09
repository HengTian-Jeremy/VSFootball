//
//  VSFReadAndWriteFile.h
//  VsFootball
//
//  Created by hjy on 8/8/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSFReadAndWriteFile : NSObject

+ (void)writeData: (NSMutableDictionary *)writeData fileName :(NSString *)fileName;
+ (NSMutableDictionary *)readData: (NSString *)fileName;

@end
