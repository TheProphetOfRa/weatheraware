//
//  BackgroundLayer.h
//  honoursproject
//
//  Created by David Hodgkinson on 01/11/2013.
//  Copyright 2013 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Object;

@interface BackgroundLayer : CCNodeColor
{
    //scene components
    NSMutableArray      *_backgroundArray;
    NSMutableArray      *_grassArray;
    NSMutableArray      *_treeArray;
    NSMutableArray      *_fenceArray;
    
    CCLabelTTF          *_label;
}

-(id) initWithJSONData:(NSDictionary*) data;


@property (retain, readonly) NSMutableArray* grassArray;
@property (retain, readonly) NSMutableArray* treeArray;
@property (retain, readonly) NSMutableArray* fenceArray;

@property (retain) CCLabelTTF *label;

@end
