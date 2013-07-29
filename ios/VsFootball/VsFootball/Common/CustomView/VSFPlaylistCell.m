//
//  VSFPlaylistCell.m
//  VsFootball
//
//  Created by hjy on 7/29/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlaylistCell.h"
// Player label
#define PLAYER_LABEL_X 0.25
#define PLAYER_LABEL_Y 0.2
#define PLAYER_LABEL_W 0.7
#define PLAYER_LABEL_H 0.6
// Cell image
#define CELL_IMAGEVIEW_X 0.05
#define CELL_IMAGEVIEW_Y 0.3
#define CELL_IMAGEVIEW_W 0.2
#define CELL_IMAGEVIEW_H 0.2

@interface VSFPlaylistCell()

- (void)defaultInit;
@end

@implementation VSFPlaylistCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self defaultInit];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPlayerLabelText: (NSString *)player
{
    playerLabel.text = player;
}

- (void)setCellImage: (NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    [cellImageView setImage:image];
}

#pragma mark - private methods
- (void)defaultInit
{
    playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * PLAYER_LABEL_X, self.bounds.size.height * PLAYER_LABEL_Y, self.bounds.size.width * PLAYER_LABEL_W, self.bounds.size.height * PLAYER_LABEL_H)];
    playerLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:playerLabel];
    
    cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * CELL_IMAGEVIEW_X, self.bounds.size.height * CELL_IMAGEVIEW_Y, self.bounds.size.width * CELL_IMAGEVIEW_W, self.bounds.size.height * CELL_IMAGEVIEW_H)];
    [self addSubview:cellImageView];
}

@end
