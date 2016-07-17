//
//  StuffCollectionViewCell.m
//  Blocstagram
//
//  Created by Alessandro Musto on 7/17/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import "StuffCollectionViewCell.h"

@implementation StuffCollectionViewCell


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        self.imageView.tag = imageViewTag;
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
