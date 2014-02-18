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
#import "Fence.h"
#import "Grid.h"
#import "JsonLoader.h"
#import "LongGrass.h"
#import "Object.h"
#import "Tree.h"


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
    Object *grassSprite;
    
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
                grassSprite = [[Object alloc] initWithTextureName:@"Tree128.png" andType:eTree];
                [_treeArray addObject:grassSprite];
            }
            if ([tile  isEqual: @"b"])
            {
                if (rand() % 8 == 1)
                {
                    grassSprite = [[Object alloc] initWithTextureName:@"GrassAlt128.png" andType:eBackground];
                }
                else
                {
                    grassSprite = [[Object alloc] initWithTextureName:@"Grass128.png" andType:eBackground];
                }
            }
            if (grassSprite != nil)
            {
                [[Grid sharedGrid] setObject:grassSprite atGridPos:ccp(i,j)];
                [grassSprite setPosition:ccp(([grassSprite contentSize].width * j), ([grassSprite contentSize].height * i))];
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
                [[Grid sharedGrid] setObject:[grassSprite tile] atGridPos:ccp(j,i)];
                [self addChild:grassSprite];
            }
        }
    }
}

-(void) initFenceWithData:(NSDictionary*) data
{
    Fence *fenceSprite;
    
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
                fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i) andTexture:@"FenceVertical128.png"];
            }
            if ([tile  isEqual: @"l"])
            {
                    fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i) andTexture:@"FenceUL128.png"];
            }
            if ([tile  isEqual: @"h"])
            {
                    fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i)andTexture:@"FenceHorizontal128.png"];
            }
            if ([tile  isEqual: @"u"])
            {
                    fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i) andTexture:@"FenceUR128.png"];
            }
            if ([tile  isEqual: @"r"])
            {
                    fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i) andTexture:@"FenceDR128.png"];
            }
            if ([tile  isEqual: @"d"])
            {
                    fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i) andTexture:@"FenceDL128.png"];
            }
            if ([tile  isEqual: @"n"])
            {
                    fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i)andTexture:@"FenceEndH128.png"];
            }
            if ([tile  isEqual: @"w"])
            {
                    fenceSprite = [[Fence alloc] initWithPosition:ccp(j,i) andTexture:@"FenceEndV128.png"];
            }
            if (fenceSprite != nil)
            {
                [[Grid sharedGrid] setObject:[fenceSprite tile] atGridPos:ccp(j,i)];
                [_fenceArray addObject:fenceSprite];
                [self addChild:fenceSprite];
            }
        }
    }
}

@end
