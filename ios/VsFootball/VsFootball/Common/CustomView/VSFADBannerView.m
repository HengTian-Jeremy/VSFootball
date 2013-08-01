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
        self.backgroundColor = [UIColor grayColor];
        
        UILabel *adsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        adsLabel.backgroundColor = [UIColor clearColor];
        [adsLabel setText:@"Ads"];
        [adsLabel setFont:[UIFont systemFontOfSize:30.0]];
        [adsLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:adsLabel];
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
