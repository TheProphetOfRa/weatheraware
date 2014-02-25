//
//  LocationManager.m
//  honoursproject
//
//  Created by David Hodgkinson on 17/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationGetter

BOOL didUpdate = NO;

- (void)startUpdates
{
    //create a CoreLoation manager instance if one doesn't exist
    if (_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    //set the CoreLocation manager delegate to self
    _locationManager.delegate = self;
    
    //update the location if the phone moves more than i km
    _locationManager.distanceFilter = 1000;
    
    //Grab a rough location as accuracy is not needed, this will save power
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //start the location update
    [_locationManager startUpdatingLocation];
}

- (void) updateLocation
{
    //update the location if the location manager has been instansiated
    if (_locationManager != nil) [_locationManager startUpdatingLocation];
}

#pragma mark -
#pragma mark CLLocationManagerDelegateFunctions

/**
 *@brief Called when CoreLocation manager returns an error
 *@param manager The manager returning the error
 *@param error An error object containing the details of the failure
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your location could not be determined. Please check your internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

/**
 *@brief Called when CoreLocation manager returns with success
 *@param manager The successful CoreLocation manager
 *@param newLocation The new location information contained in a CLLocation object
 *@param oldLocation The old location which has just been updated
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
        
    NSAssert(_delegate, @"No location delegate defined!");

    if (didUpdate)
        return;
    
    _currentCoords = newLocation.coordinate;
    
    //create a CoreLocation geocoder object to reverse geocode the location
    const CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (!error)
        {
            [_delegate newPhysicalLocation:[placemarks objectAtIndex:0]];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your internet connection and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    didUpdate = YES;
    
    // Disable future updates to save power.
    [_locationManager stopUpdatingLocation];
}

@end
