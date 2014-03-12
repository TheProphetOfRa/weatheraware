//
//  Creature.h
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

typedef enum
{
    eDragon,
    eTurtle,
    eDuck,
    eCrab,
    eBear,
    eFox,
    ePenguin,
    eBird
}CreatureType;

@class Object;

@interface Creature : CCNode
{
    CreatureType         _type;
    
    Object               *_tile;
    
    NSString             *_filename;
    
    NSString             *_creatureName;
    
    int                   _health;
    int                   _maxHealth;
    int                   _interest;
    int                   _foodEffect;
    int                   _fightEffect;
    int                   _baseCapRate;
    
}

- (id) initWithType: (CreatureType) type;

- (void) fight;
- (void) feed;
- (BOOL) tryCapture;

@property (readonly) Object *tile;
@property (readonly) NSString *creatureName;
@property (readonly) int interest;
@property (readonly) int maxHealth;
@property (readonly) int fightEffect;

@end
