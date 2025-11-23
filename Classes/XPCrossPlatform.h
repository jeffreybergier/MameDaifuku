//
//  XPCrossPlatform.h
//  MameDaifuku
//
//  Created by Me on 25/11/23.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CrossPlatform)

@property (nonatomic, assign, setter=XP_setAllowsSelection:) BOOL XP_allowsSelection;

@end