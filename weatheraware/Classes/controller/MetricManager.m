//
//  MetricManager.m
//  weatheraware
//
//  Created by David Hodgkinson on 27/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "MetricManager.h"

@implementation MetricManager

static MetricManager* _sharedManager = nil;

+ (MetricManager*) sharedManager
{
    if (_sharedManager == nil)
    {
        _sharedManager = [[MetricManager alloc] init];
    }
    return _sharedManager;
}

- (id) init
{
    if (self = [super init])
    {
        [self pullData];
    }
    return self;
}

- (void) sendData
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://davidh.us-lot.org/cgi-bin/savejson.cgi?%@", [self formatData]];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/json" forHTTPHeaderField:@"Accept"];
    
    NSLog(@"%@", [request URL]);
    
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [conn scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [conn start];

}

- (NSString*) formatData
{
    NSString* data;
    NSString* encodedData;
    NSString* filename = [NSString stringWithFormat:@"%@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    
    data = [NSString stringWithFormat:@"filename=%@&jsonstring={\"UUID\":\"%@\", \"metrics\":\"%@\"}",filename ,filename, _metrics];
    
    encodedData = [data stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    return encodedData;
}

- (void) pullData
{
    NSData* data;
    NSError* error;
    
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"davidh.us-lot.org/cgi-bin/loadjson.cgi"]];
    
    if (data == nil)
    {
        _metrics = [[NSMutableDictionary alloc] init];
        printf("First time");
        return;
    }
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (json == nil)
    {
        return;
    }
    
    if (![[[json objectForKey:@"UUID"] stringValue] isEqualToString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]])
    {
        printf("Wrong UUID");
        return;
    }
    
    _metrics = [json objectForKey:@"metrics"];
    
    if (_metrics == nil)
    {
        _metrics = [[NSMutableDictionary alloc] init];
    }
}

- (void) updateValue:(id)value forKey:(NSString *)key
{
    [_metrics setValue:value forKey:key];
}

- (id) getCurrentValueForKey:(NSString*) key
{
    return [_metrics valueForKey:key];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"\nError: %@\n", error);
    NSLog(@"Error Code: %d\n", error.code);
    NSLog(@"Error Type: %@\n", error.domain);
    NSLog(@"Error Help: %@\n", error.localizedRecoveryOptions);
    NSLog(@"Error Reason: %@\n", error.localizedFailureReason);
}

@end
