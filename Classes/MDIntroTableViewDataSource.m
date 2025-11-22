//
//  MDIntroTableViewDataSource.m
//  MameDaifuku
//
//  Created by Me on 25/11/22.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDIntroTableViewDataSource.h"

@implementation MDIntroTableViewDataSource
@end

@implementation MDIntroTableViewDataSource (UITableViewDataSource)

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;
{
	UITableViewCell *cell = nil;
	NSString *reuseID = @"Reuse";
	cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
	if (!cell) { cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:reuseID] autorelease]; }
	switch (indexPath.section) {
		case 0:
			[cell setText:[NSString stringWithFormat:@"[UIImage imageNamed:\@\"mamedaifuku.png\"]", indexPath.section, indexPath.row]];
			break;
		case 1:
			[cell setText:[NSString stringWithFormat:
										 @"Hello, I'm MameDaifuku, an iPhone App. I've been "
										 @"developed and deployed on a very special iMac G4 "
										 @"called IchigoDaifuku. Even though Apple never "
										 @"allowed iPhone development on PowerPC Macs, I think "
										 @"I am proof that it is indeed possible.", 
										 indexPath.section, indexPath.row]];
			break;
	}
	return cell;
}

-(NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section;
{
	return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView;
{
	return 2;
}

-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section;
{
	switch (section) {
		case 0:  return @"Picture";
		case 1:  return @"Bio";
		default: return nil;
	}
}

@end