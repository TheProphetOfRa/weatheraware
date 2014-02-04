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

@implementation MainScene

+ (MainScene *) scene {
    
    return [[self alloc] init];
    
}

- (id)init {
    
    if ((self = [super init])) {
        
        // get physical location
        _locationManager = [[LocationGetter alloc] init];
        [_locationManager setDelegate:self];
        //[_locationManager startUpdates];
        
        self.userInteractionEnabled = YES;
        
        _background = [[BackgroundLayer alloc] init];
        [self addChild:_background z:0];
        
        
        _actor = [[Actor alloc] initWithFilename:@"longgrass.png"];
        [_actor setPosition:ccp([self contentSize].width/2, [self contentSize].height/2)];
        [self addChild:_actor z:1];
        
        _a = ccp(0, [self contentSize].height);
        _b = ccp([self contentSize].width, [self contentSize].height);
        _c = ccp([self contentSize].width, 0);
        _d = ccp (0, 0);
        
    }
    return self;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    bool isAboveAC = ((_c.x - _a.x) * (touch.locationInWorld.y - _a.y) - (_c.y - _a.y) * (touch.locationInWorld.x - _a.x)) > 0;
    bool isAboveDB = ((_b.x - _d.x) * (touch.locationInWorld.y - _d.y) - (_b.y - _d.y) * (touch.locationInWorld.x - _d.x)) > 0;
    
    if (isAboveAC)
    {
        if (isAboveDB)
        {
            //top edge has intersected
            [_actor moveInDirection:0];
            NSLog(@"Moving Up");
        }
        else
        {
            //right edge intersected
            [_actor moveInDirection:3];
            NSLog(@"Moving Right");
        }
    }
    else
    {
        if (isAboveDB)
        {
            //left edge has intersected
            [_actor moveInDirection:2];
            NSLog(@"Moving Left");
        }
        else
        {
            //bottom edge intersected
            [_actor moveInDirection:1];
            NSLog(@"Moving Down");
        }
    }
}

-(void)update {
    /* Called before each frame is rendered */
}

#pragma mark -
#pragma mark LocationManagerDelegateMethod

- (void)newPhysicalLocation:(CLPlacemark *)location {
    
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

- (void) newWeatherCondition:(NSString*)condition {
    //print location
    [[_background label] setString:condition];
}

@end
