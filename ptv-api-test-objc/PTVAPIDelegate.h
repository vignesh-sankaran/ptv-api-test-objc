//
//  PTVAPIDelegate.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 21/03/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#include "PTVAPIPublic.h"

#ifndef PTVAPIDelegate_h
#define PTVAPIDelegate_h

@class PTVAPI;
@protocol PTVAPIDelegate <NSObject>
    -(void) PTVAPIHealthCheck: (PTVAPI *) sender;
@end

#endif /* PTVAPIDelegate_h */