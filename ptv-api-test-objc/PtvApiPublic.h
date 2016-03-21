//
//  PtvApi.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#include "PtvApiDelegate.h"

#ifndef PtvApi_h
#define PtvApi_h

@interface PtvApi : NSObject
@property (nonatomic, weak) id <PtvApiDelegate> delegate;
- (void)healthCheck:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
@end

#endif /* PtvApi_h */
