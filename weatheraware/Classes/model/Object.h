//
//  Object.h
//  weatheraware
//
//  Created by David Hodgkinson on 29/01/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

#import "CCSprite.h"

@interface Object : CCNode {
    
    CCSprite* _sprite;
    
    NSString* _filename;
    
}

- (id) initWithTextureName:(NSString*) textureName;

@property (nonatomic, retain) CCSprite* sprite;

@end
