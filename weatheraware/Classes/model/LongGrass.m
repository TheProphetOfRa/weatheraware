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

- (id) initWithGridPos:(CGPoint)gPos {
    
    if (self = [super init]) {
        _gridPos = gPos;
        
        [self initTile];
        
    }
    return self;
}

- (void) initTile {
    _tile = [[Object alloc] initWithTextureName:@"longgrass.png"];
    CGPoint pos;
    pos.x = [[_tile sprite] contentSize].width/2  + (_gridPos.x * [[_tile sprite] contentSize].width);
    pos.y = [[_tile sprite] contentSize].height/2 + (_gridPos.y * [[_tile sprite] contentSize].height);
    [_tile setPosition:pos];
    [self addChild:_tile];
}

@end
