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
    NSDictionary    *_metrics;
}

- (void) sendData;
- (void) pullData;

- (void) updateValue:(id) value forKey:(NSString*) key;
- (id) getCurrentValueForKey:(NSString*) key;

@end
