//
//  MDInfoTableViewDataSource.m
//  MameDaifuku
//
//  Created by Me on 25/11/20.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDInfoTableViewDataSource.h"
#import "MDInfoTableViewCells.h"
#import "SystemInfo.h"

typedef enum {
	MDInfoTableViewDataSourceSectionBuild,
	MDInfoTableViewDataSourceSectionRun,
	MDInfoTableViewDataSourceSectionHardware,
} MDInfoTableViewDataSourceSection;

typedef enum {
	MDInfoTableViewDataSourceRowRunOS,
} MDInfoTableViewDataSourceRowRun;

typedef enum {
	MDInfoTableViewDataSourceRowHardwareMachine,
	MDInfoTableViewDataSourceRowHardwareModel,
	MDInfoTableViewDataSourceRowHardwareNCPU,
	MDInfoTableViewDataSourceRowHardwareMemSize,
	MDInfoTableViewDataSourceRowHardwarePageSize,
	MDInfoTableViewDataSourceRowHardwareOSRelease,
	MDInfoTableViewDataSourceRowHardwareOSVersion,
	MDInfoTableViewDataSourceRowHardwareOSHostname,
	MDInfoTableViewDataSourceRowHardwareBootTime,
} MDInfoTableViewDataSourceRowHardware;

@implementation MDInfoTableViewDataSource

@synthesize dateFormatter = _dateFormatter;
@synthesize numberFormatter = _numberFormatter;

-(id)init;
{
	self = [super init];
	NSParameterAssert(self);
	_dateFormatter = [[NSDateFormatter alloc] init];
	_numberFormatter = [[NSNumberFormatter alloc] init];
	[_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	return self;
}

-(void)populateRunCell:(MDInfoTableViewCellSegmented*)cell atIndex:(NSInteger)index;
{
	NSString *key = nil;
	NSString *rawValue = nil;
	UISegmentedControl *segment = [cell segment];
	NSInteger selectedSegment = -1;
	switch (index) {
		case MDInfoTableViewDataSourceRowRunOS:
			key = @"iPhoneOS";
			// TODO: Change this to use 2,3,4,5,6
			[segment insertSegmentWithTitle:@"2.2.1" atIndex:0 animated:NO];
			[segment insertSegmentWithTitle:@"3.0" atIndex:1 animated:NO];
			[segment insertSegmentWithTitle:@"3.1" atIndex:2 animated:NO];
			[segment insertSegmentWithTitle:@"3.1.3" atIndex:3 animated:NO];
			// Change this to use integer and then just base the answer on the first digit
			rawValue = SISGetCurrentOSVersion();
			if ([rawValue isEqualToString:@"2.2.1"]) { selectedSegment = 0; }
			else if ([rawValue isEqualToString:@"3.0"]) { selectedSegment = 1; }
			else if ([rawValue isEqualToString:@"3.1"]) { selectedSegment = 2; }
			else if ([rawValue isEqualToString:@"3.1.3"]) { selectedSegment = 3; }
			break;
	}
	[segment setSelectedSegmentIndex:selectedSegment];
	[[cell label] setText:key];	
}

-(void)populateSystemCell:(UITableViewCell*)cell atIndex:(NSInteger)index;
{
	NSString *key = nil;
	NSString *value = nil;
	NSNumberFormatter *nf = [self numberFormatter];
	NSDateFormatter *df = [self dateFormatter];
	switch (index) {
		case MDInfoTableViewDataSourceRowHardwareMachine:
			key = @"Machine";
			value = SISGetHWMachine();
			break;
		case MDInfoTableViewDataSourceRowHardwareModel:
			key = @"Model";
			value = SISGetHWModel();
			break;
		case MDInfoTableViewDataSourceRowHardwareNCPU:
			key = @"CPU Cores";
			value = [nf stringFromNumber:[NSNumber numberWithInteger:SISGetHWNCPU()]];
			break;
		case MDInfoTableViewDataSourceRowHardwareMemSize:
			key = @"Memory";
			value = [nf stringFromNumber:[NSNumber numberWithInteger:SISGetHWMemSize()]];
			break;
		case MDInfoTableViewDataSourceRowHardwarePageSize:
			key = @"Page Size";
			value = [nf stringFromNumber:[NSNumber numberWithInteger:SISGetHWPageSize()]];
			break;
		case MDInfoTableViewDataSourceRowHardwareOSRelease:
			key = @"Release";
			value = SISGetKernOSRelease();
			break;
		case MDInfoTableViewDataSourceRowHardwareOSVersion:
			key = @"Version";
			value = SISGetKernOSVersion();
			break;
		case MDInfoTableViewDataSourceRowHardwareOSHostname:
			key = @"Hostname";
			value = SISGetKernHostname();
			break;
		case MDInfoTableViewDataSourceRowHardwareBootTime:
			key = @"Boot Time";
			value = [df stringFromDate:SISGetKernBootTime()];
			break;
	}
	// TODO: Make a custom cell with these properties
	// [[cell detailTextLabel] setText:key];
	// [[cell textLabel] setText:value];
	[cell setText:value];
}

-(void)dealloc;
{
	[_numberFormatter release];
	[_dateFormatter release];
	[super dealloc];
}

@end

@implementation MDInfoTableViewDataSource (UITableViewDataSource)

-(NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section;
{
	switch (section) {
		case MDInfoTableViewDataSourceSectionBuild:    return 1;
		case MDInfoTableViewDataSourceSectionRun:      return 1;
		case MDInfoTableViewDataSourceSectionHardware: return 9;
		default: return 0;
	}
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;
{
	UITableViewCell *cell = nil;
	NSString *reuseID = nil;
	switch (indexPath.section) {
		case MDInfoTableViewDataSourceSectionBuild:
		case MDInfoTableViewDataSourceSectionRun:
			reuseID = @"RunCell";
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { 
				cell = [[[MDInfoTableViewCellSegmented alloc] initWithReuseIdentifier:reuseID] autorelease];
			}
			// TODO: Figure out why removeAllSegments is not working
			[[(MDInfoTableViewCellSegmented*)cell segment] removeAllSegments];
			[self populateRunCell:(MDInfoTableViewCellSegmented*)cell atIndex:indexPath.row];
			break;
		case MDInfoTableViewDataSourceSectionHardware:
			reuseID = @"SystemCell";
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { 
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
																			 reuseIdentifier:reuseID] autorelease];
			}
			[self populateSystemCell:cell atIndex:indexPath.row];
			break;
	}
	
	return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView;
{
	return 3;
}

-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section;
{
	switch (section) {
		case MDInfoTableViewDataSourceSectionBuild:    return @"Build";
		case MDInfoTableViewDataSourceSectionRun:      return @"Run";
		case MDInfoTableViewDataSourceSectionHardware: return @"System";
		default: return nil;
	}
}

@end
