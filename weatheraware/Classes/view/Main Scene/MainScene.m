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
#import "JsonLoader.h"
#import "LongGrass.h"

@implementation MainScene

+ (MainScene *) scene
{
    return [[self alloc] init];
}

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
        
        //[self initGrassFromData:levelData];
        
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

- (void) initGrassFromData:(NSDictionary*) data
{
    //Create grass layer and add it to scene
    _grass = [[GrassLayer alloc] initWithScreenSize:[self contentSize] andJSONData:data];
    [self addChild:_grass z:1];
}

- (void) initPlayer
{
    //Create actor and add it to middle of scene
    _actor = [[Actor alloc] initWithFilename:@"Character128.png"];
    [_actor setPosition:ccp([self contentSize].width/2, [self contentSize].height/2)];
    [self addChild:_actor z:2];
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

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //Create two diagonal lines from corner to corner
    bool isAboveAC = ((_c.x - _a.x) * (touch.locationInWorld.y - _a.y) - (_c.y - _a.y) * (touch.locationInWorld.x - _a.x)) > 0;
    bool isAboveDB = ((_b.x - _d.x) * (touch.locationInWorld.y - _d.y) - (_b.y - _d.y) * (touch.locationInWorld.x - _d.x)) > 0;
    
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

-(void)update
{
    NSMutableArray *gArray = [_grass grassArray];
    
    LongGrass *grass = [gArray firstObject];
    
    CGPoint playerGridPos;
    playerGridPos.x = ([_actor position].x - [grass contentSize].width/2)/[grass contentSize].width;
    playerGridPos.y = ([_actor position].y - [grass contentSize].height/2)/[grass contentSize].height;
    
    for (LongGrass* g in gArray)
    {
        if (CGPointEqualToPoint([g gridPos], playerGridPos))
        {
            NSLog(@"Colliding");
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
    NSString *query = [NSString stringWithFormat:@"http://mruniverse.theprophetofra.com/~theprophetofra/forward/weather?lat=%f&lon=%f", location.location.coordinate.latitude, location.location.coordinate.longitude];
    
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
