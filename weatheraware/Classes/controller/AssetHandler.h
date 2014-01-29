//
//  AssetHandler.h
//  honoursproject
//
//  Created by David Hodgkinson on 22/10/2013.
//  Copyright (c) 2013 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSpriteFrameCache.h"

@interface AssetHandler : NSObject {

}


+ (AssetHandler*) sharedAssetHandler;

- (void) initTPages;
- (CCSpriteFrame*) getTextureWithName:(NSString*) textureName;

@end
