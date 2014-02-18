//
//  LongGrass.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "LongGrass.h"

#import "Object.h"

@implementation LongGrass

- (id) initWithPosition:(CGPoint) pos
{
    if (self = [super init])
    {
        [self initTileWithPos:pos];
    }
    return self;
}

- (void) initTileWithPos:(CGPoint) pos
{
    _tile = [[Object alloc] initWithTextureName:@"LongGrass128.png"];
    CGPoint truePoint;
    truePoint.x = ([_tile contentSize].width * pos.x);
    truePoint.y = ([_tile contentSize].height * pos.y);
    [_tile setPosition:truePoint];
    [self addChild:_tile];
}

@end
