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
    
    self.clientClockOk = clientClockOk;
    self.securityTokenOk = securityTokenOk;
    self.memCacheOk = memCacheOk;
    self.databaseOk = databaseOk;
    
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    self.clientClockOk = [decoder decodeBoolForKey:@"clientClockOk"];
    self.securityTokenOk = [decoder decodeBoolForKey:@"securityTokenOk"];
    self.memCacheOk = [decoder decodeBoolForKey:@"memcacheOk"];
    self.databaseOk = [decoder decodeBoolForKey:@"databaseOk"];
    
    return self;
}

-(void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeBool:self.clientClockOk forKey:@"clientClockOk"];
    [encoder encodeBool:self.securityTokenOk forKey:@"securityTokenOk"];
    [encoder encodeBool:self.memCacheOk forKey:@"memcacheOk"];
    [encoder encodeBool:self.databaseOk forKey:@"databaseOk"];
}

@end