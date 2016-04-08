//
//  ptv_api_test_objcTests.m
//  ptv-api-test-objcTests
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PtvApiPublic.h"
#import "PtvApiPrivate.h"

@interface ptv_api_test_objcTests : XCTestCase

@end

@implementation ptv_api_test_objcTests


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatHmacMethodReturnsNotNullString
{
    // given
    NSString *healthCheckUrl = @"http://timetableapi.ptv.vic.gov.au";
    PtvApi *testApi = [[PtvApi alloc] init];
    
    // when
    NSString *test = [testApi CreateHmacSignature:healthCheckUrl];
    
    // then
    
    XCTAssertNotNil(test);
}

- (void)testThatDateGetsFormatted
{
    PtvApi *testApi = [[PtvApi alloc] init];
    NSString *dateInISO8601 = [testApi CurrentDateTimeInISO8601];
    
    XCTAssertNotNil(dateInISO8601);
}

- (void)testThatFullUrlIsGenerated
{
    PtvApi *testApi = [[PtvApi alloc] init];
    
    NSString *fullUrl = [testApi GenerateRequestUrl];
    NSLog(@"%@", fullUrl);
    
    XCTAssertNotNil(fullUrl);
}

- (void)testThatApiCallWorks
{
    __block Boolean hasCalledBack = NO;
    
    PtvApi *testApi = [[PtvApi alloc] init];
    
    
    
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    }
    
    if (!hasCalledBack)
    {
        XCTAssertFalse(@"I know this will fail, thanks");
    }
    
}

@end
