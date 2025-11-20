//
//  MameDaifukuAppDelegate.m
//  MameDaifuku
//
//  Created by Me on 25/11/18.
//  Copyright __MyCompanyName__ 2025. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDIntroViewController.h"
#import "MDInfoTableViewDataSource.h"

@implementation MDAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize infoTableViewDataSource = _infoTableViewDataSource;

-(void)applicationDidFinishLaunching:(UIApplication*)application;
{
	UITabBarController *tabBarController = [[[UITabBarController alloc] initWithNibName:nil bundle:nil] autorelease];
	MDIntroViewController *introVC = [[[MDIntroViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	UITableViewController *infoVC = [[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	MDInfoTableViewDataSource *dataSource = [[[MDInfoTableViewDataSource alloc] init] autorelease];
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UIView *rootView = [tabBarController view];
	
	[self setWindow:window];
	[self setTabBarController:tabBarController];
	[self setInfoTableViewDataSource:dataSource];
	
	[[infoVC tableView] setDataSource:dataSource];
	[tabBarController setViewControllers:[NSArray arrayWithObjects:introVC, infoVC, nil]];
	[window addSubview:rootView];
	[window makeKeyAndVisible];
}


-(void)dealloc;
{
	[_tabBarController release];
	[_infoTableViewDataSource release];
	[_window release];
	[super dealloc];
}

@end

