//
//  CameraViewController.h
//  Blocstagram
//
//  Created by Alessandro Musto on 7/17/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraViewController;

@protocol CameraViewControllerDelegate <NSObject>

- (void) cameraViewController:(CameraViewController *)cameraViewController didCompleteWithImage:(UIImage *)image;

@end

@interface CameraViewController : UIViewController

@property (nonatomic, weak) NSObject <CameraViewControllerDelegate> *delegate;

@end
