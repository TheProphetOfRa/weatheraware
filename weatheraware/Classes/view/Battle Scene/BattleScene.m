//
//  BattleScene.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "BattleScene.h"

#import "AssetHandler.h"
#import "Creature.h"
#import "CreatureTracker.h"

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
        [self addChild:_ui z:1];
        
        _sprite = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Test256x128.png"]];
        [_sprite setAnchorPoint:ccp(0,0)];
        [_sprite setPosition:ccp(0, 0)];
        [self addChild:_sprite z:0];
        
        [self initEnemy];
        
    }
    return self;
}

- (void) initEnemy
{
    _creature = [[Creature alloc] initWithType:eDragon];
}

- (void) attemptCapture
{
    if ([_creature tryCapture])
    {
        [[CreatureTracker sharedTracker] addCreature:[_creature creatureName]];
    }
}

#pragma mark -
#pragma mark UIButtonDelegate

- (void) buttonPressed:(enum ButtonType)button
{
    switch (button)
    {
        case eFight:
            [_creature fight];
            break;
        case eFeed:
            [_creature feed];
            break;
        case eCapture:
            [self attemptCapture];
            break;
        case eRun:
            [[CCDirector sharedDirector] popScene];
            break;
    }
}

@end
