//
//  BackgroundLayer.m
//  honoursproject
//
//  Created by David Hodgkinson on 01/11/2013.
//  Copyright 2013 David Hodgkinson. All rights reserved.
//

#import "BackgroundLayer.h"

#import "AssetHandler.h"
#import "DeviceInformation.h"
#import "JsonLoader.h"


@implementation BackgroundLayer

- (id) initWithJSONData:(NSDictionary *)data
{
    CCColor* color = [[CCColor alloc] initWithCcColor4b:ccc4(0.0f, 0.0f, 0.0f, 255.0f)];
    
    if (self = [super initWithColor:color])
    {
        _label = [CCLabelTTF labelWithString:@"Hello, world" fontName:@"Helvetica" fontSize:24];
        
        [_label setPosition:ccp([self contentSize].width/2, [_label contentSize].height)];
        
        [self initBackgroundSpritesFromData:data];
        [self initGrassSpritesWithData:data];
        [self initFenceWithData:data];
        
        //add UI
        [self addChild:_label];
    }
    return self;
}

- (void) initBackgroundSpritesFromData:(NSDictionary*) data
{
    CCSprite *grassSprite;

    NSArray *map = [data objectForKey:@"map"];
    
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

-(void) initGrassSpritesWithData:(NSDictionary*) data
{
    CCSprite *grassSprite;
    
    NSArray *map = [data objectForKey:@"grassmap"];
    
    for (int i = 0 ; i < [map count] ; i++)
    {
        for (int j = 0 ; j < [[map objectAtIndex:i] count] ; j++)
        {
            int tile = [[[map objectAtIndex:i] objectAtIndex:j] intValue];
            if (tile == 1)
            {
                grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"LongGrass128.png"]];
                [grassSprite setPosition:ccp([grassSprite contentSize].width/2 + ([grassSprite contentSize].width * j), [grassSprite contentSize].height/2 + ([grassSprite contentSize].height * i))];
                [self addChild:grassSprite];
            }
        }
    }
}

-(void) initFenceWithData:(NSDictionary*) data
{
    CCSprite *fenceSprite;
    
    NSArray *map = [data objectForKey:@"fencemap"];
    
    for (int i = 0 ; i < [map count] ; i++)
    {
        for (int j = 0 ; j < [[map objectAtIndex:i] count] ; j++)
        {
            fenceSprite = nil;
            int tile = [[[map objectAtIndex:i] objectAtIndex:j] intValue];
            switch (tile)
            {
                case 1:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceVertical128.png"]];
                    break;
                case 2:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceUL128.png"]];
                    break;
                case 3:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceHorizontal128.png"]];
                    break;
                case 4:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceUR128.png"]];
                    break;
                case 5:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceDR128.png"]];
                    break;
                case 6:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceDL128.png"]];
                    break;
                case 7:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceEndH128.png"]];
                    break;
                case 8:
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceEndV128.png"]];
                    break;
            }
            if (fenceSprite != nil)
            {
                [fenceSprite setPosition:ccp([fenceSprite contentSize].width/2 + ([fenceSprite contentSize].width * j), [fenceSprite contentSize].height/2 + ([fenceSprite contentSize].height * i))];
                [self addChild:fenceSprite];
            }
        }
    }
}

@end
