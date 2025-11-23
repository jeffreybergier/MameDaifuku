//
//  MameDaifukuAppDelegate.m
//  MameDaifuku
//
//  Created by Me on 25/11/18.
//  Copyright __MyCompanyName__ 2025. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDIntroTableViewDataSource.h"
#import "MDInfoTableViewDataSource.h"

@implementation MDAppDelegate

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;
@synthesize infoTableViewDataSource = _infoTableViewDataSource;
@synthesize introTableViewDataSource = _introTableViewDataSource;

-(void)applicationDidFinishLaunching:(UIApplication*)application;
{
	// Created autoreleased objects
	UITabBarController *tabBarController = [[[UITabBarController alloc] initWithNibName:nil bundle:nil] autorelease];
	UITableViewController *introVC = [[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	UITableViewController *infoVC = [[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	
	// Create retained objects
	UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:tabBarController];
	MDIntroTableViewDataSource *introDS = [[MDIntroTableViewDataSource alloc] initWithTableViewController:introVC];
	MDInfoTableViewDataSource *infoDS = [[MDInfoTableViewDataSource alloc] initWithTableViewController:infoVC];
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		
	// Set properties
	_rootViewController = navVC;
	_introTableViewDataSource = introDS;
	_infoTableViewDataSource = infoDS;
	_window = window;
	
	// Configure Tab Bar
	[tabBarController setTitle:NSLocalizedString(@"TitleApp", nil)];	
	[tabBarController setViewControllers:[NSArray arrayWithObjects:introVC, infoVC, nil]];
	
	// Configure Main Window
	[window addSubview:[navVC view]];
	[window makeKeyAndVisible];
}


-(void)dealloc;
{
	[_window release];
	[_rootViewController release];
	[_introTableViewDataSource release];
	[_infoTableViewDataSource release];
	[super dealloc];
}

@end

