//
//  WeatherLayer.h
//  weatheraware
//
//  Created by David Hodgkinson on 19/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

typedef enum
{
    eRain,
    eClouds,
    eSnow,
    eSunny
}WeatherType;

@interface WeatherLayer : CCNode
{
    WeatherType    _currentCondition;
    
    NSMutableArray      *_weatherSprites;
    NSMutableArray      *_parralaxSprites;
    
    NSString            *_filename, *_altFilename;
    
    CGSize _winsize;
    
    bool _leftwise;
    
}

- (id) initWithCondition:(WeatherType) condition;

@property (readonly) WeatherType currentCondition;

@end
