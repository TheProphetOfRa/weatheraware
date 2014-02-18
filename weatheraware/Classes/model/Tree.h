//
//  Tree.h
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class Object;

@interface Tree : CCNode
{
    Object    *_tile;
}

- (id) initWithPosition:(CGPoint) pos;

@property (nonatomic, readonly) Object* tile;

@end
