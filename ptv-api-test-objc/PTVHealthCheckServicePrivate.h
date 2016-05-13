//
//  PTVAPIPrivate.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 11/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#include "PTVHealthCheck.h"
#ifndef PTVAPIPrivate_h
#define PTVAPIPrivate_h

@interface PTVAPI()
- (NSString *)createHmacSignature:(NSString *)url;
- (NSString *)currentDateTimeInISO8601;
- (NSString *)generateRequestUrl;
- (void)saveData:(PTVHealthCheck *)healthCheckData;
- (PTVHealthCheck *)parseHealthCheckResponse:(NSData *)rawData;
@end


#endif /* PTVAPIPrivate_h */
