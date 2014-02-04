//
//  MainScene.h
//  honoursproject
//

//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "CCScene.h"

#import "LocationManager.h"
#import "WeatherController.h"

@class BackgroundLayer;
@class Actor;

@interface MainScene : CCScene <LocationGetterDelegate,WeatherControllerDelegate> {
    
    //location information
    LocationGetter  *_locationManager;
    CLPlacemark     *_lastKnownLocation;
    
    //Layers
    BackgroundLayer *_background;
    
    Actor           *_actor;
    
    //Corners of the screen
    CGPoint _a;
    CGPoint _b;
    CGPoint _c;
    CGPoint _d;
    
}

+(MainScene*) scene;

-(id) init;

@property (nonatomic, retain) CLPlacemark *lastKnownLocation;

@end
