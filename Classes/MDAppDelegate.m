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
	// Create View Controllers
	UITabBarController *tabBarController = [[[UITabBarController alloc] initWithNibName:nil bundle:nil] autorelease];
	UINavigationController *navVC = [[[UINavigationController alloc] initWithRootViewController:tabBarController] autorelease];
	UITableViewController *introVC = [[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	UITableViewController *infoVC = [[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	MDIntroTableViewDataSource *introDS = [[[MDIntroTableViewDataSource alloc] init] autorelease];
	MDInfoTableViewDataSource *infoDS = [[[MDInfoTableViewDataSource alloc] init] autorelease];
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UIView *rootView = [navVC view];
	
	// Set Properties
	[self setWindow:window];
	[self setRootViewController:navVC];
	[self setIntroTableViewDataSource:introDS];
	[self setInfoTableViewDataSource:infoDS];
	
	// Configure View Controllers
	// TODO: Move this into view controller files
	[tabBarController setTitle:@"豆大福"];
	[introVC setTitle:@"自己紹介"];
	[infoVC setTitle:@"情報"];
	// TODO: Create crossplatform file to add this method on iOS2
	// [infoTableView setAllowsSelection:NO];
	[[introVC tableView] setDataSource:introDS];
	[[introVC tableView] setDelegate:introDS];
	[[infoVC tableView] setDataSource:infoDS];	
	[tabBarController setViewControllers:[NSArray arrayWithObjects:introVC, infoVC, nil]];
	
	// Configure Main Window
	[window addSubview:rootView];
	[window makeKeyAndVisible];
}


-(void)dealloc;
{
	[_rootViewController release];
	[_infoTableViewDataSource release];
	[_window release];
	[super dealloc];
}

@end

