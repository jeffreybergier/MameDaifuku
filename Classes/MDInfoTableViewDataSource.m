//
//  MDInfoTableViewDataSource.m
//  MameDaifuku
//
//  Created by Me on 25/11/20.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDInfoTableViewDataSource.h"
#import "SystemInfo.h"

typedef enum {
	MDInfoTableViewDataSourceSectionBuild,
	MDInfoTableViewDataSourceSectionRun,
	MDInfoTableViewDataSourceSectionHardware,
} MDInfoTableViewDataSourceSection;

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
	[[cell detailTextLabel] setText:key];
	[[cell textLabel] setText:value];
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
			reuseID = @"Unknown";
			break;
		case MDInfoTableViewDataSourceSectionHardware:
			reuseID = @"SystemCell";
			break;
	}
	
	cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
	if (!cell) { 
	  cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
																	 reuseIdentifier:reuseID] autorelease];
	}
	
	switch (indexPath.section) {
		case MDInfoTableViewDataSourceSectionBuild:
		case MDInfoTableViewDataSourceSectionRun:
			[cell setText:@"TODO://"];
			break;
		case MDInfoTableViewDataSourceSectionHardware:
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
