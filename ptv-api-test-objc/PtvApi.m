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
#import "PtvApiPublic.h"
#import "PtvApiPrivate.h"

@implementation PtvApi

- (NSString *)CreateHmacSignature:(NSString *)url
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

- (NSString *)CurrentDateTimeInISO8601
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)GenerateRequestUrl
{
    NSString *baseUrl = @"http://timetableapi.ptv.vic.gov.au";
    NSString *healthCheckUrl = @"/v2/healthcheck";
    NSString *currentDateTimeInISO8601 = [self CurrentDateTimeInISO8601];
    
    NSDictionary *apiSecrets = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ApiKeys" ofType:@"plist"]];
    NSString *devId = [apiSecrets valueForKey:@"DevId"];
    NSString *preHmacUrl = [NSString stringWithFormat:@"%@%@%@%@%@", healthCheckUrl, @"?timestamp=", currentDateTimeInISO8601, @"&devid=", devId];
    
    NSString *hmac = [self CreateHmacSignature:preHmacUrl];
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@%@%@", baseUrl, preHmacUrl, @"&signature=", hmac];
    
    return fullUrl;
}

- (void)healthCheck:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    NSString *fullUrl = [self GenerateRequestUrl];
    
    NSURLSession *apiSession = [NSURLSession sharedSession];
    NSURL *apiUrl = [NSURL URLWithString: fullUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:apiUrl];
    [apiSession dataTaskWithRequest:urlRequest completionHandler:completionHandler];
}

@end