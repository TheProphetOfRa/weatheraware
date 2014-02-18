//
//  Actor.m
//  weatheraware
//
//  Created by David Hodgkinson on 04/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Actor.h"
#import "CCDirector.h"
#import "Grid.h"
#import "Object.h"

@implementation Actor

const static int kMoveTag = 2352352;

- (id) initWithFilename: (NSString*) filename
{
    if (self = [super init])
    {
        _tile = [[Object alloc] initWithTextureName:filename andType:eActor];
        [_tile setPosition:ccp(0, 0)];
        
        CGPoint pos;
        pos.x = [[CCDirector sharedDirector] viewSize].width/2;
        pos.y = [[CCDirector sharedDirector] viewSize].height/2;
        
        CGPoint gridpos;
        gridpos.x = ([[CCDirector sharedDirector] viewSize].width / [_tile contentSize].width)/2;
        gridpos.y = ([[CCDirector sharedDirector] viewSize].height / [_tile contentSize].height)/2;
        
        [self setPosition:pos];
        
        _gridPos = gridpos;
        
        [self addChild:_tile];
    }
    return self;
}

- (void) moveInDirection: (enum Direction) dir
{
    //Check that previous move action has completed
    if ([self getActionByTag:kMoveTag])
    {
        return;
    }
    
    //Get size of sprite for movement
    const float tileSizeW = [[_tile sprite] contentSize].width;
    const float tileSizeH = [[_tile sprite] contentSize].height;
    
    CCAction *action = nil;
    
    //Create action to be in correct direction
    switch (dir)
    {
        case eUp:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y+1)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y+1)] type] == eGrass)
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(0, tileSizeH)];
                [action setTag:kMoveTag];
            }
            break;
        case eDown:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y-1)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y-1)] type] == eGrass)
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(0, -tileSizeH)];
                [action setTag:kMoveTag];
            }
            break;
        case eLeft:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x-1,_gridPos.y)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x-1,_gridPos.y)] type] == eGrass)
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(-tileSizeW, 0)];
                [action setTag:kMoveTag];
            }
            break;
        case eRight:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x+1,_gridPos.y)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x+1,_gridPos.y)] type] == eGrass)
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(tileSizeW, 0)];
                [action setTag:kMoveTag];
            }
            break;
    }
    if (action != nil) {
        //Move sprite
        [self runAction:action];
    }
}

@end
