//
//  BackgroundLayer.m
//  honoursproject
//
//  Created by David Hodgkinson on 01/11/2013.
//  Copyright 2013 David Hodgkinson. All rights reserved.
//

#import "BackgroundLayer.h"

#import "AssetHandler.h"


@implementation BackgroundLayer

- (id) init {
    
    CCColor* color = [[CCColor alloc] initWithCcColor4b:ccc4(0.0f, 0.0f, 0.0f, 255.0f)];
    
    if (self = [super initWithColor:color]) {
        
        _label = [CCLabelTTF labelWithString:@"Hello, world" fontName:@"Helvetica" fontSize:24];
        
        [_label setPosition:ccp([self contentSize].width/2, [_label contentSize].height)];
        
        CCSprite *grassSprite;
        
        //Should be torn out and replaced with a JSON loaded implementation
        srand(1234123);
        
        for (int i = 0 ; i < [self contentSize].width / [grassSprite contentSize].width ; i++){
            for (int j = 0 ; j < [self contentSize].height / [grassSprite contentSize].height ; j++){
                if (rand()%5 <= 1){
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"flower.png"]];
                }
                else {
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"grass.png"]];
                }
                [grassSprite setPosition:ccp([grassSprite contentSize].width/2 + ([grassSprite contentSize].width * i), [grassSprite contentSize].height/2 + ([grassSprite contentSize].height * j))];
                [self addChild:grassSprite];
            }
        }
        
        //add UI
        [self addChild:_label];

    }
    return self;
}

@end
