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
        _background = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"UITest.png"]];
        [_background setPosition:ccp(_background.contentSize.width/2, 0)];
        [self addChild:_background];
        //_healthBar = [CCSprite9Slice spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"healthBar.png"]];;
        [self setContentSize:[_background contentSize]];
        
        float labelOffset;
        
        if ([[DeviceInformation getDeviceType] isEqualToString:@"iPad"])
        {
            _nameLabel  = [CCLabelBMFont labelWithString:name fntFile:[[CCFileUtils sharedFileUtils] fullPathForFilename:@"Font32.fnt"]];
            labelOffset = 1.25f;
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

- (void) reduceHealthBy:(int)percentage
{
    
}

@end
