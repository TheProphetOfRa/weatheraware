//
//  BattleScene.h
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class Creature;
@class BattleUILayer;

@interface BattleScene : CCNode
{
    Creature      *_creature;

    BattleUILayer *_ui;
}

+ (BattleScene*) scene;

@end
