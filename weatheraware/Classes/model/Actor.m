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
    
    const float tileSizeW = [[_tile sprite] contentSize].width;
    const float tileSizeH = [[_tile sprite] contentSize].height;
    
    switch (dir) {
        case eUp:
            [_tile runAction:[CCActionMoveBy actionWithDuration:0.5f position:ccp(0, tileSizeH)]];
            NSLog(@"Up");
            break;
        case eDown:
            [_tile runAction:[CCActionMoveBy actionWithDuration:0.5f position:ccp(0, -tileSizeH)]];
            NSLog(@"Down");
            break;
        case eLeft:
            [_tile runAction:[CCActionMoveBy actionWithDuration:0.5f position:ccp(-tileSizeW, 0)]];
            NSLog(@"Left");
            break;
        case eRight:
            [_tile runAction:[CCActionMoveBy actionWithDuration:0.5f position:ccp(tileSizeW, 0)]];
            NSLog(@"Right");
            break;
    }
    
}

@end
