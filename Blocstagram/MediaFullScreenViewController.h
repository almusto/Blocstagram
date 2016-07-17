//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Alessandro Musto on 7/11/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) Media *media;


- (instancetype) initWithMedia: (Media *)media;

- (void) centerScrollView;

- (void) recalculateZoomScale;

@end
