//
//  BattleScene.h
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCScene.h"

#import "BattleUILayer.h"

@class Creature;
@class CCSprite;

@interface BattleScene : CCScene <UIButtonDelegate>
{
    Creature      *_creature;

    BattleUILayer *_ui;
    
    CCSprite *_sprite;
}

+ (BattleScene*) scene;

@end
