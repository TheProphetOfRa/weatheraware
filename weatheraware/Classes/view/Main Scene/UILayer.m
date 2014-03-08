//
//  UILayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "UILayer.h"

#import "AssetHandler.h"
#import "CreditsScene.h"
#import "CustomButton.h"
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
        _menu = [[CCScrollView alloc] initWithContentNode:_menuContainer];
        [_menu setVisible:false];
        [self addChild:_menu];
        [self initMenu];
    }
    return self;
}

- (void) initMenu
{
    CustomButton *button;
    
    button = [CustomButton buttonWithTitle:@"Creature List" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"] andFont:@"Font16.fnt"];
    
    [button setTarget:self selector:@selector(checkProgress)];
    
    [_menuContainer addChild:button];
        
    button = [CustomButton buttonWithTitle:@"Credits" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"] andFont:@"Font16.fnt"];
    
    [button setTarget:self selector:@selector(credits)];
    
    [_menuContainer addChild:button];
    
}

- (void) toggleMenu
{
    _menuOpen = !_menuOpen;
}

- (void) update:(CCTime)delta
{
    if (_menuOpen && ![_menu visible])
    {
        [_menu setVisible:true];
    }
    else if (!_menuOpen && [_menu visible])
    {
        [_menu setVisible:false];
    }
}

- (void) checkProgress
{
    printf("Check progress");
}

- (void) credits
{
    [[CCDirector sharedDirector] pushScene:[CreditsScene scene]];
}

@end
