//
//  HealthCheckModel.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 24/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#ifndef PTVHealthCheck_h
#define PTVHealthCheck_h

@interface PTVHealthCheck: NSObject
- (instancetype)initWithData:(BOOL)clientClockOk securityTokenOk:(BOOL)securityTokenOk memCacheOk:(BOOL)memCacheOk databaseOk:(BOOL)databaseOk;

@property (nonatomic) BOOL clientClockOk;
@property (nonatomic) BOOL securityTokenOk;
@property (nonatomic) BOOL memCacheOk;
@property (nonatomic) BOOL databaseOk;

@end

#endif /* PTVHealthCheck_h */