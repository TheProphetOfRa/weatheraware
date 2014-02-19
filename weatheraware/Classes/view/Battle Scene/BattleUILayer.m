//
//  BattleUILayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 19/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "BattleUILayer.h"

#import "CCActionInstant.h"
#import "CCActionInterval.h"
#import "CCButton.h"
#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCTransition.h"

@implementation BattleUILayer

static const int kRunChance = 30;

- (id) init
{
    if (self = [super init])
    {
        [self setContentSize:[[CCDirector sharedDirector] viewSize]];
        [self initMenu];
        [self initLabel];
    }
    return self;
}

- (void) initMenu
{
    _fightButton = [CCButton buttonWithTitle:@"Fight" fontName:@"Helvetica" fontSize:72.0f];
    _feedButton = [CCButton buttonWithTitle:@"Feed" fontName:@"Helvetica" fontSize:72.0f];
    _captureButton = [CCButton buttonWithTitle:@"Capture" fontName:@"Helvetica" fontSize:72.0f];
    _runButton = [CCButton buttonWithTitle:@"Run" fontName:@"Helvetica" fontSize:72.0f];
    
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
