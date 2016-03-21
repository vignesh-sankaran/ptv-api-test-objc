//
//  PtvApiDelegate.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 21/03/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#include "PtvApiPublic.h"

#ifndef PtvApiDelegate_h
#define PtvApiDelegate_h

@class PtvApi;
@protocol PtvApiDelegate <NSObject>
    -(void) ptvApiHealthCheck: (PtvApi *) sender;
@end

#endif /* PtvApiDelegate_h */