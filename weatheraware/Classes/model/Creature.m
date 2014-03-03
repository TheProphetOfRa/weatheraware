//
//  Creature.m
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Creature.h"

#import "JsonLoader.h"
#import "AnimatedObject.h"
#import "MetricManager.h"

@implementation Creature

- (id) initWithType:(enum CreatureType)type
{    
    if (self = [super init])
    {
        _type = type;
        [self initStats];
        [self initSprite];
    }
    return self;
}

- (void) initStats
{
    NSDictionary *data;
    
    switch ((int)_type)
    {
        case eDragon:
            data = [JsonLoader loadJsonFromFile:@"dragon.json"];
            break;
        case eTurtle:
            data = [JsonLoader loadJsonFromFile:@"turtle.json"];
            break;
        case eDuck:
            data = [JsonLoader loadJsonFromFile:@"duck.json"];
            break;
        case eCrab:
            data = [JsonLoader loadJsonFromFile:@"crab.json"];
            break;
        case eBear:
            data = [JsonLoader loadJsonFromFile:@"bear.json"];
            break;
        case eFox:
            data = [JsonLoader loadJsonFromFile:@"fox.json"];
            break;
        case ePenguin:
            data = [JsonLoader loadJsonFromFile:@"penguin.json"];
            break;
        case eBird:
            data = [JsonLoader loadJsonFromFile:@"bird.json"];
            break;
            
    }
    
    _maxHealth = [[data objectForKey:@"maxhealth"] integerValue];
    _interest = [[data objectForKey:@"interest"] integerValue];
    _fightEffect = [[data objectForKey:@"fighteffect"] integerValue];
    _foodEffect = [[data objectForKey:@"foodeffect"] integerValue];
    _baseCapRate = [[data objectForKey:@"caprate"] integerValue];
    _filename = [data objectForKey:@"filename"];
    _creatureName = [data objectForKey:@"creaturename"];
    
    _health = _maxHealth;
    
    [[MetricManager sharedManager] sawCreature:_creatureName];
    
}

- (void) initSprite
{
    _tile = [[AnimatedObject alloc] initWithTextureName:_filename andType:eActor];
    [self addChild:_tile];
}

- (void) fight
{
    _interest -= _fightEffect;
}

- (void) feed
{
    _interest += _foodEffect;
}

- (BOOL) tryCapture
{
    return (rand()%100 < (_baseCapRate + ((_maxHealth - _health) * 0.3)));
}

@end
