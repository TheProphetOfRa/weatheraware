//
//  MainScene.m
//  honoursproject
//
//  Created by David Hodgkinson on 17/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "MainScene.h"

#import "Actor.h"
#import "BackgroundLayer.h"
#import "DeviceInformation.h"
#import "GrassLayer.h"
#import "Grid.h"
#import "JsonLoader.h"
#import "LongGrass.h"
#import "Object.h"
#import "WeatherLayer.h"

@implementation MainScene

+ (MainScene *) scene
{
    return [[self alloc] init];
}

#pragma mark -
#pragma mark Initialisation

- (id)init
{
    if ((self = [super init]))
    {
        [self initLocation];
                
        NSDictionary* levelData;
        
        //Detect which device and load appropriate JSON data
        if ([[DeviceInformation getDeviceType] isEqual: @"iPad"])
        {
            levelData = [JsonLoader loadJsonFromFile:@"mainscene-ipad.json"];
        }
        else
        {
            levelData = [JsonLoader loadJsonFromFile:@"mainscene-iphone.json"];
        }
        
        [self initBackgroundFromData:levelData];
        
        [self initPlayer];
        
        [self initMisc];
    }
    return self;
}

- (void) initLocation
{
    // get physical location
    _locationManager = [[LocationGetter alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager startUpdates];
}

- (void) initBackgroundFromData:(NSDictionary*) data
{
    //Create background layer and add it to scene
    _background = [[BackgroundLayer alloc] initWithJSONData:data];
    [self addChild:_background z:0];
}

- (void) initPlayer
{
    //Create actor and add it to middle of scene
    _actor = [[Actor alloc] initWithFilename:@"Character128.png"];

    [self addChild:_actor z:1];
}

- (void) initMisc
{
    //Enable user interaction
    self.userInteractionEnabled = YES;

    //Store the corners for the movement code
    _a = ccp(0, [self contentSize].height);
    _b = ccp([self contentSize].width, [self contentSize].height);
    _c = ccp([self contentSize].width, 0);
    _d = ccp (0, 0);
}

#pragma mark -
#pragma mark TouchDetection

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    _currentTouch = touch;
}
- (void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _currentTouch = nil;
}
-(void) touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    _currentTouch = nil;
}

#pragma mark -
#pragma mark Update

-(void)update:(CCTime)delta
{
    if (_currentTouch != nil) {
        [self movePlayer];
    }
}

#pragma mark -
#pragma mark Movement

- (void) movePlayer
{
    CGPoint relativeTouchPoint;
    
    //Calculate touch point relative to sprite relative to center
    relativeTouchPoint.x = ([self contentSize].width/2) - ([_actor position].x - [_currentTouch locationInNode:self].x);
    relativeTouchPoint.y = ([self contentSize].height/2) - ([_actor position].y - [_currentTouch locationInNode:self].y);
    
    //Create two diagonal lines from corner to corner
    bool isAboveAC = ((_c.x - _a.x) * (relativeTouchPoint.y - _a.y) - (_c.y - _a.y) * (relativeTouchPoint.x - _a.x)) > 0;
    bool isAboveDB = ((_b.x - _d.x) * (relativeTouchPoint.y - _d.y) - (_b.y - _d.y) * (relativeTouchPoint.x - _d.x)) > 0;
    
    if (isAboveAC)
    {
        if (isAboveDB)
        {
            //top edge has intersected
            [_actor moveInDirection:0];
        }
        else
        {
            //right edge intersected
            [_actor moveInDirection:3];
        }
    }
    else
    {
        if (isAboveDB)
        {
            //left edge has intersected
            [_actor moveInDirection:2];
        }
        else
        {
            //bottom edge intersected
            [_actor moveInDirection:1];
        }
    }
}

#pragma mark -
#pragma mark LocationManagerDelegateMethod

- (void)newPhysicalLocation:(CLPlacemark *)location
{
    
    // Store for later use
    _lastKnownLocation = location;
    
    //create query string
    //NSString *query = [NSString stringWithFormat:@"http://mruniverse.theprophetofra.com/~theprophetofra/forward/weather?lat=%f&lon=%f", location.location.coordinate.latitude, location.location.coordinate.longitude];
    NSString *query = [NSString stringWithFormat:@"http://www.paperweightsolutions.co.uk/DavidHodgkinson/weather?lat=%f&lon=%f", _lastKnownLocation.location.coordinate.latitude, _lastKnownLocation.location.coordinate.longitude];
    
    //allocate a weather controller and hand it the query string
    WeatherController *controller = [[WeatherController alloc] initWithQuery:query];
    
    //give the weather controller something to call back to when the hrrp request completes
    [controller setDelegate:self];
    
    //run the query
    [controller runQuery];

}

#pragma mark - 
#pragma mark WeatherControllerDelegateMethod

- (void) newWeatherCondition:(NSString*)condition
{
    //print location
    [[_background label] setString:condition];
    if ([condition isEqualToString:@"Rain"])
    {
        _weather = [[WeatherLayer alloc] initWithCondition:eRain];
        [self addChild:_weather z:2];
    }
    else if ([condition isEqualToString:@"Snow"])
    {
        _weather = [[WeatherLayer alloc] initWithCondition:eSnow];
        [self addChild:_weather z:2];
    }
    else if ([condition isEqualToString:@"Clouds"])
    {
        _weather = [[WeatherLayer alloc] initWithCondition:eClouds];
        [self addChild:_weather z:2];
    }
}

-(void) tryNextServer
{
    //create query string
    NSString *query = [NSString stringWithFormat:@"http://www.paperweightsolutions.co.uk/DavidHodgkinson/weather?lat=%f&lon=%f", _lastKnownLocation.location.coordinate.latitude, _lastKnownLocation.location.coordinate.longitude];
    
    //allocate a weather controller and hand it the query string
    WeatherController *controller = [[WeatherController alloc] initWithQuery:query];
    
    //give the weather controller something to call back to when the hrrp request completes
    [controller setDelegate:self];
    
    //run the query
    [controller runQuery];
}

@end
