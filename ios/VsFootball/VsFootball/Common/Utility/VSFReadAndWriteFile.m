//
//  VSFReadAndWriteFile.m
//  VsFootball
//
//  Created by hjy on 8/8/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFReadAndWriteFile.h"

@implementation VSFReadAndWriteFile

+ (void)writeData: (NSMutableDictionary *)writeData fileName :(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    for (int i = 0; i < keyArray.count; i ++) {
//        [data setObject:[valueArray objectAtIndex:i] forKey:[keyArray objectAtIndex:i]];
//    }
    [data setDictionary:writeData];

//    [data writeToFile:plistFile atomically:YES ];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    [data writeToFile:plistFile atomically:YES];
}

+ (NSMutableDictionary *)readData: (NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    NSMutableDictionary *readData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFile];
    
    return readData;
}

@end
