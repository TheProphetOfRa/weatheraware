//
//  LocationManager.h
//  honoursproject
//
//  Created by David Hodgkinson on 17/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationGetterDelegate
@required
/**
 *@brief Called when a new location is obtained
 *@param location The new location
 */
- (void) newPhysicalLocation:(CLPlacemark *)location;
@end

@interface LocationGetter : NSObject <CLLocationManagerDelegate>
{
    ///CoreLocation manager instance
    CLLocationManager *_locationManager;
    ///Currently saved coordinates
    CLLocationCoordinate2D _currentCoords;
    ///Delegate to be fired when location has been updated
    id _delegate;
}

///Call the first time location should be updated to initialise class
- (void)startUpdates;
///Call when location should be updated but class has already been initialised
- (void)updateLocation;

@property (nonatomic) CLLocationCoordinate2D currentCoords;
@property(nonatomic , retain) id delegate;
@end
