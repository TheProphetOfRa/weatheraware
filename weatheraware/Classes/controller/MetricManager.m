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
        _metrics = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) sendDataWithLat:(float) lat andLon:(float) lon
{
    
    _lat = lat;
    _lon = lon;
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://davidh.us-lot.org/cgi-bin/savejson.cgi?%@", [self formatData]];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/json" forHTTPHeaderField:@"Accept"];
        
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [conn scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [conn start];

}

- (NSString*) formatData
{
    NSString* data;
    NSString* encodedData;
    NSString* userID = [NSString stringWithFormat:@"%@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    NSError* error;
    
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:_metrics options:nil error:&error];
    
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    data = [NSString stringWithFormat:@"user=%@&lat=%f&lon=%f&jsonstring={\"UUID\":\"%@\", \"metrics\":\"%@\"}",userID , _lat, _lon, userID, jsonString];
    
    encodedData = [data stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    return encodedData;
}

- (void) capturedCreature:(NSString *)creatureName
{
    NSMutableArray *creaturesSeen = [_metrics objectForKey:@"captured"];
    if (creaturesSeen == nil)
    {
        creaturesSeen = [[NSMutableArray alloc] initWithObjects:creatureName, nil];
    }
    else
    {
        [creaturesSeen addObject:creatureName];
    }
    [_metrics setObject:creaturesSeen forKey:@"captured"];
}

- (void) sawCreature:(NSString *)creatureName
{
    NSMutableArray *creaturesSeen = [_metrics objectForKey:@"creaturesSeen"];
    if (creaturesSeen == nil)
    {
        creaturesSeen = [[NSMutableArray alloc] initWithObjects:creatureName, nil];
    }
    else
    {
        [creaturesSeen addObject:creatureName];
    }
    [_metrics setObject:creaturesSeen forKey:@"creaturesSeen"];
}

- (void) updateValue:(id)value forKey:(NSString *)key
{
    [_metrics setObject:value forKey:key];
}

- (void) addWeatherCondition: (NSString *) weather
{
    NSMutableArray *creaturesSeen = [_metrics objectForKey:@"weather"];
    if (creaturesSeen == nil)
    {
        creaturesSeen = [[NSMutableArray alloc] initWithObjects:weather, nil];
    }
    else
    {
        [creaturesSeen addObject:weather];
    }
    [_metrics setObject:creaturesSeen forKey:@"weather"];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"\nError: %@\n", error);
    NSLog(@"Error Code: %ld\n", (long)error.code);
    NSLog(@"Error Type: %@\n", error.domain);
    NSLog(@"Error Help: %@\n", error.localizedRecoveryOptions);
    NSLog(@"Error Reason: %@\n", error.localizedFailureReason);
}

@end
