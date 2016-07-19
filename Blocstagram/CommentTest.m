//
//  CommentTest.m
//  Blocstagram
//
//  Created by Alessandro Musto on 7/19/16.
//  Copyright © 2016 Lmusto. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Comment.h"
#import "ComposeCommentView.h"

@interface CommentTest : XCTestCase

@end

@implementation CommentTest

- (void)testInitalization
{
    NSDictionary *sourceDIctionary = @{@"id": @"83018408",
                                       @"text": @"Hey I have an opinion..."};
    
    Comment *someComment = [[Comment alloc] initWithDictionary:sourceDIctionary];
    
    XCTAssertEqualObjects(someComment.idNumber, sourceDIctionary[@"id"], @"The ID's should be equal");
    XCTAssertEqualObjects(someComment.text, sourceDIctionary[@"text"], "The text should be equal");
}



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
