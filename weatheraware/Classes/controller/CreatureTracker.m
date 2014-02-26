//
//  CreatureTracker.m
//  weatheraware
//
//  Created by David Hodgkinson on 25/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "CreatureTracker.h"

#import "JsonLoader.h"

@implementation CreatureTracker

static CreatureTracker *_sharedTracker = nil;

+ (CreatureTracker*) sharedTracker
{
    if (_sharedTracker == nil)
    {
        _sharedTracker = [[CreatureTracker alloc] init];
    }
    return _sharedTracker;
}

- (id) init
{
    if (self = [super init])
    {
        [self loadList];
    }
    return self;
}

- (void) saveList
{
    if (![JsonLoader saveJson:_capturedCreatures ToFile:@"capturedcreatures.json"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Failed!" message:@"Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void) loadList
{
    _capturedCreatures = [JsonLoader loadJsonFromFile:@"capturedcreatures.json"];
}

- (void) addCreature:(NSString*) creatureName
{
    [_capturedCreatures setValue:[NSNumber numberWithBool:YES] forKey:creatureName];
}

@end
