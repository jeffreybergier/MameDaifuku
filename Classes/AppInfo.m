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
	NSString *buildSDKString;
    UIDevice *device = [UIDevice currentDevice];
    NSString *currentOSVersion = [device systemVersion];
    int buildVersionInt = __IPHONE_OS_VERSION_MIN_REQUIRED;
	
    // A. Running Environment (Simulator vs. Device)
#if TARGET_IPHONE_SIMULATOR
	runningEnvironment = @"Simulator";
#else
	runningEnvironment = @"Device";
#endif
	
    // B. CPU Architecture
    // Check for the specific simulator host architectures first
#if defined(__ppc__) || defined(__PPC__)
	architecture = @"PPC (Simulator)";
#elif defined(__i386__)
	architecture = @"i386 (Simulator)";
#elif defined(__arm__)
	architecture = @"ARM (Device)"; 
#else
	architecture = @"Unknown";
#endif

    
    // Convert the integer into a readable version string (e.g., 20201 -> 2.2.1)
    buildSDKString = [NSString stringWithFormat:@"%d.%d.%d SDK", 
						(buildVersionInt / 10000), 
						(buildVersionInt / 100) % 100, 
						(buildVersionInt % 100)];
	
    return [NSString stringWithFormat:
            @"Build SDK: %@\n"
            @"Environment: %@\n"
            @"Runtime OS: %@\n"
            @"Architecture: %@", 
            buildSDKString,
            runningEnvironment,
            currentOSVersion,
            architecture];
}

@end