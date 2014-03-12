//
//  CustomButton.m
//  weatheraware
//
//  Created by David Hodgkinson on 08/03/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CustomButton.h"

#import "DeviceInformation.h"

@implementation CustomButton

+ (id) buttonWithTitle:(NSString *)title spriteFrame:(CCSpriteFrame *)spriteFrame andFont:(NSString *)fntFile
{
    return [[self alloc] initWithTitle:title spriteFrame:spriteFrame andFont:fntFile];
}

- (id) initWithTitle:(NSString *)title spriteFrame:(CCSpriteFrame *)spriteFrame andFont:(NSString *)fntFile
{
    if (self = [super initWithTitle:@"" spriteFrame:spriteFrame])
    {
        _label = [CCLabelBMFont labelWithString:title fntFile:fntFile];
        [_label setAlignment:CCTextAlignmentCenter];
        if ([[DeviceInformation getDeviceType] isEqualToString:@"iPad"])
        {
            if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1)
            {
                [_label setAnchorPoint:ccp(0.5, 0)];
            }
            else
            {
                [_label setAnchorPoint:ccp(0.5, 0.5)];
            }
        }
        else
        {
            [_label setAnchorPoint:ccp(0.5, 0)];
        }
        [_label setPosition:ccp([self contentSize].width/2,[self contentSize].height/2)];
        [_label setColor:[CCColor colorWithWhite:0.0f alpha:255.0f]];
        [self addChild:_label];
    }
    return self;
}

@end
