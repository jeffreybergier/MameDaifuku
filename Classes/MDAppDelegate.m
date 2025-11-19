//
//  MameDaifukuAppDelegate.m
//  MameDaifuku
//
//  Created by Me on 25/11/18.
//  Copyright __MyCompanyName__ 2025. All rights reserved.
//

#import "MDAppDelegate.h"
#import "AppInfo.h"

@implementation MDAppDelegate

@synthesize window;
@synthesize rootViewController;

-(void)applicationDidFinishLaunching:(UIApplication *)application;
{
	UIViewController *_rootViewController = [[UIViewController alloc] initWithNibName:nil	bundle:nil];
	UIWindow *_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UIView *_rootView = [_rootViewController view];
	[self setWindow:_window];
	[self setRootViewController:_rootViewController];
	[_rootView setBackgroundColor:[UIColor redColor]];
	[_window addSubview:_rootView];
	[_window makeKeyAndVisible];
}


-(void)dealloc;
{
	[rootViewController release];
	[window release];
	[super dealloc];
}

@end

