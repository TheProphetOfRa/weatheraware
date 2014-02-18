//
//  CollisionHandler.m
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CollisionHandler.h"

#import "Actor.h"
#import "CCSprite.h"
#import "LongGrass.h"
#import "Object.h"

@implementation CollisionHandler

+ (BOOL) player:(Actor*) player collidesWithObject:(CCSprite*) object
{
    
    const float playerMinX = [player position].x - [player contentSize].width/2;
    const float playerMinY = [player position].y - [player contentSize].height/2;
    const float playerMaxX = playerMinX + [player contentSize].width;
    const float playerMaxY = playerMinY + [player contentSize].height;
    
    const float objectMinX = [object position].x - [object contentSize].width/2;
    const float objectMinY = [object position].y - [object contentSize].height/2;
    const float objectMaxX = objectMinX + [object contentSize].width;
    const float objectMaxY = objectMinY + [object contentSize].height;
    
    bool temp = true;
    
    if (playerMinX > objectMaxX) temp =  false;
    if (objectMinX > playerMaxX) temp =  false;
    if (playerMinY > objectMaxY) temp =  false;
    if (objectMinY > playerMaxY) temp =  false;
    
    return temp;
    
    /*return !(playerMinX > objectMaxX ||
             objectMinX > playerMaxX ||
             playerMinY > objectMaxY ||
             objectMinY > playerMaxY );*/
}

+ (BOOL) player:(Actor *)player isInGrass:(LongGrass *)grass
{
    const float playerMinX = [player position].x - [player contentSize].width/2;
    const float playerMinY = [player position].y - [player contentSize].height/2;
    const float playerMaxX = playerMinX + [player contentSize].width;
    const float playerMaxY = playerMinY + [player contentSize].height;
    
    const float objectMinX = [[grass tile] position].x - [[[grass tile] sprite] contentSize].width/2;
    const float objectMinY = [[grass tile] position].y - [[[grass tile] sprite] contentSize].height/2;
    const float objectMaxX = objectMinX + [[[grass tile] sprite] contentSize].width;
    const float objectMaxY = objectMinY + [[[grass tile] sprite] contentSize].height;
    
    return !(playerMinX > objectMaxX ||
             objectMinX > playerMaxX ||
             playerMinY > objectMaxY ||
             objectMinY > playerMaxY );
}

@end
