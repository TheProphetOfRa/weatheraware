//
//  AssetHandler.h
//  honoursproject
//
//  Created by David Hodgkinson on 22/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface AssetHandler : NSObject {
    //SKTextureAtlas *_objectAtlas, *_shadowAtlas;
}


+ (AssetHandler*) sharedAssetHandler;

- (void) initTPages;
//- (SKTexture*) getTextureWithName:(NSString*) textureName fromPageWithName:(NSString*) pageName;

@end
