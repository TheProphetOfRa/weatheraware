//
//  Creature.m
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Creature.h"

#import "JsonLoader.h"
#import "Object.h"
#import "MetricManager.h"

@implementation Creature

- (id) initWithType:(CreatureType)type
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
    
    switch (_type)
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
    
    _maxHealth = (int)[[data objectForKey:@"maxhealth"] integerValue];
    _interest = (int)[[data objectForKey:@"interest"] integerValue];
    _fightEffect = (int)[[data objectForKey:@"fighteffect"] integerValue];
    _foodEffect = (int)[[data objectForKey:@"foodeffect"] integerValue];
    _baseCapRate = (int)[[data objectForKey:@"caprate"] integerValue];
    _filename = [data objectForKey:@"filename"];
    _creatureName = [data objectForKey:@"creaturename"];
    
    _health = _maxHealth;
    _maxInterest = _interest;
    
    [[MetricManager sharedManager] sawCreature:_creatureName];
    
}

- (void) initSprite
{
    _tile = [[Object alloc] initWithTextureName:_filename andType:eActor];
    [self addChild:_tile];
    [self setContentSize:[_tile contentSize]];
}

- (void) fight
{
    _interest -= _fightEffect;
    _health -= _fightEffect;
}

- (void) feed
{
    _interest += _foodEffect;
    if (_interest > _maxInterest)
        _interest = _maxInterest;
}

- (BOOL) tryCapture
{
    return (rand()%100 < (_baseCapRate + ((_maxHealth - _health) * 0.3)));
}

@end
