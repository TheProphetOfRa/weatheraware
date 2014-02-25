//
//  UILayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "UILayer.h"

#import "AssetHandler.h"

#import "CCButton.h"
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
    CCButton *button;
    
    button = [CCButton buttonWithTitle:@"Creature List" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"]];
    
    [button setTarget:self selector:@selector(buttonPressed)];
    
    [_menuContainer addChild:button];
    
    button = [CCButton buttonWithTitle:@"Button" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"]];
    
    [button setTarget:self selector:@selector(buttonPressed)];
    
    [_menuContainer addChild:button];
    
    button = [CCButton buttonWithTitle:@"Button" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"]];
    
    [button setTarget:self selector:@selector(buttonPressed)];
    
    [_menuContainer addChild:button];
    
    button = [CCButton buttonWithTitle:@"Button" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"]];
    
    [button setTarget:self selector:@selector(buttonPressed)];
    
    [_menuContainer addChild:button];
    
}

- (void) buttonPressed
{
    printf("Button");
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

@end
