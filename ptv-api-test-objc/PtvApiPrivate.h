//
//  PtvApiPrivate.h
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 11/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#ifndef PtvApiPrivate_h
#define PtvApiPrivate_h

@interface PtvApi()
- (NSString *)CreateHmacSignature:(NSString *)url;
- (NSString *)CurrentDateTimeInISO8601;
- (NSString *)GenerateRequestUrl;
@end


#endif /* PtvApiPrivate_h */
