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

const static int kMoveTag = 2352352;

- (id) initWithFilename: (NSString*) filename {

    if (self = [super init]) {
        _tile = [[Object alloc] initWithTextureName:filename];
        [_tile setPosition:ccp(0, 0)];
        [self addChild:_tile];
    }
    return self;
}

- (void) moveInDirection: (enum Direction) dir {
    
    //Check that previous move action has completed
    if ([_tile getActionByTag:kMoveTag]) {
        return;
    }
    
    //Get size of sprite for movement
    const float tileSizeW = [[_tile sprite] contentSize].width;
    const float tileSizeH = [[_tile sprite] contentSize].height;
    
    CCAction *action;
    
    //Create action to be in correct direction
    switch (dir) {
        case eUp:
            action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(0, tileSizeH)];
            [action setTag:kMoveTag];
            break;
        case eDown:
            action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(0, -tileSizeH)];
            [action setTag:kMoveTag];
            break;
        case eLeft:
            action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(-tileSizeW, 0)];
            [action setTag:kMoveTag];
            break;
        case eRight:
            action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(tileSizeW, 0)];
            [action setTag:kMoveTag];
            break;
    }
    
    //Move sprite
    [_tile runAction:action];
    
}

@end
