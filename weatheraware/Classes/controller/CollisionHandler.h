//
//  CollisionHandler.h
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Actor;
@class CCSprite;
@class LongGrass;
@class Object;

@interface CollisionHandler : NSObject

+ (BOOL) player:(Actor*) player willCollideWithObject:(CCSprite*) object;
+ (BOOL) player:(Actor*) player isInGrass:(LongGrass*) grass;

@end
