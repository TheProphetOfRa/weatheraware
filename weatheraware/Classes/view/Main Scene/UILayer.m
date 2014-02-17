//
//  UILayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "UILayer.h"

@implementation UILayer

- (id) initWithDirection:(CCLayoutBoxDirection)direction
{
    if (self = [super init])
    {
        _menuContainer = [[CCLayoutBox alloc] init];
        [_menuContainer setDirection:direction];
        _menu = [[CCScrollView alloc] initWithContentNode:_menuContainer];
        [self addChild:_menu];
    }
    return self;
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
