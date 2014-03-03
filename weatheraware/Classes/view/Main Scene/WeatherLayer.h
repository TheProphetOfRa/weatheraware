//
//  WeatherLayer.h
//  weatheraware
//
//  Created by David Hodgkinson on 19/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

enum WeatherType
{
    eRain,
    eClouds,
    eSnow,
    eSunny
};

@interface WeatherLayer : CCNode
{
    enum WeatherType    _currentCondition;
    
    NSMutableArray      *_weatherSprites;
    NSMutableArray      *_parralaxSprites;
    
    NSString            *_filename, *_altFilename;
    
    CGSize _winsize;
    
    bool _leftwise;
    
}

- (id) initWithCondition:(enum WeatherType) condition;

@property (readonly) enum WeatherType currentCondition;

@end
