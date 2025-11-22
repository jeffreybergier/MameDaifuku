//
//  MameDaifukuAppDelegate.h
//  MameDaifuku
//
//  Created by Me on 25/11/18.
//  Copyright __MyCompanyName__ 2025. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDAppDelegate: NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
	UIWindow *_window;
	UIViewController *_rootViewController;
	id _infoTableViewDataSource;
	id _introTableViewDataSource;
}

@property (readonly) UIWindow *window;
@property (readonly) UIViewController *rootViewController;
@property (readonly) id infoTableViewDataSource;
@property (readonly) id introTableViewDataSource;

@end
