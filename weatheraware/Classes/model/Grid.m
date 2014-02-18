//
//  Grid.m
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Grid.h"

#import "AssetHandler.h"
#import "CCDirector.h"
#import "CCSprite.h"
#import "Object.h"

@implementation GridPos

- (id) initWithPosition:(CGPoint)pos
{
    if (self = [super init])
    {
        _x = pos.x;
        _y = pos.y;
    }
    return self;
}

@end

@implementation Grid

static Grid* _sharedGrid = nil;

+ (Grid*) sharedGrid
{
    if (_sharedGrid == nil)
    {
        _sharedGrid = [[Grid alloc] init];
    }
    return _sharedGrid;
}

- (id) init {
    
    if (self = [super init])
    {
        [self initMap];
    }
    return self;
}

- (void) initMap
{
    
    _map = [[NSMutableDictionary alloc] init];
    
    CCSprite *ref = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"Grass128.png"]];
    
    for (int i = 0 ; i < ([[CCDirector sharedDirector] viewSize].width / [ref contentSize].width) ; i++)
    {
         for (int j = 0 ; j < ([[CCDirector sharedDirector] viewSize].height / [ref contentSize].height) ; j++)
         {
             [_map setObject:nil forKey:(id <NSCopying>)[[GridPos alloc] initWithPosition:ccp(i, j)]];
         }
    }
}

- (Object*) getObjectAtGridPos:(CGPoint) pos
{
    GridPos* gp = [[GridPos alloc] initWithPosition:pos];
    
    return [_map objectForKey:gp];
}

@end
