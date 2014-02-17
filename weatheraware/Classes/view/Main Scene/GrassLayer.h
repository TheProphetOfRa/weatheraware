//
//  GrassLayer.h
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

@interface GrassLayer : CCNode
{
    NSMutableArray *_grassArray;

}

- (id) initWithScreenSize: (CGSize) size;

@property (nonatomic, retain) NSMutableArray *grassArray;

@end
