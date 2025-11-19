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
	UITabBarController *_tabBarController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@end
