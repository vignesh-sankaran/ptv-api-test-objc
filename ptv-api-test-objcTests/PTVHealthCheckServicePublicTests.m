//
//  APIDelegateTests.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PTVHealthCheckServicePublic.h"

@interface PTVHealthCheckServicePublicTests : XCTestCase
{
    BOOL callbackInvoked;
}
@end

@implementation PTVHealthCheckServicePublicTests

- (void)setUp {
    [super setUp];
    callbackInvoked = NO;
}

- (void)tearDown {
    [super tearDown];
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
    [PTVAPI ptvAPIHealthCheck];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedApiData:) name:@"HealthCheckData" object:nil];
    XCTAssertTrue([self waitForCompletion:30.0]);
}

-(void)receivedApiData:(NSNotification *)notification
{
    callbackInvoked = YES;
}
@end