//
//  HealthCheckModel.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 24/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#ifndef PTVHealthCheckModel_h
#define PTVHealthCheckModel_h

typedef struct
{
    BOOL clientClockOk;
    BOOL securityTokenOk;
    BOOL memCacheOk;
    BOOL databaseOk;
} PTVHealthCheckModel;

#endif /* PTVHealthCheckModel_h */