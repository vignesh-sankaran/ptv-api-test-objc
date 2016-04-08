//
//  APIDelegateTests.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PtvApiPublic.h"

@interface APIDelegateTests : XCTestCase <NSURLSessionDelegate>
{
    PtvApi *testApi;
    BOOL callbackInvoked;
}
@end

@implementation APIDelegateTests

- (void)setUp {
    [super setUp];
    testApi = [[PtvApi alloc] init];
    testApi.delegate = self;
}

- (void)tearDown {
    testApi.delegate = nil;
    [super tearDown];
}

- (void)testThatApiCallbackWorks {
    [testApi ptvApiHealthCheck];
    
    XCTAssert(callbackInvoked, @"Delegate should return something, I think...");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
