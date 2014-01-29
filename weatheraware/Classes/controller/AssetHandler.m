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

+ (AssetHandler*) sharedAssetHandler {
    @synchronized([AssetHandler class]) {
        if (!_sharedAssetHandler) {
            _sharedAssetHandler = [[self alloc] init];
            [_sharedAssetHandler initTPages];
        }
        return _sharedAssetHandler;
    }
    return nil;
}

- (void) initTPages {
    //_objectAtlas = [SKTextureAtlas atlasNamed:@"objects"];
    //_shadowAtlas = [SKTextureAtlas atlasNamed:@"shadows"];
}
//- (SKTexture*) getTextureWithName:(NSString *)textureName fromPageWithName:(NSString *)pageName {
//    return ([pageName isEqualToString:@"shadow"]) ? [_shadowAtlas textureNamed:[NSString stringWithFormat:@"%@-shadow", textureName]] : [_objectAtlas textureNamed:textureName];
//}

@end
