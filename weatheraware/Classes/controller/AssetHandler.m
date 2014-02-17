//
//  AssetHandler.m
//  honoursproject
//
//  Created by David Hodgkinson on 22/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import "AssetHandler.h"

@implementation AssetHandler

static AssetHandler *_sharedAssetHandler = nil;

+ (AssetHandler*) sharedAssetHandler
{
    @synchronized([AssetHandler class])
    {
        if (!_sharedAssetHandler)
        {
            _sharedAssetHandler = [[self alloc] init];
            [_sharedAssetHandler initTPages];
        }
        return _sharedAssetHandler;
    }
    return nil;
}

- (void) initTPages
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"environment.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"character.plist"];
}
- (CCSpriteFrame*) getTextureWithName:(NSString *)textureName
{
    return [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:textureName];
}

@end
