//
//  ptv_api_test_objcTests.m
//  ptv-api-test-objcTests
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PTVHealthCheckServicePublic.h"
#import "PTVHealthCheckServicePrivate.h"
#import "PTVHealthCheck.h"

@interface PTVHealthCheckServicePrivateTests : XCTestCase

@end

@implementation PTVHealthCheckServicePrivateTests


- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatHmacMethodReturnsNotNullString
{
    NSString *healthCheckUrl = @"http://timetableapi.ptv.vic.gov.au";
    NSString *test = [PTVAPI createHmacSignature:healthCheckUrl];

    XCTAssertNotNil(test);
}

- (void)testThatDateGetsFormatted
{
    NSString *dateInISO8601 = [PTVAPI currentDateTimeInISO8601];
    
    XCTAssertNotNil(dateInISO8601);
}

- (void)testThatFullUrlIsGenerated
{
    NSString *fullUrl = [PTVAPI generateRequestUrl];
    NSLog(@"%@", fullUrl);
    
    XCTAssertNotNil(fullUrl);
}

- (void)testThatDataIsSaved
{
    PTVHealthCheck *testData = [[PTVHealthCheck alloc]
                                     initWithData:YES
                                     securityTokenOk:YES
                                     memCacheOk:YES
                                     databaseOk:YES];
   
    NSData *dataLocation = [PTVAPI saveData:testData];
    PTVHealthCheck *processedData = [NSKeyedUnarchiver unarchiveObjectWithData:dataLocation];
    XCTAssertTrue(processedData.clientClockOk);
}

@end