//
//  BattleScene.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "BattleScene.h"

#import "AssetHandler.h"
#import "BattleUILayer.h"
#import "CCDirector.h"
#import "CCSprite.h"

@implementation BattleScene

+ (BattleScene *) scene {
    return [[self alloc] init];
}

- (id) init {
    
    if (self = [super init])
    {
        _ui = [[BattleUILayer alloc] init];
        [self addChild:_ui];
        
        _sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Tree128.png"]];
        [_sprite setPosition:ccp([self contentSize].width/2, [self contentSize].height/2)];
        [self addChild:_sprite];
        
    }
    return self;
}

@end
