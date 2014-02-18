//
//  Grid.h
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class Object;

@interface Grid : CCNode
{
    
    Grid *_sharedGrid;
    
    NSMutableDictionary *_map;
}

+ (Grid*) sharedGrid;

- (void) setObject:(Object*) obj atGridPos:(CGPoint) pos;
- (Object*) getObjectAtGridPos:(CGPoint) pos;

@end
