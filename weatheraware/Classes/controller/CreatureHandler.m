//
//  CreatureHandler.m
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CreatureHandler.h"

@implementation CreatureHandler

static CreatureHandler *_sharedHandler = nil;

+ (CreatureHandler*) sharedCreatureHandler
{
    if (_sharedHandler == nil)
    {
        _sharedHandler = [[CreatureHandler alloc] init];
    }
    return _sharedHandler;
}



@end
