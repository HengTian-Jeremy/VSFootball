//
//  VSFScoreView.m
//  VsFootball
//
//  Created by hjy on 7/29/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFScoreView.h"
#define row 7
#define column 4
//score image
#define SCORE_IMAGE_W 1/9.
#define SCORE_IMAGE_H 1/15.

@interface VSFScoreView()

- (void)defaultInit;
- (void)lightScore:(int)posX vertical:(int)posY status:(BOOL)isLightening;

@end

@implementation VSFScoreView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self defaultInit];
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

- (void)createScoreArray:(int)scoreNumber
{
    switch (scoreNumber) {
        case 0:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][0] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][0] = @"1";
            scoreArray[2][3] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][0] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][0] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][0] = @"1";
            scoreArray[6][1] = @"1";
            scoreArray[6][2] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 1:
            scoreArray[0][3] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][3] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 2:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][3] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][1] = @"1";
            scoreArray[3][2] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][0] = @"1";
            scoreArray[5][0] = @"1";
            scoreArray[6][0] = @"1";
            scoreArray[6][1] = @"1";
            scoreArray[6][2] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 3:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][3] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][1] = @"1";
            scoreArray[3][2] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][0] = @"1";
            scoreArray[6][1] = @"1";
            scoreArray[6][2] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 4:
            scoreArray[0][0] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][0] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][0] = @"1";
            scoreArray[2][3] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][1] = @"1";
            scoreArray[3][2] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 5:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][0] = @"1";
            scoreArray[2][0] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][1] = @"1";
            scoreArray[3][2] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][0] = @"1";
            scoreArray[6][1] = @"1";
            scoreArray[6][2] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 6:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][0] = @"1";
            scoreArray[2][0] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][1] = @"1";
            scoreArray[3][2] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][0] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][0] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][0] = @"1";
            scoreArray[6][1] = @"1";
            scoreArray[6][2] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 7:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][4] = @"1";
            scoreArray[3][4] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 8:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][0] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][0] = @"1";
            scoreArray[2][3] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][1] = @"1";
            scoreArray[3][2] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][0] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][0] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][0] = @"1";
            scoreArray[6][1] = @"1";
            scoreArray[6][2] = @"1";
            scoreArray[6][3] = @"1";
            break;
        case 9:
            scoreArray[0][0] = @"1";
            scoreArray[0][1] = @"1";
            scoreArray[0][2] = @"1";
            scoreArray[0][3] = @"1";
            scoreArray[1][0] = @"1";
            scoreArray[1][3] = @"1";
            scoreArray[2][0] = @"1";
            scoreArray[2][3] = @"1";
            scoreArray[3][0] = @"1";
            scoreArray[3][1] = @"1";
            scoreArray[3][2] = @"1";
            scoreArray[3][3] = @"1";
            scoreArray[4][3] = @"1";
            scoreArray[5][3] = @"1";
            scoreArray[6][0] = @"1";
            scoreArray[6][1] = @"1";
            scoreArray[6][2] = @"1";
            scoreArray[6][3] = @"1";
            break;
        default:
            break;
    }
}

- (void)createScoreView
{
    if (scoreArray != nil) {
        for (int i = 0; i < row; i ++) {
            for (int j = 0; j < column; j ++){
                NSString *value = scoreArray[i][j];
                [self lightScore:j vertical:i status:[value boolValue]];
            }
        }
    }
}

- (void)chooseScoreNumber:(int)scoreNumber
{
    switch (scoreNumber) {
        case 0:
            [scoreImageView setImage:[UIImage imageNamed:@"0"]];
            break;
        case 1:
            [scoreImageView setImage:[UIImage imageNamed:@"1"]];
            break;
        case 2:
            [scoreImageView setImage:[UIImage imageNamed:@"2"]];
            break;
        case 3:
            [scoreImageView setImage:[UIImage imageNamed:@"3"]];
            break;
        case 4:
            [scoreImageView setImage:[UIImage imageNamed:@"4"]];
            break;
        case 5:
            [scoreImageView setImage:[UIImage imageNamed:@"5"]];
            break;
        case 6:
            [scoreImageView setImage:[UIImage imageNamed:@"6"]];
            break;
        case 7:
            [scoreImageView setImage:[UIImage imageNamed:@"7"]];
            break;
        case 8:
            [scoreImageView setImage:[UIImage imageNamed:@"8"]];
            break;
        case 9:
            [scoreImageView setImage:[UIImage imageNamed:@"9"]];
            break;
        default:
            [scoreImageView setImage:[UIImage imageNamed:@"default"]];
            break;
    }
}

#pragma mark - private methods
- (void)defaultInit
{    
    self.backgroundColor = [UIColor darkGrayColor];
    
    scoreImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    scoreImageView.backgroundColor = [UIColor clearColor];
//    [scoreImageView setImage:[UIImage imageNamed:@"orange_circle"]];
    [scoreImageView setImage:[UIImage imageNamed:@"default"]];
    [self addSubview:scoreImageView];
    
    if (scoreArray == nil) {
        scoreArray = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < row; i ++) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < column; j ++) {
            [tempArray addObject:@"0"];
        }
        [scoreArray addObject:tempArray];
//        [tempArray removeAllObjects];
    }
}


- (void)lightScore:(int)posX vertical:(int)posY status:(BOOL)isLightening
{
    float positionX = (2 * posX + 1) / 9.0;
    float positionY = (2 * posY + 1) / 15.0;
    UIImageView *scoreImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * positionX, self.bounds.size.height * positionY, self.bounds.size.width * SCORE_IMAGE_W, self.bounds.size.height * SCORE_IMAGE_H)];
    [scoreImage setBackgroundColor:[UIColor clearColor]];
    if (isLightening) {
        [scoreImage setImage:[UIImage imageNamed:@"orange_circle"]];
    }else{
        [scoreImage setImage:[UIImage imageNamed:@"blackCircle"]];
    }
    [self addSubview:scoreImage];
}

@end
