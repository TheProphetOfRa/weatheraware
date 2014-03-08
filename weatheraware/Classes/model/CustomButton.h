//
//  CustomButton.h
//  weatheraware
//
//  Created by David Hodgkinson on 08/03/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCButton.h"

#import "CCLabelBMFont.h"

@interface CustomButton : CCButton
{
    CCLabelBMFont   *_label;
}

+ (id) buttonWithTitle:(NSString *)title spriteFrame:(CCSpriteFrame *)spriteFrame andFont:(NSString*) fntFile;

- (id) initWithTitle:(NSString *)title spriteFrame:(CCSpriteFrame*) spriteFrame andFont:(NSString*) fntFile;
@end
