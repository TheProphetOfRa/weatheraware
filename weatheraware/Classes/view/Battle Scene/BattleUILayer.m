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
#import "CustomButton.h"

#import "CCActionInstant.h"
#import "CCActionInterval.h"
#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCTransition.h"

@implementation BattleUILayer

static const int kRunChance = 45;

- (id) initWithCreatureName:(NSString *)name andButtonDelegate:(id) delegate
{
    if (self = [super init])
    {
        _delegate = delegate;
        [self setContentSize:[[CCDirector sharedDirector] viewSize]];
        [self initMenu];
        [self initLabel];
        [self initCreatureStatsWithName:name];
    }
    return self;
}

#pragma mark -
#pragma mark Initialisation

- (void) initMenu
{
    _fightButton = [CustomButton buttonWithTitle:@"Fight" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"] andFont:@"Font16.fnt"];
    _feedButton = [CustomButton buttonWithTitle:@"Feed" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"] andFont:@"Font16.fnt"];;
    _captureButton = [CustomButton buttonWithTitle:@"Capture" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"] andFont:@"Font16.fnt"];;
    _runButton = [CustomButton buttonWithTitle:@"Run" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar1024x256.png"] andFont:@"Font16.fnt"];
    
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
    
    [self addChild:_fightButton z:3];
    [self addChild:_feedButton z:3];
    [self addChild:_captureButton z:3];
    [self addChild:_runButton z:3];
    
}

- (void) initCreatureStatsWithName:(NSString*) name
{
    _frame = [[CreatureStats alloc] initWithCreatureName:name];
    [_frame setPosition:ccp(0, [self contentSize].height - [_frame contentSize].height/2)];
    [self addChild:_frame z:2];
}

- (void) initLabel
{
    _infoLabel = [CCLabelBMFont labelWithString:@"" fntFile:[[CCFileUtils sharedFileUtils] fullPathForFilename:@"Font32.fnt"] width:256.0f alignment:CCTextAlignmentCenter];
    [_infoLabel setPosition:ccp([self contentSize].width/2, [self contentSize].height/2)];
    [self addChild:_infoLabel z:5];
}

#pragma mark -
#pragma mark ButtonCallbacks

- (void) fightButtonPressed
{
    [_delegate buttonPressed:eFight];
}

- (void) feedButtonPressed
{
    [_delegate buttonPressed:eFeed];
}

- (void) captureButtonPressed
{
    [_delegate buttonPressed:eCapture];
}

-(void) runButtonPressed
{
    if (rand()%100 < kRunChance)
    {
        [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionCrossFadeWithDuration:0.4f]];
    }
    else
    {
        [self printLabelWithString:@"Couldn't escape"];
    }
}

#pragma mark -
#pragma mark PrintUserInfoLabel

- (void) printLabelWithString:(NSString *)string
{
    [_infoLabel setString:string];
    CCActionFadeIn* fadeIn = [CCActionFadeIn actionWithDuration:0.3f];
    CCActionDelay* delay = [CCActionDelay actionWithDuration:0.3f];
    CCActionFadeOut* fadeOut = [CCActionFadeOut actionWithDuration:0.3f];
    CCActionCallFunc* enableUI = [CCActionCallFunc actionWithTarget:self selector:@selector(enableUserInput)];
    CCActionSequence* seq = [CCActionSequence actions:fadeIn, delay, fadeOut, enableUI, nil];
    [self disableUserInput];
    [_infoLabel runAction:seq];
}

#pragma mark -
#pragma mark ToggleUserInteraction

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
