//
//  CreatureTracker.h
//  weatheraware
//
//  Created by David Hodgkinson on 25/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatureTracker : NSObject
{
    NSDictionary *_capturedCreatures;
}

+ (CreatureTracker*) sharedTracker;

- (void) addCreature:(NSString*) creatureName;
- (BOOL) haveCaughtCreature:(NSString*) creatureName;
- (void) saveList;
@end
