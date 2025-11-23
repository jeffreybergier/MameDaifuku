//
//  XPCrossPlatform.m
//  MameDaifuku
//
//  Created by Me on 25/11/23.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "XPCrossPlatform.h"

@implementation UITableView (CrossPlatform)

-(BOOL)XP_allowsSelection;
{
	SEL selector = @selector(allowsSelection);
	if ([self respondsToSelector:selector]) {
		return [self allowsSelection];
	}
	NSLog(@"%@ Does not support '%@' on this device", 
				NSStringFromClass([self class]), NSStringFromSelector(selector));
	return YES;
}

-(void)XP_setAllowsSelection:(BOOL)aFlag;
{
  SEL selector = @selector(setAllowsSelection:);
	if ([self respondsToSelector:selector]) {
		return [self setAllowsSelection:aFlag];
	}
	NSLog(@"%@ Does not support '%@' on this device", 
				NSStringFromClass([self class]), NSStringFromSelector(selector));
	return;
}

@end