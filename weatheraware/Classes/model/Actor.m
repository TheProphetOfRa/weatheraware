//
//  Actor.m
//  weatheraware
//
//  Created by David Hodgkinson on 04/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Actor.h"

#import "Object.h"

@implementation Actor

- (id) initWithFilename: (NSString*) filename {

    if (self = [super init]) {
        _tile = [[Object alloc] initWithTextureName:filename];
        [_tile setPosition:ccp(0, 0)];
        [self addChild:_tile];
    }
    return self;
}

- (void) moveInDirection: (enum Direction) dir {
    
    const float x = [[_tile sprite] position].x;
    const float y = [[_tile sprite] position].y;
    
    const float tileSizeW = [[_tile sprite] contentSize].width;
    const float tileSizeH = [[_tile sprite] contentSize].height;
    
    switch (dir) {
        case eUp:
            [[_tile sprite] runAction:[CCActionMoveBy actionWithDuration:5.0f position:ccp(x, y - tileSizeH)]];
            break;
        case eDown:
            [[_tile sprite] runAction:[CCActionMoveBy actionWithDuration:5.0f position:ccp(x, y + tileSizeH)]];
            break;
        case eLeft:
            [[_tile sprite] runAction:[CCActionMoveBy actionWithDuration:5.0f position:ccp(x - tileSizeW, y)]];
            break;
        case eRight:
            [[_tile sprite] runAction:[CCActionMoveBy actionWithDuration:5.0f position:ccp(x + tileSizeW, y)]];
            break;
    }
    
}

@end
