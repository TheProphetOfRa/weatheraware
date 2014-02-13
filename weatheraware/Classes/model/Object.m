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
        [_sprite setPosition:ccp([_sprite contentSize].width/2, [_sprite contentSize].height/2)];
        [self addChild:_sprite];
        [self setContentSize:[_sprite contentSize]];
    }    
    return self;
}

@end
