//
//  WeatherController.h
//  honoursproject
//
//  Created by David Hodgkinson on 18/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeatherControllerDelegate
@required
/**
 *@brief Called when a new weather condition has been found
 *@param condition String representing the new weather condition
 */
- (void) newWeatherCondition:(NSString *) condition;
@end

@interface WeatherController : NSObject
{
    /// The current weather condition
    NSString *_condition;
    /// The URL string to query for a weather condition
    NSString *_query;
    /// Delegate to be fired when a new condition is found
    id _delegate;
}

@property (nonatomic, retain) NSString *condition;
@property (nonatomic, retain) id delegate;

/**
 *@brief Initilaise the class with a URL string to query
 *@return An instance of the WeatherContoller class
 *@param query URL string to query for weather conditions
 */
- (WeatherController *)initWithQuery:(NSString *)query;
///Run the query to obtain a weather condition
- (void)runQuery;

@end
