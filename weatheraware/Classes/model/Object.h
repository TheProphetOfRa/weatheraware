//
//  Object.h
//  weatheraware
//
//  Created by David Hodgkinson on 29/01/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CCNode.h"

#import "CCSprite.h"

enum Type{
    eTree,
    eFence,
    eGrass,
    eActor,
    eBackground
};

@interface Object : CCNode
{
    
    CCSprite* _sprite;
    
    NSString* _filename;
    
    enum Type _type;
}

- (id) initWithTextureName:(NSString*) textureName andType:(enum Type) t;

@property (nonatomic, retain) CCSprite* sprite;
@property (readonly) enum Type type;

@end
