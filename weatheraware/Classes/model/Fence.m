//
//  Fence.m
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Fence.h"

#import "Object.h"

@implementation Fence

- (id) initWithPosition:(CGPoint) pos andTexture:(NSString*) name
{
    if (self = [super init])
    {
        [self initTileWithPos:pos andName:name];
    }
    return self;
}

- (void) initTileWithPos:(CGPoint) pos andName:(NSString*) name;
{
    _tile = [[Object alloc] initWithTextureName:name andType:eFence];
    CGPoint truePoint;
    truePoint.x = ([_tile contentSize].width * pos.x);
    truePoint.y = ([_tile contentSize].height * pos.y);
    [_tile setPosition:truePoint];
    [self addChild:_tile];
}

@end
