//
//  HealthCheckModel.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 24/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#ifndef PTVHealthCheck_h
#define PTVHealthCheck_h

@interface PTVHealthCheck: NSObject <NSCoding>
- (instancetype)initWithData:(BOOL)clientClockOk securityTokenOk:(BOOL)securityTokenOk memCacheOk:(BOOL)memCacheOk databaseOk:(BOOL)databaseOk;

@property BOOL clientClockOk;
@property BOOL securityTokenOk;
@property BOOL memCacheOk;
@property BOOL databaseOk;

@end

#endif /* PTVHealthCheck_h */