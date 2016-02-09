//
//  ptv_api_test_objcTests.m
//  ptv-api-test-objcTests
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PtvApi.h"

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

- (void)testExample {
    
}

- (void)testThatItEncodesUrlsWithHmac
{
    // given
    NSString *healthCheckUrl = @"http://timetableapi.ptv.vic.gov.au";
    PtvApi *testApi = [[PtvApi alloc] init];
    
    // when
    NSString *test = [testApi CreateHmacSignature:healthCheckUrl];
    
    // then
    
    assert(test);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
