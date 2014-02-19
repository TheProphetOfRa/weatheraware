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
        _map = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) setWidth:(int)width
{
    _width = width;
}

- (void) setHeight:(int)height
{
    _height = height;
}

- (void) setObject:(Object*) obj atGridPos:(CGPoint) pos
{
    NSString* gpstring = [NSString stringWithFormat:@"%f,%f", pos.x, pos.y];
    [_map setObject:obj forKey:gpstring];
}

- (Object*) getObjectAtGridPos:(CGPoint) pos
{
    NSString* gpstring = [NSString stringWithFormat:@"%f,%f", pos.x, pos.y];
    return [_map objectForKey:gpstring];
}

@end
