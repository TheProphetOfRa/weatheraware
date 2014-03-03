//
//  Actor.h
//  weatheraware
//
//  Created by David Hodgkinson on 04/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "cocos2d.h"

#import "WeatherLayer.h"

@class Object;

@interface Actor : CCNode
{
    enum Direction : int{
        eUp,
        eDown,
        eLeft,
        eRight
    };
    
    Object* _tile;
    
    CGPoint _gridPos;
    
    bool moving;
    
    enum WeatherType _condition;
        
}

- (id) initWithFilename: (NSString*) filename andWeatherCondition:(enum WeatherType) cond;
- (void) moveInDirection: (enum Direction) dir;

@property (readonly) CGPoint gridPos;

@end
