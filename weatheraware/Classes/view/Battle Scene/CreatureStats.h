//
//  CreatureStats.h
//  weatheraware
//
//  Created by David Hodgkinson on 24/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

#import "CCLabelBMFont.h"
#import "CCSprite.h"
#import "CCSprite9Slice.h"

@interface CreatureStats : CCNode
{
    CCSprite        *_background;
    CCSprite9Slice  *_healthBar;
    CCLabelBMFont   *_nameLabel;
}

- (id) initWithCreatureName:(NSString*) name;
- (void) reduceHealthBy:(int) percentage;

@end
