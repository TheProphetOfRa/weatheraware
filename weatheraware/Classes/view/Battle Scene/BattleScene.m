//
//  BattleScene.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "BattleScene.h"

#import "AssetHandler.h"
#import "Creature.h"
#import "CreatureTracker.h"

#import "CCActionInstant.h"
#import "CCActionInterval.h"
#import "CCDirector.h"
#import "CCSprite.h"

@implementation BattleScene

+ (BattleScene *) sceneWithWeatherCondition:(enum WeatherType) condition {
    return [[self alloc] initWithWeatherCondition:condition];
}

- (id) initWithWeatherCondition:(enum WeatherType) condition {
    
    if (self = [super init])
    {
        _ui = [[BattleUILayer alloc] init];
        [self addChild:_ui z:1];
        
        _condition = condition;
        
        [self initEnemy];
        
    }
    return self;
}

- (void) initEnemy
{
    switch ((int)_condition)
    {
        case eRain:
            _creature = (rand()%6 < 2) ? [[Creature alloc] initWithType:eDuck] : [[Creature alloc] initWithType:eCrab];
            break;
        case eSnow:
            _creature = (rand()%6 < 2) ? [[Creature alloc] initWithType:eBear] : [[Creature alloc] initWithType:ePenguin];
            break;
        case eSunny:
            _creature = (rand()%6 < 2) ? [[Creature alloc] initWithType:eDragon] : [[Creature alloc] initWithType:eTurtle];
            break;
        case eClouds:
            _creature = (rand()%6 < 2) ? [[Creature alloc] initWithType:eFox] : [[Creature alloc] initWithType:eBird];
            break;
    }
    [self addChild:_creature z:0];
}

- (void) attemptCapture
{
    if ([_creature tryCapture])
    {
        [[CreatureTracker sharedTracker] addCreature:[_creature creatureName]];
        [self runAction:[CCActionSequence actions:[CCActionCallFunc actionWithTarget:self selector:@selector(displayCaptureLabel)], [CCActionDelay actionWithDuration:1.0f], [CCActionCallFunc actionWithTarget:self selector:@selector(transition)], nil]];
    }
    else
    {
        [_ui printLabelWithString:@"Capture failed try again!"];
    }
}

- (void) displayCaptureLabel
{
    [_ui printLabelWithString:@"Capture Successful"];
}

- (void) transition
{
    [[CCDirector sharedDirector] popScene];
}

#pragma mark -
#pragma mark UIButtonDelegate

- (void) buttonPressed:(enum ButtonType)button
{
    switch (button)
    {
        case eFight:
            [_creature fight];
            break;
        case eFeed:
            [_creature feed];
            break;
        case eCapture:
            [self attemptCapture];
            break;
        case eRun:
            [[CCDirector sharedDirector] popScene];
            break;
    }
}

@end
