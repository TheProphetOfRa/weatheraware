//
//  CreditsScene.m
//  weatheraware
//
//  Created by David Hodgkinson on 08/03/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CreditsScene.h"

#import "AssetHandler.h"
#import "CustomButton.h"
#import "DeviceInformation.h"

#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCLayoutBox.h"
#import "CCScrollView.h"

@implementation CreditsScene

+ (CreditsScene*) scene
{
    return [[self alloc] init];
}

- (id) init
{
    if (self = [super init])
    {
        [self showCredits];
    }
    return self;
}

- (void) showCredits
{
    CCLayoutBox* container = [[CCLayoutBox alloc] init];
    [container setDirection:CCLayoutBoxDirectionVertical];
    [container setSpacing:16.0f];
    
    NSString* fontName;
    
    if ([[DeviceInformation getDeviceType] isEqualToString:@"iPad"])
    {
        fontName = @"Font32.fnt";
    }
    else
    {
        fontName = @"Font16.fnt";
    }

    CCLabelBMFont *label;
    
    CustomButton *button = [CustomButton buttonWithTitle:@"Back" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"] andFont:fontName];
    [button setTarget:self selector:@selector(end)];
    [container addChild:button];
    
    label = [CCLabelBMFont labelWithString:@"" fntFile:fontName];
    [container addChild:label];
    
    label = [CCLabelBMFont labelWithString:@"Font - Minecraftia by Andrew Tyler" fntFile:fontName];
    [container addChild:label];
    
    label = [CCLabelBMFont labelWithString:@"Built using Cocos2d V3" fntFile:fontName];
    [container addChild:label];
    
    label = [CCLabelBMFont labelWithString:@"Artist - Daryl Dundee" fntFile:fontName];
    [container addChild:label];
    
    label = [CCLabelBMFont labelWithString:@"Programmer - David Hodgkinson" fntFile:fontName];
    [container addChild:label];
    
    label = [CCLabelBMFont labelWithString:@"Designer - David Hodgkinson" fntFile:fontName];
    [container addChild:label];

    label = [CCLabelBMFont labelWithString:@"Credits" fntFile:fontName];
    [container addChild:label];
    
    [container layout];
    
    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:container];
    [scrollView setHorizontalScrollEnabled:NO];
    [self addChild:scrollView];
}

- (void) end
{
    [[CCDirector sharedDirector] popScene];
}
@end
