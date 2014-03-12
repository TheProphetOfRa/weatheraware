//
//  CreatureStats.m
//  weatheraware
//
//  Created by David Hodgkinson on 24/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CreatureStats.h"

#import "AssetHandler.h"
#import "DeviceInformation.h"

#import "CCFileUtils.h"

@implementation CreatureStats

- (id) initWithCreatureName:(NSString*) name
{
    if (self = [super init])
    {
        _background = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Container.png"]];
        [_background setPosition:ccp(_background.contentSize.width/2, 0)];
        [self addChild:_background];
        _healthBar = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"HealthBar.png"]];
        [_healthBar setPosition:ccp([_background position].x + 20 - [_healthBar contentSize].width/2, [_background position].y - 22)];
        [_healthBar setAnchorPoint:ccp(0,0.5)];
        [self addChild:_healthBar];
        [self setContentSize:[_background contentSize]];
        
        float labelOffset;
        
        if ([[DeviceInformation getDeviceType] isEqualToString:@"iPad"])
        {
            _nameLabel  = [CCLabelBMFont labelWithString:name fntFile:[[CCFileUtils sharedFileUtils] fullPathForFilename:@"Font32.fnt"]];
            if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1)
            {
                labelOffset = 1.25f;
            }
            else
            {
                labelOffset = 1.5f;
            }
        }
        else
        {
            _nameLabel  = [CCLabelBMFont labelWithString:name fntFile:[[CCFileUtils sharedFileUtils] fullPathForFilename:@"Font12.fnt"]];
            labelOffset = 1.75f;
        }
        [_nameLabel setColor:[CCColor colorWithUIColor:[UIColor blackColor]]];
        [_nameLabel setPosition:ccp([self contentSize].width/2, [self contentSize].height - [_nameLabel contentSize].height * labelOffset)];
        [self addChild:_nameLabel];
        
    }
    return self;
}

- (void) reduceHealthBy:(float)percentage
{
    [_healthBar setScaleX:([_healthBar scaleX] - percentage)];
}

@end
