//
//  IntroScene.h
//  honoursproject
//
//  Created by David Hodgkinson on 01/11/2013.
//  Copyright David Hodgkinson 2013. All rights reserved.
//
// Import the interfaces
#import "IntroScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{

    if (self == [super init])
    {
        NSLog(@"Woo");
    }
    
    return self;
    
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------



// -----------------------------------------------------------------------
@end