//
//  AppInfo.m
//  MameDaifuku
//
//  Created by Me on 25/11/18.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "AppInfo.h"
#import <UIKit/UIKit.h>

@implementation AppInfo

+ (NSString *)appEnvironmentDetails {
	
	NSString *runningEnvironment;
	NSString *architecture;
	NSString *buildMinString;
	NSString *buildMaxString;
	UIDevice *device = [UIDevice currentDevice];
	NSString *currentOSVersion = [device systemVersion];
	int buildMinInt = __IPHONE_OS_VERSION_MIN_REQUIRED;
	int buildMaxInt = __IPHONE_OS_VERSION_MAX_ALLOWED;
	
	// A. Running Environment (Simulator vs. Device)
#if TARGET_IPHONE_SIMULATOR
	runningEnvironment = @"Simulator";
#else
	runningEnvironment = @"Device";
#endif
	
	// B. CPU Architecture
	// Check for the specific simulator host architectures first
#if defined(__ppc__) || defined(__PPC__)
	architecture = @"PPC";
#elif defined(__i386__)
	architecture = @"i386";
#elif defined(__arm__)
	architecture = @"ARM"; 
#else
	architecture = @"Unknown";
#endif
	
	
	// Convert the integer into a readable version string (e.g., 20201 -> 2.2.1)
	buildMinString = [NSString stringWithFormat:@"%d.%d.%d", 
										(buildMinInt / 10000), 
										(buildMinInt / 100) % 100, 
										(buildMinInt % 100)];
	buildMaxString = [NSString stringWithFormat:@"%d.%d.%d SDK", 
										(buildMaxInt / 10000), 
										(buildMaxInt / 100) % 100, 
										(buildMaxInt % 100)];
	
	return [NSString stringWithFormat:
					@"Build SDK: %@\n"
					@"Supported OS: %@\n"
					@"Current OS: %@\n"
					@"Environment: %@\n"
					@"Architecture: %@", 
					buildMaxString,
					buildMinString,
					currentOSVersion,
					runningEnvironment,
					architecture];
}

@end