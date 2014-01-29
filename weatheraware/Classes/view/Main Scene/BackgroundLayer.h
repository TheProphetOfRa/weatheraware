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

@interface BackgroundLayer : CCNodeColor {
    
    //scene components
    Object* _house;
    
    CCLabelTTF           *_label;
}

@property (retain) CCLabelTTF *label;

@end
