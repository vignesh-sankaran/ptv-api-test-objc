//
//  PTVAPI.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#include "PTVAPIDelegate.h"

#ifndef PTVAPI_h
#define PTVAPI_h

@interface PTVAPI : NSObject
@property (nonatomic, weak) id <NSURLSessionDataDelegate> delegate;
- (void)ptvAPIHealthCheck;
@end

#endif /* PTVAPI_h */