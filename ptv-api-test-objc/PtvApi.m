//
//  PtvApi.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import "PtvApi.h"

@implementation PtvApi

- (NSString *)CreateHmacSignature: (NSString *)url
{
    NSDictionary *apiSecrets = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"]];
    NSString *apiKey = [apiSecrets valueForKey:@"ApiKey"];
    
    unsigned char rawHmacOutput[CC_SHA1_DIGEST_LENGTH];
    CCHmac(CC_SHA1_BLOCK_BYTES, (__bridge const void *)(apiKey), apiKey.length, (__bridge const void *)(url), url.length, rawHmacOutput);
    
    NSData *refinedHmacOutput = [[NSData alloc] initWithBytes:rawHmacOutput length:sizeof(rawHmacOutput)];
    
    return [[NSString alloc] initWithData:refinedHmacOutput encoding:NSUTF8StringEncoding];
    
}

@end