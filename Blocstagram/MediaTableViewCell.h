//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Alessandro Musto on 6/20/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

@end
