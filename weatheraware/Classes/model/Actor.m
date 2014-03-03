//
//  Actor.m
//  weatheraware
//
//  Created by David Hodgkinson on 04/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "Actor.h"
#import "BattleScene.h"
#import "CCActionInterval.h"
#import "CCAction.h"
#import "CCDirector.h"
#import "Grid.h"
#import "Object.h"

@implementation Actor

static const int kEncounterChance = 25;

- (id) initWithFilename: (NSString*) filename andWeatherCondition:(enum WeatherType) cond
{
    if (self = [super init])
    {
        
        _condition = cond;
        
        srand(time(NULL));
        
        _tile = [[Object alloc] initWithTextureName:filename andType:eActor];
        [_tile setPosition:ccp(0, 0)];
        
        CGPoint gridpos;
        gridpos.x = [[Grid sharedGrid] width]/2;
        gridpos.y = [[Grid sharedGrid] height]/2;
        
        CGPoint pos;
        pos.x = [_tile contentSize].width * gridpos.x;
        pos.y = [_tile contentSize].height * gridpos.y;
        
        //Make actor appear the same as sprite
        [self setPosition:pos];
        [self setContentSize:[_tile contentSize]];
        
        _gridPos = gridpos;
        
        [self addChild:_tile];
    }
    return self;
}

- (void) moveInDirection: (enum Direction) dir
{
    if (moving)
    {
        return;
    }
    
    //Get size of sprite for movement
    const float tileSizeW = [[_tile sprite] contentSize].width;
    const float tileSizeH = [[_tile sprite] contentSize].height;
    
    
    CCActionSequence    *seq = nil;
    CCActionCallFunc    *callback = nil;
    CCActionDelay       *delay = nil;
    CCActionFiniteTime  *action = nil;
    
    //Create action to be in correct direction
    switch (dir)
    {
        case eUp:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y+1)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y+1)] type] == eGrass)
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(0, tileSizeH)];
                _gridPos.y++;
            }
            break;
        case eDown:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y-1)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x,_gridPos.y-1)] type] == eGrass)
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(0, -tileSizeH)];
                _gridPos.y--;
            }
            break;
        case eLeft:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x-1,_gridPos.y)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x-1,_gridPos.y)] type] == eGrass)
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(-tileSizeW, 0)];
                _gridPos.x--;
            }
            break;
        case eRight:
            if ([[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x+1,_gridPos.y)] type] == eBackground ||
                [[[Grid sharedGrid] getObjectAtGridPos:ccp(_gridPos.x+1,_gridPos.y)] type] == eGrass )
            {
                action = [CCActionMoveBy actionWithDuration:0.5f position:ccp(tileSizeW, 0)];
                _gridPos.x++;
            }
            break;
    }
    
    if (action != nil) {
        callback = [CCActionCallFunc actionWithTarget:self selector:@selector(checkForEncounter)];
        delay = [CCActionDelay actionWithDuration:0.1f];
        seq = [CCActionSequence actions:action, delay, callback, nil];
    }
    if (seq != nil)
    {
        moving = true;
        //Move sprite
        [self runAction:seq];
    }
}

- (void) checkForEncounter
{
    moving = false;
    if ([[[Grid sharedGrid] getObjectAtGridPos:_gridPos] type] == eGrass &&
        rand()%100 <= kEncounterChance)
    {
        printf("Encounter\n");
        //[[CCDirector sharedDirector] pushScene:[BattleScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
        [[CCDirector sharedDirector] pushScene:[BattleScene sceneWithWeatherCondition:_condition]];
    }
    
}

@end
