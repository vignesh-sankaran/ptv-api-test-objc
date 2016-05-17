//
//  PTVAPIHealthCheckViewModel.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 16/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTVHealthCheckViewModel.h"
#import "PTVHealthCheck.h"
#import "PTVHealthCheckServicePublic.h"

@interface PTVHealthCheckViewModel()
@property NSData *apiResultsLocation;
@property PTVHealthCheck *apiResults;
@end

@implementation PTVHealthCheckViewModel
-(instancetype) init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    [PTVAPI ptvAPIHealthCheck];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedApiData:) name:@"HealthCheckData" object:nil];
    
    return self;
}

-(void)receivedApiData:(NSNotification *)notification
{
    self.apiResultsLocation = [notification object];
    self.apiResults = [NSKeyedUnarchiver unarchiveObjectWithData:self.apiResultsLocation];
    
    self.clientClockStatus = [self booleanToStatus:self.apiResults.clientClockOk];
    self.securityTokenStatus = [self booleanToStatus:self.apiResults.securityTokenOk];
    self.memCacheStatus = [self booleanToStatus:self.apiResults.memCacheOk];
    self.databaseStatus = [self booleanToStatus:self.apiResults.databaseOk];
}

-(NSString *)booleanToStatus:(BOOL)status
{
    if (status)
    {
        return @"OK";
    }
    return @"NOT OK";
}

@end