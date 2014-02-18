//
//  Fence.h
//  weatheraware
//
//  Created by David Hodgkinson on 18/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@class  Object;

@interface Fence : CCNode
{
    Object *_tile;
}

- (id) initWithPosition:(CGPoint) pos andTexture:(NSString*) name;

@property (nonatomic, readonly) Object* tile;

@end
