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
    
    int _width, _height;
    
}

+ (Grid*) sharedGrid;

- (void) setWidth:(int) width;
- (void) setHeight:(int) height;

- (void) setObject:(Object*) obj atGridPos:(CGPoint) pos;
- (Object*) getObjectAtGridPos:(CGPoint) pos;

@property (readonly) int width;
@property (readonly) int height;

@end
