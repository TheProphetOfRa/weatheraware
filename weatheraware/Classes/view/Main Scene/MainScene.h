//
//  MainScene.h
//  honoursproject
//

//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "CCScene.h"

#import "LocationManager.h"
#import "WeatherController.h"

@class Actor;
@class BackgroundLayer;
@class GrassLayer;
@class WeatherLayer;
@class UILayer;

@interface MainScene : CCScene <LocationGetterDelegate,WeatherControllerDelegate>
{
    //location information
    LocationGetter  *_locationManager;
    CLPlacemark     *_lastKnownLocation;
    
    //Layers
    BackgroundLayer *_background;
    WeatherLayer    *_weather;
    UILayer         *_ui;
    
    //Player
    Actor           *_player;
    
    //Corners of the screen
    CGPoint _a;
    CGPoint _b;
    CGPoint _c;
    CGPoint _d;
    
    //Movement
    UITouch *_currentTouch;
    
    //Time tracking
    int _sessionStart;
    
}

+(MainScene*) scene;

-(id) init;

@property (nonatomic, retain) CLPlacemark *lastKnownLocation;

@end
