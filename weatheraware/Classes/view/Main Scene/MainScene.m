//
//  MainScene.m
//  honoursproject
//
//  Created by David Hodgkinson on 17/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "MainScene.h"

#import "BackgroundLayer.h"

@implementation MainScene

+ (MainScene *) scene {
    
    return [[self alloc] init];
    
}

- (id)init {
    
    if ((self = [super init])) {
        
        // get physical location
        _locationManager = [[LocationGetter alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager startUpdates];
        
        _background = [[BackgroundLayer alloc] init];
        [self addChild:_background z: 0];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [_locationManager startUpdates];
}

-(void)update {
    /* Called before each frame is rendered */
}

#pragma mark -
#pragma mark LocationManagerDelegateMethod

- (void)newPhysicalLocation:(CLPlacemark *)location {
    
    // Store for later use
    _lastKnownLocation = location;
    
    NSString *query = [NSString stringWithFormat:@"http://mruniverse.theprophetofra.com/~theprophetofra/forward/weather?lat=%f&lon=%f", location.location.coordinate.latitude, location.location.coordinate.longitude];
    
    WeatherController *controller = [[WeatherController alloc] initWithQuery:query];
        
    [controller setDelegate:self];
    
    [controller runQuery];

}

#pragma mark - 
#pragma mark WeatherControllerDelegateMethod

- (void) newWeatherCondition:(NSString*)condition {
    //print location
    [[_background label] setString:condition];
}

@end
