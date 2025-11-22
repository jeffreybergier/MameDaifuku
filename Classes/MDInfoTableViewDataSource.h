//
//  MDInfoTableViewDataSource.h
//  MameDaifuku
//
//  Created by Me on 25/11/20.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDInfoTableViewDataSource: NSObject
{
	NSDateFormatter *_dateFormatter;
	NSNumberFormatter *_numberFormatter;
}

@property (readonly) NSDateFormatter *dateFormatter;
@property (readonly) NSNumberFormatter *numberFormatter;

@end

@interface MDInfoTableViewDataSource (UITableViewDataSource) <UITableViewDataSource>
@end
