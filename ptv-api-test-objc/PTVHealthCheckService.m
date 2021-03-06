//
//  PTVAPI.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import "PTVHealthCheckServicePublic.h"
#import "PTVHealthCheckServicePrivate.h"
#import "PTVHealthCheck.h"

@implementation PTVAPI

+(NSString *)createHmacSignature:(NSString *)url
{
    NSDictionary *apiSecrets = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"]];
    NSString *apiKey = [apiSecrets valueForKey:@"ApiKey"];
    
    const char *cApiKey = [apiKey cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cUrl = [url cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char rawHmacOutput[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cApiKey, strlen(cApiKey), cUrl, strlen(cUrl), rawHmacOutput);
    
    NSData *refinedHmacOutput = [[NSData alloc] initWithBytes:rawHmacOutput length:sizeof(rawHmacOutput)];
    NSString *hmacString = @"";
    uint8_t *dataPointer = (uint8_t *)(refinedHmacOutput.bytes);
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        hmacString = [hmacString stringByAppendingFormat:@"%02x", dataPointer[i]];
    }
    
    return hmacString;
}

+(NSString *)currentDateTimeInISO8601
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)generateRequestUrl
{
    NSString *baseUrl = @"http://timetableapi.ptv.vic.gov.au";
    NSString *healthCheckUrl = @"/v2/healthcheck";
    NSString *currentDateTimeInISO8601 = [self currentDateTimeInISO8601];
    
    NSDictionary *apiSecrets = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"]];
    NSString *devId = [apiSecrets valueForKey:@"DevId"];
    NSString *preHmacUrl = [NSString stringWithFormat:@"%@%@%@%@%@", healthCheckUrl, @"?timestamp=", currentDateTimeInISO8601, @"&devid=", devId];
    
    NSString *hmac = [self createHmacSignature:preHmacUrl];
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@%@%@", baseUrl, preHmacUrl, @"&signature=", hmac];
    
    return fullUrl;
}

+(PTVHealthCheck *)parseHealthCheckResponse:(NSData *)rawData
{
    NSError* error;
    NSDictionary *rawDataToDictionary = [NSJSONSerialization JSONObjectWithData:rawData options:NSJSONReadingMutableLeaves error:&error];
    // Use NSArray rather than NSDictionary to speed up conversion to PTVHealthCheckModel
    PTVHealthCheck *processedData = [[PTVHealthCheck alloc]
                                    initWithData:[rawDataToDictionary objectForKey:@"clientClockOK"]
                                    securityTokenOk:[rawDataToDictionary objectForKey:@"securityTokenOK"]
                                    memCacheOk:[rawDataToDictionary objectForKey:@"memcacheOK"]
                                    databaseOk:[rawDataToDictionary objectForKey:@"databaseOK"]];
    return processedData;
}

+(NSData *)saveData:(PTVHealthCheck *)healthCheckData
{
    // NSKeyedArchiver: serialises and stores object in memory, NSData is the memory address to archived data.
    NSData *dataLocation = [NSKeyedArchiver archivedDataWithRootObject:healthCheckData];
    return dataLocation;
}

+(void)ptvAPIHealthCheck
{
    NSString *fullUrl = [self generateRequestUrl];
    
    NSURLSession *apiSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *apiUrl = [NSURL URLWithString:fullUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:apiUrl];
    NSURLSessionDataTask *task = [apiSession dataTaskWithRequest:urlRequest
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                        PTVHealthCheck* healthCheckData = [self parseHealthCheckResponse:data];
                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"HealthCheckData" object:[self saveData:healthCheckData]];
                                    }];
    [task resume];
}
@end