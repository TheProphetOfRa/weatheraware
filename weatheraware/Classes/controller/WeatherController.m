//
//  WeatherController.m
//  honoursproject
//
//  Created by David Hodgkinson on 18/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "WeatherController.h"

@implementation WeatherController

- (WeatherController *) initWithQuery:(NSString *)query {
    
    if (self = [super init]){
        _query = query;
    }
    
    return self;
}

- (void)runQuery {
        
    NSAssert(_delegate, @"No weather delegate set");

    NSError *error = nil;
    
    NSData *data= [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_query] options:NSDataReadingMappedIfSafe error:&error];
    
    if (!data) {
        [_delegate newWeatherCondition:@"Unable to pull data"];
        return;
    }
    
    NSDictionary *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

    if (! dataArray) {
        [_delegate newWeatherCondition:@"Unable to parse data"];
        return;
    }
    
    NSArray *weather = [dataArray objectForKey:@"weather"];
    
    if (!weather) {
        [_delegate newWeatherCondition:@"Unable to extract weather information"];
        return;
    }
        
    NSDictionary *weatherInfo = [weather objectAtIndex:0];
    
    if (!weatherInfo) {
        [_delegate newWeatherCondition:@"Unable to extract main weather condition"];
    }
    
    _condition = [weatherInfo objectForKey:@"main"];
    
    [_delegate newWeatherCondition:_condition];
}
@end