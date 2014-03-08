//
//  UILayer.h
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

#import "CCLabelBMFont.h"
 
#import "CCLayoutBox.h"

@interface UILayer : CCNode
{    
    bool _menuOpen;
    
    CCLayoutBox *_menuContainer;
    
}

- (id) init;

- (void) toggleMenu;

@property (readonly) bool menuOpen;

@end
