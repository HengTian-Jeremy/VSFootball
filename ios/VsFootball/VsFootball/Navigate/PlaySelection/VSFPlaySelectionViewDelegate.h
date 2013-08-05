//
//  VSFPlaySelectionViewDelegate.h
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VSFPlaySelectionViewDelegate <NSObject>

- (void)showSelectedPlay: (NSString *)playType playName: (NSString *)tacticsName;

@end
