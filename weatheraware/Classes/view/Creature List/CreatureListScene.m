//
//  CreatureListScene.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/03/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CreatureListScene.h"

#import "AssetHandler.h"
#import "CreatureTracker.h"
#import "CustomButton.h"
#import "DeviceInformation.h"

#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCLayoutBox.h"
#import "CCScrollView.h"

@implementation CreatureListScene

+ (CreatureListScene*) scene
{
    return [[self alloc] init];
}

- (id) init
{
    if (self = [super init])
    {
        [self showCreatures];
    }
    return self;
}

- (void) showCreatures
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
        fontName = @"Font10.fnt";
    }
    
    CCLabelBMFont *label;
    
    CustomButton *button = [CustomButton buttonWithTitle:@"Back" spriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Bar512x128.png"] andFont:fontName];
    [button setTarget:self selector:@selector(end)];
    [container addChild:button];
    
    label = [CCLabelBMFont labelWithString:@"" fntFile:fontName];
    [container addChild:label];
    
    label = [CCLabelBMFont labelWithString:@"Dragon" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Dragon"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }

    label = [CCLabelBMFont labelWithString:@"Turtle" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Turtle"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }
    
    label = [CCLabelBMFont labelWithString:@"Fox" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Fox"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }
    
    label = [CCLabelBMFont labelWithString:@"Bird" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Bird"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }
    
    label = [CCLabelBMFont labelWithString:@"Bear" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Bear"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }
    
    label = [CCLabelBMFont labelWithString:@"Penguin" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Penguin"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }
    
    label = [CCLabelBMFont labelWithString:@"Crab" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Crab"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }
    
    label = [CCLabelBMFont labelWithString:@"Duck" fntFile:fontName];
    [container addChild:label];
    if ([[CreatureTracker sharedTracker] haveCaughtCreature:@"Duck"])
    {
        [label setColor:[CCColor colorWithRed:0.0f green:255.0f blue:0.0f]];
    }
    else
    {
        [label setColor:[CCColor colorWithRed:255.0f green:0.0f blue:0.0f]];
    }
    
    [container layout];
    
    //    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:container];
    //    [scrollView setHorizontalScrollEnabled:NO];
    //    [scrollView setPosition:ccp([self contentSize].width/2,[scrollView position].y)];
    [container setAnchorPoint:ccp(0.5, 1)];
    [container setPosition:ccp([self contentSize].width/2, [self contentSize].height)];
    [self addChild:container];
}

- (void) end
{
    [[CCDirector sharedDirector] popScene];
}

@end
