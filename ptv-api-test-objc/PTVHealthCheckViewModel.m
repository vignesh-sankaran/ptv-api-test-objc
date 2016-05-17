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
@property NSData *apiResults;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedApiData:) name:@"HealthCheckData" object:self.apiResults];
    
    return self;
}

-(void)receivedApiData:(NSNotification *)notification
{
    
}

@end