//
//  APIDelegateTests.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PTVAPIPublic.h"

@interface APIDelegateTests : XCTestCase <NSURLSessionDataDelegate>
{
    PTVAPI *testApi;
    BOOL callbackInvoked;
}
@end

@implementation APIDelegateTests

- (void)setUp {
    [super setUp];
    testApi = [[PTVAPI alloc] init];
    testApi.delegate = self;
    callbackInvoked = NO;
}

- (void)tearDown {
    testApi.delegate = nil;
    [super tearDown];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    callbackInvoked = YES;
}

// Method is credit to Claus Brooch.
// Retrieved from http://www.infinite-loop.dk/blog/2011/04/unittesting-asynchronous-network-access/ on 10/04/2016
- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!callbackInvoked);
    
    return callbackInvoked;
}

- (void)testThatApiCallbackWorks {
    [testApi ptvAPIHealthCheck];
    
    XCTAssert([self waitForCompletion:30.0], @"Testing to see what happens here...");
}
@end