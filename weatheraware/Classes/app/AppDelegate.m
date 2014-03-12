//
//  AppDelegate.m
//  weatheraware
//
//  Created by David Hodgkinson on 28/01/2014.
//  Copyright David Hodgkinson 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "CreatureTracker.h"
#import "IntroScene.h"
#import "MainScene.h"
#import "MetricManager.h"

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		//CCSetupShowDebugStats: @(YES),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
//		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
	}];
    
	return YES;
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{
    [[CreatureTracker sharedTracker] saveList];
    int endTime = (int)time(NULL);
    [[MetricManager sharedManager] updateValue:[NSNumber numberWithInt:endTime] forKey:@"sessionend"];
    [[MetricManager sharedManager] sendData];
    [super applicationDidEnterBackground:application];
}

-(CCScene *)startScene
{
    // This method should return the very first scene to be run when your app starts.
	return [MainScene scene];
}

@end
