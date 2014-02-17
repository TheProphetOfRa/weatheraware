//
//  BackgroundLayer.m
//  honoursproject
//
//  Created by David Hodgkinson on 01/11/2013.
//  Copyright 2013 David Hodgkinson. All rights reserved.
//

#import "BackgroundLayer.h"

#import "AssetHandler.h"
#import "JsonLoader.h"


@implementation BackgroundLayer

- (id) init
{
    CCColor* color = [[CCColor alloc] initWithCcColor4b:ccc4(0.0f, 0.0f, 0.0f, 255.0f)];
    
    if (self = [super initWithColor:color])
    {
        _label = [CCLabelTTF labelWithString:@"Hello, world" fontName:@"Helvetica" fontSize:24];
        
        [_label setPosition:ccp([self contentSize].width/2, [_label contentSize].height)];
        
        [self initBackgroundSprites];
        
        //add UI
        [self addChild:_label];
    }
    return self;
}

- (void) initBackgroundSprites
{
    CCSprite *grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"GrassAlt128.png"]];
    
    NSDictionary *levelData = [[JsonLoader sharedJsonLoader] loadJsonFromFile:@"mainscene.json"];
    
    NSArray *map = [levelData objectForKey:@"map"];
    
    //Should be torn out and replaced with a JSON loaded implementation
    srand(1234123);
    
    for (int i = 0 ; i < [map count] ; i++)
    {
        for (int j = 0 ; j < [[map objectAtIndex:i] count] ; j++)
        {
            int tile = [[[map objectAtIndex:i] objectAtIndex:j] intValue];
            switch (tile)
            {
                case 0:
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Tree128.png"]];
                    break;
                case 1:
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"GrassAlt128.png"]];
                    break;
                default:
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Grass128.png"]];
                    break;
            }
            [grassSprite setPosition:ccp([grassSprite contentSize].width/2 + ([grassSprite contentSize].width * j), [grassSprite contentSize].height/2 + ([grassSprite contentSize].height * i))];
            [self addChild:grassSprite];
        }
    }
}

@end
