//
//  PTVHealthCheckModel.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 10/05/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTVHealthCheck.h"

@implementation PTVHealthCheck
- (instancetype)initWithData:(BOOL)clientClockOk securityTokenOk:(BOOL)securityTokenOk memCacheOk:(BOOL)memCacheOk databaseOk:(BOOL)databaseOk
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    _clientClockOk = clientClockOk;
    _securityTokenOk = securityTokenOk;
    _memCacheOk = memCacheOk;
    _databaseOk = databaseOk;
    
    return self;
}

@end