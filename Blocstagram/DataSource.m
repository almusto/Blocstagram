//
//  DataSource.m
//  Blocstagram
//
//  Created by Alessandro Musto on 6/20/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Media.h"
#import "Comment.h"
#import "LoginViewController.h"

@interface DataSource () {
    NSMutableArray *_mediaItems;
}

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSArray *mediaItems;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoadingOlderItems;

@end

@implementation DataSource


+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self registerForAccessTokenNotification];
    }
    
    return self;
}

- (void) registerForAccessTokenNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:LoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.accessToken = note.object;
        
        //got token, populate the initial data
        [self populateDataWithParameters:nil];
    }];
}



#pragma mark - Key/Value Observing

- (NSInteger) countOfMediaItems {
    return self.mediaItems.count;
}

- (id) objectInMediaItemsAtIndex:(NSUInteger)index {
    return [self.mediaItems objectAtIndex:index];
}

- (NSArray *) mediaItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.mediaItems objectsAtIndexes:indexes];
}

- (void) insertObject:(Media *)object inMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems insertObject:object atIndex:index];
}

- (void) removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems removeObjectAtIndex:index];
}

- (void) replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_mediaItems replaceObjectAtIndex:index withObject:object];
}

- (void) deleteMediaItem:(Media *)item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    [mutableArrayWithKVO removeObject:item];
}

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
        if (self.isRefreshing == NO) {
        self.isRefreshing = YES;

       //TODO : ADD IMAGES
        
        self.isRefreshing = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}

- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
    if (self.isLoadingOlderItems == NO) {
        self.isLoadingOlderItems = YES;
    
        //TODO ADD IMAGES
        
        self.isLoadingOlderItems = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}

+ (NSString *) instagramClientID {
    return @"5454975ba8e845f6a7b5b26c0f155543";
}

- (void) populateDataWithParameters:(NSDictionary *)parameters {
    if (self.accessToken) {
        
        //only try to get data if access token
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            //do the network request in the backgound so UI doesn't lock up
            NSMutableString *urlString = [NSMutableString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@", self.accessToken];
            
            for (NSString *parameterName in parameters) {
                
                //for example, if ictionary contains {count:50}, append `&count=50` to the URL
                [urlString appendFormat:@"&%@=%@", parameterName, parameters[parameterName]];
            }
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            if (url) {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
//                NSURLResponse *response;
//                NSError *webError;
//                
                
//                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&webError];
               
                NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (data) {
                        NSError *jsonError;
                        
                        NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        if (feedDictionary) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                //done networking, go back on the main thread
                                [self parseDataFromFeedDictionary:feedDictionary fromRequestWithParameters:parameters];
                            });
                        
                        } else {
                            NSLog(@"Response: %@", feedDictionary);
                        }
                    } else {
                        NSLog(@"Error: %@", error.localizedDescription);
                    }
                }];
                
                [task resume];
                
//                
//                if (responseData) {
//                    NSError *jsonError;
//                    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
//                    if (feedDictionary) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            
//                            //done networking, go back on the main thread
//                            [self parseDataFromFeedDictionary:feedDictionary fromRequestWithParameters:parameters];
//                        });
//                    }
//                }
            }
        });
        
    }
}

- (void) parseDataFromFeedDictionary:(NSDictionary *) feedDictionary fromRequestWithParameters:(NSDictionary *)parameters{
    NSLog(@"%@", feedDictionary);
}




@end
