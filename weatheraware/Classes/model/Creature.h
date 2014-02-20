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
    eDragon
};

@class AnimatedObject;

@interface Creature : CCNode
{
    enum CreatureType    *_type;
    
    AnimatedObject       *_tile;
    
    int                   _health;
    int                   _interest;
    int                   _baseCapRate;
    
}

- (id) initWithType: (enum CreatureType) type;

@end
