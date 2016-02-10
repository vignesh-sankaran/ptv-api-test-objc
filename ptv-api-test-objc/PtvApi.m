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

- (NSString *)CurrentDateTimeInISO8601
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return [dateFormatter stringFromDate:[NSDate date]];
    
}

- (NSData *)healthCheck
{
    NSString *baseUrl = @"http://timetableapi.ptv.vic.gov.au";
    NSString *healthCheckUrl = @"/v2/healthCheck";
    NSString *currentDateTimeInISO8601 = [self CurrentDateTimeInISO8601];
 
    NSDictionary *apiSecrets = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"]];
    NSString *devId = [apiSecrets valueForKey:@"DevId"];
    
    NSString *preHmacUrl = [NSString stringWithFormat:@"%@%@%@%@%@%@", baseUrl, healthCheckUrl, @"?timestamp=", currentDateTimeInISO8601, @"&devid=", devId];
    NSString *hmac = [self CreateHmacSignature:preHmacUrl];
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@%@", preHmacUrl, @"&signature=", hmac];
    
    NSURLSessionConfiguration *healthCheckConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *healthCheckSession = [NSURLSession sessionWithConfiguration: healthCheckConfiguration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:fullUrl];
    
    NSURLSessionTask *healthCheckTask = [healthCheckSession dataTaskWithURL:url];
    [healthCheckTask resume];
    return NULL;
}

@end

@interface NSDate ()

@end