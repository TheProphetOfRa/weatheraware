//
//  LongGrass.h
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class Object;

@interface LongGrass : CCNode {
    
    Object    *_tile;
    
    CGPoint   _gridPos;
    
}

- (id) initWithGridPos: (CGPoint) gPos;

@property (nonatomic, readonly) CGPoint gridPos;

@end
