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

enum ButtonType
{
    eFight,
    eFeed,
    eCapture,
    eRun
};

@protocol  UIButtonDelegate
@required
/**
 *@brief Called when the user presses a button
 *@param button The button ID of the pressed button
 */
- (void) buttonPressed:(enum ButtonType) button;
@end

@interface BattleUILayer : CCNode
{
    CCButton        *_fightButton;
    CCButton        *_feedButton;
    CCButton        *_captureButton;
    CCButton        *_runButton;
    
    CreatureStats   *_frame;
    
    CCLabelBMFont   *_infoLabel;
    
    id              _delegate;
}

- (id) initWithCreatureName:(NSString*) name;

- (void) printLabelWithString:(NSString*) string;

@property (readonly) CreatureStats *frame;

@end
