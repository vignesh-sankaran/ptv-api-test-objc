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

- (NSString *)CreateHmacSignature:(NSString *)url
{
    NSDictionary *apiSecrets = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"]];
    NSString *apiKey = [apiSecrets valueForKey:@"ApiKey"];
    
    const char *cApiKey = [apiKey cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cUrl = [apiKey cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char rawHmacOutput[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cApiKey, strlen(cApiKey), cUrl, strlen(cUrl), rawHmacOutput);
    
    NSData *refinedHmacOutput = [[NSData alloc] initWithBytes:rawHmacOutput length:sizeof(rawHmacOutput)];
    
    NSString *test = [[NSString alloc] initWithData:refinedHmacOutput encoding:NSASCIIStringEncoding];
    
    return test;
}

@end