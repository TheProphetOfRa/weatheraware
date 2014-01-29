//
//  Object.m
//  weatheraware
//
//  Created by David Hodgkinson on 29/01/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Object.h"

#import "AssetHandler.h"

@implementation Object

- (id) initWithTextureName:(NSString*) textureName {
    
    if (self = [super init]){
        
        _sprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:textureName]];
        
        [self addChild:_sprite];
        
    }
    
    return self;
    
}

@end
