//
//  Creature.h
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

enum CreatureType
{
    eDragon,
    eTurtle,
    eDuck,
    eCrab,
    eBear,
    eFox,
    ePenguin,
    eBird
};

@class AnimatedObject;

@interface Creature : CCNode
{
    enum CreatureType    *_type;
    
    AnimatedObject       *_tile;
    
    NSString             *_filename;
    
    NSString             *_creatureName;
    
    int                   _health;
    int                   _maxHealth;
    int                   _interest;
    int                   _foodEffect;
    int                   _fightEffect;
    int                   _baseCapRate;
    
}

- (id) initWithType: (enum CreatureType) type;

- (void) fight;
- (void) feed;
- (BOOL) tryCapture;

@property (readonly) AnimatedObject *tile;
@property (readonly) NSString *creatureName;

@end
