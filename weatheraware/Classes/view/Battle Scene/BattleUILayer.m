//
//  BattleUILayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 19/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "BattleUILayer.h"

#import "AssetHandler.h"
#import "CreatureStats.h"

#import "CCActionInstant.h"
#import "CCActionInterval.h"
#import "CCButton.h"
#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCTransition.h"

@implementation BattleUILayer

static const int kRunChance = 450;

- (id) init
{
    if (self = [super init])
    {
        [self setContentSize:[[CCDirector sharedDirector] viewSize]];
        [self initMenu];
        [self initLabel];
        [self initCreatureStats];
    }
    return self;
}

- (void) initMenu
{
    _fightButton = [CCButton buttonWithTitle:@"Fight" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"]];
    _feedButton = [CCButton buttonWithTitle:@"Feed" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"]];;
    _captureButton = [CCButton buttonWithTitle:@"Capture" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"]];;
    _runButton = [CCButton buttonWithTitle:@"Run" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"]];
    
    [_fightButton setAnchorPoint:ccp(0,0)];
    [_feedButton setAnchorPoint:ccp(0,0)];
    [_captureButton setAnchorPoint:ccp(0,0)];
    [_runButton setAnchorPoint:ccp(0,0)];
    
    [_captureButton setPosition:ccp(0,0)];
    [_runButton setPosition:ccp([self contentSize].width/2, 0)];
    [_fightButton setPosition:ccp(0, [_captureButton contentSize].height)];
    [_feedButton setPosition:ccp([self contentSize].width/2, [_runButton contentSize].height)];
    
    [_fightButton setTarget:self selector:@selector(fightButtonPressed)];
    [_feedButton setTarget:self selector:@selector(feedButtonPressed)];
    [_captureButton setTarget:self selector:@selector(captureButtonPressed)];
    [_runButton setTarget:self selector:@selector(runButtonPressed)];
    
    [self addChild:_fightButton];
    [self addChild:_feedButton];
    [self addChild:_captureButton];
    [self addChild:_runButton];
    
}

- (void) initCreatureStats
{
    _frame = [[CreatureStats alloc] init];
    [_frame setPosition:ccp(0, [self contentSize].height - ([_frame contentSize].height/4))];
    [self addChild:_frame];
}

- (void) initLabel
{
    _infoLabel = [[CCLabelBMFont alloc] initWithString:@"Label" fntFile:@"FontNormal.fnt" width:[self contentSize].width/3 alignment:CCTextAlignmentCenter];
    [_infoLabel setPosition:ccp([self contentSize].width/2, [self contentSize].height/2)];
    [_infoLabel setOpacity:0.0f];
    [self addChild:_infoLabel];
}

- (void) fightButtonPressed
{
    printf("Fight");
}

- (void) feedButtonPressed
{
    printf("Feed");
}

- (void) captureButtonPressed
{
    printf("Capture");
}

-(void) runButtonPressed
{
    printf("Run");
    if (rand()%100 < kRunChance)
    {
        [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionCrossFadeWithDuration:0.4f]];
    }
    else
    {
        [_infoLabel setString:@"Couldn't escape!"];
        CCActionFadeIn* fadeIn = [CCActionFadeIn actionWithDuration:0.3f];
        CCActionDelay* delay = [CCActionDelay actionWithDuration:0.3f];
        CCActionFadeOut* fadeOut = [CCActionFadeOut actionWithDuration:0.3f];
        CCActionCallFunc* enableUI = [CCActionCallFunc actionWithTarget:self selector:@selector(enableUserInput)];
        CCActionSequence* seq = [CCActionSequence actions:fadeIn, delay, fadeOut, enableUI, nil];
        [self disableUserInput];
        [_infoLabel runAction:seq];
    }
}

- (void) disableUserInput
{
    [_fightButton setEnabled:false];
    [_feedButton setEnabled:false];
    [_captureButton setEnabled:false];
    [_runButton setEnabled:false];
}

-(void) enableUserInput
{
    [_fightButton setEnabled:true];
    [_feedButton setEnabled:true];
    [_captureButton setEnabled:true];
    [_runButton setEnabled:true];
}

@end
