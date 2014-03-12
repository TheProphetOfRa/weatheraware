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
#import "CreatureStats.h"
#import "CreatureTracker.h"

#import "CCActionInstant.h"
#import "CCActionInterval.h"
#import "CCDirector.h"
#import "CCSprite.h"

@implementation BattleScene

+ (BattleScene *) sceneWithWeatherCondition:(WeatherType) condition {
    return [[self alloc] initWithWeatherCondition:condition];
}

- (id) initWithWeatherCondition:(WeatherType) condition {
    
    if (self = [super init])
    {
        _condition = condition;
        [self initEnemy];
        _ui = [[BattleUILayer alloc] initWithCreatureName:[_creature creatureName] andButtonDelegate:self];
        [self addChild:_ui z:1];
    }
    return self;
}

- (void) initEnemy
{
    switch (_condition)
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
    [_creature setPosition:ccp([self contentSize].width - [_creature contentSize].width, [self contentSize].height - [_creature contentSize].height)];
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
            float percentage = (float)[_creature fightEffect]/(float)[_creature maxHealth];
            [[_ui frame] reduceHealthBy:percentage];
            if ([_creature interest] <= 0)
            {
                [_ui printLabelWithString:@"The creature fled!"];
                [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.9f], [CCActionCallFunc actionWithTarget:self selector:@selector(transition)], nil]];
            }
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
