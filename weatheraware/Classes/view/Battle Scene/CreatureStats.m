//
//  CreatureStats.m
//  weatheraware
//
//  Created by David Hodgkinson on 24/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CreatureStats.h"

#import "AssetHandler.h"

@implementation CreatureStats

- (id) init
{
    if (self = [super init])
    {
        _background = [CCSprite spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"UITest.png"]];
        [_background setPosition:ccp(_background.contentSize.width/2, 0)];
        [self addChild:_background];
        //_healthBar = [CCSprite9Slice spriteWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"healthBar.png"]];;
    }
    return self;
}

- (void) reduceHealthBy:(int)percentage
{
    
}

@end
