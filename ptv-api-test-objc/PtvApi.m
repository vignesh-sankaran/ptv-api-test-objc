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
    
    NSURLSession *apiSession = [NSURLSession sharedSession];
    NSURL *apiUrl = [NSURL URLWithString: fullUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:apiUrl];
    [apiSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(fullUrl);
        NSLog(@"This is a test to see what prints out here");
    }];
    
    return nil;
}

@end