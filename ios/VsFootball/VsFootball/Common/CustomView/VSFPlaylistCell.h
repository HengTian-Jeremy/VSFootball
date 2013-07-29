//
//  VSFPlaylistCell.h
//  VsFootball
//
//  Created by hjy on 7/29/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class VSFPlaylistCell
 
 @abstract Playlist cell
 
 @discussion Playlist cell
 */
@interface VSFPlaylistCell : UITableViewCell{
    UIImageView *cellImageView;
    UIButton *clickCellButton;
    UILabel *playerLabel;
}
@property(copy, nonatomic) UIImage *image;

/*!
 @method setPlayerLabelText
 @abstract set player label text
 @discussion set player label text
 @param player
 @result void
 */
- (void)setPlayerLabelText: (NSString *)player;

/*!
 @method setCellImage
 @abstract set cell image
 @discussion set cell image
 @param image name
 @result void
 */
- (void)setCellImage: (NSString *)imageName;

@end
