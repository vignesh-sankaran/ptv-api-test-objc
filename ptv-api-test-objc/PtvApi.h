//
//  PtvApi.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#ifndef PtvApi_h
#define PtvApi_h

@interface PtvApi : NSObject
- (NSString *)CreateHmacSignature:(NSString *)url;
- (NSString *)CurrentDateTimeInISO8601;
- (NSData *)healthCheck;
@end

#endif /* PtvApi_h */
