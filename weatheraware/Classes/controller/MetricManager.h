//
//  MetricManager.h
//  weatheraware
//
//  Created by David Hodgkinson on 27/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetricManager : NSObject <NSURLConnectionDelegate>
{
    NSMutableDictionary    *_metrics;
    float _lat, _lon;
}

+ (MetricManager*) sharedManager;

- (void) sendDataWithLat:(float) lat andLon:(float) lon;

- (void) capturedCreature:(NSString*) creatureName;
- (void) sawCreature:(NSString*) creatureName;
- (void) updateValue:(id) value forKey:(NSString*) key;
- (void) addWeatherCondition:(NSString*) weather;

@end
