//
//  WeatherController.m
//  honoursproject
//
//  Created by David Hodgkinson on 18/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "WeatherController.h"

@implementation WeatherController

- (WeatherController *) initWithQuery:(NSString *)query
{
    if (self = [super init])
    {
        _query = query;
    }
    return self;
}

- (void)runQuery
{
    NSAssert(_delegate, @"No weather delegate set");

    NSError *error = nil;
    
    NSData *data= [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_query] options:NSDataReadingMappedIfSafe error:&error];
    
    if (!data)
    {
        _condition = [self generateRandomCondition];
        [_delegate newWeatherCondition:_condition];
        return;
    }
    
    NSDictionary *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

    if (! dataArray)
    {
        _condition = [self generateRandomCondition];
        [_delegate newWeatherCondition:_condition];
        return;
    }
    
    NSString *weather = [dataArray objectForKey:@"weather"];
    
    if (!weather)
    {
        _condition = [self generateRandomCondition];
        [_delegate newWeatherCondition:_condition];
        return;
    }

    _condition = weather;
    
    [_delegate newWeatherCondition:_condition];
}

- (NSString*) generateRandomCondition
{
    NSString* c;
    
    int rnd = rand()%3;
    
    switch (rnd)
    {
        case 1:
            c = @"SuddenRain";
            break;
        case 2:
            c = @"SuddenClear";
            break;
        default:
            c = @"SuddenSnow";
            break;
    }
    return c;
}

@end
