//
//  WeatherLayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 19/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "WeatherLayer.h"

#import "AssetHandler.h"

#import "CCActionInterval.h"
#import "CCDirector.h"
#import "CCSprite.h"

@implementation WeatherLayer

const static int kMoveTag = 2352387;

- (id) initWithCondition:(WeatherType) condition
{
    if (self = [super init])
    {
        _currentCondition = condition;
        _leftwise = false;
        _winsize = [[CCDirector sharedDirector] viewSize];;
        [self initSprites];
    }
    return self;
}

- (void) initSprites
{
    _filename = _altFilename =  nil;
    
    switch (_currentCondition) {
        case eRain:
            _filename = @"Rain128.png";
            _altFilename = @"RainAlt128.png";
            break;
        case eSunny:
            _filename = @"Cloud512x256.png";
            break;
        case eSnow:
            _filename = @"Snow128.png";
            _altFilename = @"SnowAlt128.png";
            break;
        case eClouds:
            _filename = @"Overcast128.png";
            break;
    }

    _weatherSprites = [[NSMutableArray alloc] init];
    
    if (_currentCondition == eRain)
    {
        [self initRain];
    }
    else if (_currentCondition == eSnow)
    {
        [self initSnow];
    }
    else if (_currentCondition == eSunny)
    {
        [self initSunny];
    }
    else if (_currentCondition == eClouds)
    {
        [self initClouds];
    }

    for (CCSprite* s in _weatherSprites)
    {
        [s runAction:[CCActionFadeIn actionWithDuration:3.0f]];
    }
    if (_parralaxSprites)
    {
        for (CCSprite* s in _parralaxSprites)
        {
            [s runAction:[CCActionFadeIn actionWithDuration:3.0f]];
        }
    }
}

-(void) initRain
{
    CCSprite* sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]];
    
    for (int i = -1 ; i < (_winsize.width/[sprite contentSize].width) + 1 ; i++)
    {
        for (int j = -1 ; j < (_winsize.height/[sprite contentSize].height) + 1 ; j++)
        {
            if (_altFilename != nil)
            {
                [sprite setAnchorPoint:ccp(0, 0)];
                [sprite setPosition:ccp((i * sprite.contentSize.width), (j * sprite.contentSize.height))];
                [_weatherSprites addObject:sprite];
                [self addChild:sprite];
                sprite = (rand()%2 < 1) ? [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]] : [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_altFilename]];
            }
        }
    }
}

- (void) initSnow
{
    CCSprite* sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]];
    
    for (int i = 0 ; i < (_winsize.width/[sprite contentSize].width) + 1 ; i++)
    {
        for (int j = 0 ; j < (_winsize.height/[sprite contentSize].height) + 1 ; j++)
        {
            if (_altFilename != nil)
            {
                [sprite setAnchorPoint:ccp(0, 0)];
                [sprite setPosition:ccp((i * sprite.contentSize.width), (j * sprite.contentSize.height))];
                [_weatherSprites addObject:sprite];
                [self addChild:sprite];
                CCActionMoveBy *action = [CCActionMoveBy actionWithDuration:3.0f position:ccp(-25.0f, -(sprite.contentSize.height))];
                [action setTag:kMoveTag];
                [sprite runAction:action];
                sprite = (rand()%2 < 1) ? [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]] : [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_altFilename]];
            }
        }
    }
    
    _parralaxSprites = [[NSMutableArray alloc] init];
    
    NSString *lightSnow, *altLightSnow;
    lightSnow = @"SnowLight128.png";
    altLightSnow = @"SnowLightAlt128.png";
    
    
    for (int i = -1 ; i < (_winsize.width/[sprite contentSize].width) ; i++)
    {
        for (int j = 0 ; j < (_winsize.height/[sprite contentSize].height) + 1 ; j++)
        {
            if (_altFilename != nil)
            {
                [sprite setAnchorPoint:ccp(0, 0)];
                [sprite setPosition:ccp((i * sprite.contentSize.width), (j * sprite.contentSize.height))];
                [_parralaxSprites addObject:sprite];
                [self addChild:sprite];
                CCActionMoveBy *action = [CCActionMoveBy actionWithDuration:3.0f position:ccp(25.0f, -(sprite.contentSize.height))];
                [action setTag:kMoveTag];
                [sprite runAction:action];
                sprite = (rand()%2 < 1) ? [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:lightSnow]] : [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:altLightSnow]];
            }
        }
    }
}

- (void) initClouds
{
    CCSprite* sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]];
    
    for (int i = 0 ; i < (_winsize.width/[sprite contentSize].width) ; i++)
    {
        for (int j = 0 ; j < (_winsize.height/[sprite contentSize].height) ; j++)
        {
            [sprite setAnchorPoint:ccp(0, 0)];
            [sprite setPosition:ccp((i * sprite.contentSize.width), (j * sprite.contentSize.height))];
            [_weatherSprites addObject:sprite];
            [self addChild:sprite];
            sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]];
        }
    }
}

- (void) initSunny
{
    CCSprite* sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]];
    
    for (int i = 0 ; i < (_winsize.height / [sprite contentSize].height)/2 ; i++)
    {
        [sprite setAnchorPoint:ccp(0, 0)];
        [sprite setPosition:ccp((_winsize.width + (sprite.contentSize.width * (rand()%6))), ((2 * i) * (sprite.contentSize.height)))];
        [_weatherSprites addObject:sprite];
        [self addChild:sprite];
        sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:_filename]];
    }
}

-(void) update:(CCTime)delta
{
    if (_currentCondition == eRain)
    {
        [self moveRain];
    }
    else if (_currentCondition == eSnow)
    {
        [self moveSnow];
    }
    else if (_currentCondition == eSunny)
    {
        [self moveSunny];
    }
}

- (void) moveRain
{
    for (CCSprite* s in _weatherSprites)
    {
        if ([s getActionByTag:kMoveTag] == nil)
        {
            [s setPosition:ccp(s.position.x + s.contentSize.width, s.position.y+ s.contentSize.height)];
            CCActionMoveBy *action = [CCActionMoveBy actionWithDuration:0.3f position:ccp(-[[_weatherSprites lastObject] contentSize].width, -[[_weatherSprites lastObject] contentSize].height)];
            [action setTag:kMoveTag];
            [s runAction:action];
        }
    }
}

- (void) moveSnow
{
    
    bool performedActionThisFrame = false;
    for (CCSprite* s in _weatherSprites)
    {
        if ([s getActionByTag:kMoveTag] == nil)
        {
            if ([s position].y < 0)
            {
                [s setPosition:ccp(s.position.x, _winsize.height)];
            }
            CCActionMoveBy *action;
            if (_leftwise == true)
            {
                action = [CCActionMoveBy actionWithDuration:3.0f position:ccp(25.0f, -[s contentSize].height)];
            }
            else
            {
                action = [CCActionMoveBy actionWithDuration:3.0f position:ccp(0.0 - 25.0f, -[s contentSize].height)];
            }
            [action setTag:kMoveTag];
            [s runAction:action];
        }
    }
    for (CCSprite* s in _parralaxSprites)
    {
        if ([s getActionByTag:kMoveTag] == nil)
        {
            performedActionThisFrame = true;
            if ([s position].y < 0)
            {
                [s setPosition:ccp(s.position.x, _winsize.height)];
            }
            CCActionMoveBy *action;
            if (_leftwise == true)
            {
                action = [CCActionMoveBy actionWithDuration:3.0f position:ccp(0- 25, -[s contentSize].height)];
            }
            else
            {
                action = [CCActionMoveBy actionWithDuration:3.0f position:ccp(25, -[s contentSize].height)];
            }
            
            [action setTag:kMoveTag];
            [s runAction:action];
        }
    }
    if (performedActionThisFrame == true)
    {
        _leftwise = (_leftwise == true) ? false : true;
    }
}

- (void) moveSunny
{
    for (CCSprite* s in _weatherSprites)
    {
        if ([s getActionByTag:kMoveTag] == nil)
        {
            [s setPosition:ccp(_winsize.width + ([s contentSize].width * (rand()%5)), s.position.y)];
            CCActionMoveBy *action = [CCActionMoveBy actionWithDuration:25.0f + rand()%8 position:ccp(0.0f - ([s position].x + [s contentSize].width), 0.0f)];
            [action setTag:kMoveTag];
            [s runAction:action];
        }
    }
}

@end
