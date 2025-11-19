//
//  MameDaifukuAppDelegate.m
//  MameDaifuku
//
//  Created by Me on 25/11/18.
//  Copyright __MyCompanyName__ 2025. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDInfoViewController.h"

@interface UITabBarController (MameDaifuku)
+(id)MD_new;
@end

@implementation UITabBarController (MameDaifuku)
+(id)MD_new;
{
  UITabBarController *controller = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
	NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithObjects:
																		 [[[MDInfoViewController alloc] initWithNibName:nil bundle:nil] autorelease],
																		 [[[MDInfoViewController alloc] initWithNibName:nil bundle:nil] autorelease],
																		 nil]; 
	[[viewControllers objectAtIndex:0] setLanguage:0];
	[[viewControllers objectAtIndex:1] setLanguage:1];
	[controller setViewControllers:viewControllers];
	return controller;
}
@end

@implementation MDAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

-(void)applicationDidFinishLaunching:(UIApplication *)application;
{
	UITabBarController *tabBarController = [UITabBarController MD_new];
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UIView *rootView = [tabBarController view];
	[self setWindow:window];
	[self setTabBarController:tabBarController];
	[window addSubview:rootView];
	[window makeKeyAndVisible];
}


-(void)dealloc;
{
	[_tabBarController release];
	[_window release];
	[super dealloc];
}

@end

