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

@implementation Creature

- (id) initWithType:(enum CreatureType)type
{    
    if (self = [super init])
    {
        _type = type;
        [self initStats];
    }
    return self;
}

- (void) initStats
{
    NSDictionary *data;
    
    switch ((int)_type)
    {
        case eDragon:
            data = [JsonLoader loadJsonFromFile:@"Dragon.json"];
            break;
        default:
            break;
    }
    
    _health = [data objectForKey:@"health"];
    _interest = [data objectForKey:@"interest"];
    _baseCapRate = [data objectForKey:@"caprate"];
    
}

@end
