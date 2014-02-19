//
//  BattleUILayer.h
//  weatheraware
//
//  Created by David Hodgkinson on 19/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class CCButton;
@class CCLabelBMFont;

@interface BattleUILayer : CCNode
{
    CCButton    *_fightButton;
    CCButton    *_feedButton;
    CCButton    *_captureButton;
    CCButton    *_runButton;
    
    CCLabelBMFont *_infoLabel;
}
@end
