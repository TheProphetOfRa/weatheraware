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
@class CreatureStats;

@interface BattleUILayer : CCNode
{
    CCButton        *_fightButton;
    CCButton        *_feedButton;
    CCButton        *_captureButton;
    CCButton        *_runButton;
    
    CreatureStats   *_frame;
    
    CCLabelBMFont   *_infoLabel;
}
@end
