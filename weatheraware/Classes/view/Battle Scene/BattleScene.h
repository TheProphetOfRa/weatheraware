//
//  BattleScene.h
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCScene.h"

#import "BattleUILayer.h"
#import "WeatherLayer.h"

@class Creature;
@class CCSprite;

@interface BattleScene : CCScene <UIButtonDelegate>
{
    Creature      *_creature;

    BattleUILayer *_ui;
        
    WeatherType _condition;
}

+ (BattleScene*) sceneWithWeatherCondition:(WeatherType) condition;

@end
