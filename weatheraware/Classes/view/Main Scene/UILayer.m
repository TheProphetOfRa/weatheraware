//
//  UILayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "UILayer.h"

#import "AssetHandler.h"
#import "CreatureListScene.h"
#import "CreditsScene.h"
#import "CustomButton.h"
#import "DeviceInformation.h"
#import "MetricManager.h"

#import "CCDirector.h"

@implementation UILayer

- (id) init
{
    if (self = [super init])
    {
        [self setContentSize:[[CCDirector sharedDirector] viewSize]];
        _menuContainer = [[CCLayoutBox alloc] init];
        [_menuContainer setDirection:CCLayoutBoxDirectionVertical];
        [_menuContainer setVisible:false];
        [_menuContainer setAnchorPoint:ccp(1,1)];
        [_menuContainer setPosition:ccp([self contentSize].width, [self contentSize].height)];
        [self addChild:_menuContainer];
        [self initMenu];
    }
    return self;
}

- (void) initMenu
{
    CustomButton *button;
    
    NSString* fontName;
    
    if ([[DeviceInformation getDeviceType] isEqualToString:@"iPad"])
    {
        fontName = @"Font12.fnt";
    }
    else
    {
        fontName = @"Font10.fnt";
    }
    
    button = [CustomButton buttonWithTitle:@"Back" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"] andFont:fontName];
    
    [button setTarget:self selector:@selector(toggleMenu)];
    
    [_menuContainer addChild:button];
    
    button = [CustomButton buttonWithTitle:@"Credits" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"] andFont:fontName];
    
    [button setTarget:self selector:@selector(credits)];
    
    [_menuContainer addChild:button];
    
    button = [CustomButton buttonWithTitle:@"Creature List" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"] andFont:fontName];
    
    [button setTarget:self selector:@selector(checkProgress)];
    
    [_menuContainer addChild:button];
}

- (void) toggleMenu
{
    _menuOpen = !_menuOpen;
}

- (void) update:(CCTime)delta
{
    if (_menuOpen && ![_menuContainer visible])
    {
        [_menuContainer setVisible:true];
    }
    else if (!_menuOpen && [_menuContainer visible])
    {
        [_menuContainer setVisible:false];
    }
}

- (void) checkProgress
{
    [[CCDirector sharedDirector] pushScene:[CreatureListScene scene]];
}

- (void) credits
{
    [[CCDirector sharedDirector] pushScene:[CreditsScene scene]];
}

@end
