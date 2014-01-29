//
//  BackgroundLayer.m
//  honoursproject
//
//  Created by David Hodgkinson on 01/11/2013.
//  Copyright 2013 David Hodgkinson. All rights reserved.
//

#import "BackgroundLayer.h"

#import "Object.h"

@implementation BackgroundLayer

- (id) init {
    
    if (self = [super init]) {
        
        CCColor* color = [[CCColor alloc] initWithCcColor4b:ccc4(0.0f, 120.0f, 64.0f, 0.0f)];
        
        [self setColor:color];
        
        _house = [[Object alloc] initWithTextureName:@"greensquare.png"];
        
        [_house setPosition:ccp([self contentSize].width/2, [self contentSize].height/2)];
        
        _label = [CCLabelTTF labelWithString:@"Hello, world" fontName:@"Helvetica" fontSize:24];
        
        [_label setPosition:ccp([self contentSize].width/2, [_label contentSize].height)];
         
        //add objects
        [self addChild:_house];
        
        //add UI
        [self addChild:_label];
    }
    return self;
}

@end