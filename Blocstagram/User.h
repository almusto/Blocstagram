//
//  User.h
//  Blocstagram
//
//  Created by Alessandro Musto on 6/20/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject <NSCoding>


@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *profilePictureURL;
@property (nonatomic, strong) UIImage *profilePicture;

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary;

@end
