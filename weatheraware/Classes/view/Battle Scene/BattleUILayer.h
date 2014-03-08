//
//  BattleUILayer.h
//  weatheraware
//
//  Created by David Hodgkinson on 19/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class CustomButton;
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
    CustomButton        *_fightButton;
    CustomButton        *_feedButton;
    CustomButton        *_captureButton;
    CustomButton        *_runButton;
    
    CreatureStats   *_frame;
    
    CCLabelBMFont   *_infoLabel;
    
    id              _delegate;
}

- (id) initWithCreatureName:(NSString*) name andButtonDelegate:(id) delegate;

- (void) printLabelWithString:(NSString*) string;

@property (readonly) CreatureStats *frame;

@end
