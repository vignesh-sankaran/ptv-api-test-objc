//
//  PTVAPIDelegate.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 21/03/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#include "PTVHealthCheckServicePublic.h"

#ifndef PTVAPIDelegate_h
#define PTVAPIDelegate_h

@class PTVAPI;
@protocol PTVAPIDelegate <NSObject>
    -(void) ptvAPIHealthCheck: (PTVAPI *) sender;
@end

#endif /* PTVAPIDelegate_h */