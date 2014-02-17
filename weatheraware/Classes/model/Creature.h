//
//  Creature.h
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Object.h"

#import "CreatureHandler.h"

@interface Creature : CCNode
{
    enum CreatureType    *_type;
    
    Object          *_tile;
    
    int              _health;
    
}

- (id) initWithType: (enum CreatureType) type;

@end
