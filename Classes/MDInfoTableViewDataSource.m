//
//  MDInfoTableViewDataSource.m
//  MameDaifuku
//
//  Created by Me on 25/11/20.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDInfoTableViewDataSource.h"


@implementation MDInfoTableViewDataSource
@end

@implementation MDInfoTableViewDataSource (UITableViewDataSource)

-(NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section;
{
	return 3;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;
{
	return [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"1"] autorelease];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView;
{
	return 3;
}

-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section;
{
	return @"Section";
}

@end
