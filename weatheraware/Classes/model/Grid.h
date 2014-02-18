//
//  Grid.h
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class Object;

@interface GridPos : NSObject
{
    int _x,_y;
}
- (id) initWithPosition:(CGPoint) pos;
@property (readonly) int x;
@property (readonly) int y;
@end

@interface Grid : CCNode
{
    
    Grid *_sharedGrid;
    
    NSMutableDictionary *_map;
}

+ (Grid*) sharedGrid;

- (Object*) getObjectAtGridPos:(CGPoint) pos;

@end
