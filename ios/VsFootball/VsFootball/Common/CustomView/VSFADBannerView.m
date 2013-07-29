//
//  VSFADBannerView.m
//  VsFootball
//
//  Created by hjy on 13-7-29.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFADBannerView.h"

static VSFADBannerView *adsBannerView;

@implementation VSFADBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
+ (VSFADBannerView *)getAdBannerView
{
    @synchronized([VSFADBannerView class]) {
        if(!adsBannerView) {
            adsBannerView = [[self alloc] init];
        }
        return  adsBannerView;
    }
    return nil;
}

@end
