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
}

+ (MetricManager*) sharedManager;

- (void) sendData;

- (void) capturedCreature:(NSString*) creatureName;
- (void) sawCreature:(NSString*) creatureName;
- (void) updateValue:(id) value forKey:(NSString*) key;
- (void) addWeatherCondition:(NSString*) weather;

@end
