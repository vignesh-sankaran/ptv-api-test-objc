//
//  PTVAPIHealthCheckViewModel.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 16/04/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#ifndef PTVHealthCheckViewModel_h
#define PTVHealthCheckViewModel_h

@interface PTVHealthCheckViewModel : NSObject
-(instancetype) init;
@property NSString *clientClockStatus;
@property NSString *securityTokenStatus;
@property NSString *memCacheStatus;
@property NSString *databaseStatus;
@end

#endif /* PTVHealthCheckViewModel_h */