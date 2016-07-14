//
//  DataSource.h
//  Blocstagram
//
//  Created by Alessandro Musto on 6/20/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Media;

typedef void (^NewItemCompletionBlock)(NSError *error);

@interface DataSource : NSObject


+ (NSString *) instagramClientID;
+ (instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;

- (void) deleteMediaItem: (Media *)item;

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

- (void) downloadImageForMediaItem:(Media *)mediaItem;


@end
