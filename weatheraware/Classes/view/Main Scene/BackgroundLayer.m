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
#import "Grid.h"
#import "JsonLoader.h"
#import "LongGrass.h"


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
    
    _treeArray = [[NSMutableArray alloc] init];

    NSArray *map = [data objectForKey:@"map"];
    
    for (int i = 0 ; i < [map count] ; i++)
    {
        for (int j = 0 ; j < [[map objectAtIndex:i] count] ; j++)
        {
            grassSprite = nil;
            NSString* tile = (NSString*)[[map objectAtIndex:i] objectAtIndex:j];
            if ([tile  isEqual: @"x"])
            {
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Tree128.png"]];
                    [_treeArray addObject:grassSprite];
            }
            if ([tile  isEqual: @"b"])
            {
                if (rand() % 8 == 1)
                {
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"GrassAlt128.png"]];
                }
                else
                {
                    grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Grass128.png"]];
                }
            }
            if (grassSprite != nil)
            {
                [grassSprite setPosition:ccp([grassSprite contentSize].width/2 + ([grassSprite contentSize].width * j), [grassSprite contentSize].height/2 + ([grassSprite contentSize].height * i))];
                [self addChild:grassSprite];
            }
        }
    }
}

-(void) initGrassSpritesWithData:(NSDictionary*) data
{
    LongGrass *grassSprite;
    
    _grassArray = [[NSMutableArray alloc] init];
    
    NSArray *map = [data objectForKey:@"map"];
    
    for (int i = 0 ; i < [map count] ; i++)
    {
        for (int j = 0 ; j < [[map objectAtIndex:i] count] ; j++)
        {
            grassSprite = nil;
            NSString* tile = (NSString*)[[map objectAtIndex:i] objectAtIndex:j];
            if ([tile  isEqual: @"g"])
            {
                grassSprite = [[LongGrass alloc] initWithPosition:ccp(j,i)];
                [_grassArray addObject:grassSprite];
                [self addChild:grassSprite];
            }
        }
    }
}

-(void) initFenceWithData:(NSDictionary*) data
{
    CCSprite *fenceSprite;
    
    _fenceArray = [[NSMutableArray alloc] init];
    
    NSArray *map = [data objectForKey:@"map"];
    
    for (int i = 0 ; i < [map count] ; i++)
    {
        for (int j = 0 ; j < [[map objectAtIndex:i] count] ; j++)
        {
            fenceSprite = nil;
            NSString* tile = (NSString*)[[map objectAtIndex:i] objectAtIndex:j];
            if ([tile  isEqual: @"v"])
            {
                fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceVertical128.png"]];
            }
            if ([tile  isEqual: @"l"])
            {
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceUL128.png"]];
            }
            if ([tile  isEqual: @"h"])
            {
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceHorizontal128.png"]];
            }
            if ([tile  isEqual: @"u"])
            {
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceUR128.png"]];
            }
            if ([tile  isEqual: @"r"])
            {
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceDR128.png"]];
            }
            if ([tile  isEqual: @"d"])
            {
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceDL128.png"]];
            }
            if ([tile  isEqual: @"n"])
            {
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceEndH128.png"]];
            }
            if ([tile  isEqual: @"w"])
            {
                    fenceSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"FenceEndV128.png"]];
            }
            if (fenceSprite != nil)
            {
                [fenceSprite setPosition:ccp([fenceSprite contentSize].width/2 + ([fenceSprite contentSize].width * j), [fenceSprite contentSize].height/2 + ([fenceSprite contentSize].height * i))];
                [_fenceArray addObject:fenceSprite];
                [self addChild:fenceSprite];
            }
        }
    }
}

@end
