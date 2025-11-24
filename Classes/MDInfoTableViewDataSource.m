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
#import "XPCrossPlatform.h"

typedef enum {
	MDInfoTableViewDataSourceSectionOS,
	MDInfoTableViewDataSourceSectionEnv,
	MDInfoTableViewDataSourceSectionHardware,
} MDInfoTableViewDataSourceSection;

typedef enum {
	MDInfoTableViewDataSourceRowOSCurrent,
	MDInfoTableViewDataSourceRowOSBuild,
	MDInfoTableViewDataSourceRowOSMin,
} MDInfoTableViewDataSourceRowOS;

typedef enum {
	MDInfoTableViewDataSourceRowEnvArch,
	MDInfoTableViewDataSourceRowEnvSim,
} MDInfoTableViewDataSourceRowEnv;

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

-(id)initWithTableViewController:(UITableViewController*)tableVC;
{
	self = [self init];
	NSParameterAssert(self);
	[[tableVC tableView] setDataSource:self];
	[[tableVC tableView] XP_setAllowsSelection:NO];
	[tableVC setTitle:NSLocalizedString(@"TitleInfo", nil)];
	[tableVC setTabBarItem:
	 [[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"TitleInfo", nil) 
																	image:[UIImage imageNamed:@"microchip.png"] 
																		tag:0] autorelease]];
	return self;
}

-(void)populateEnvCell:(MDInfoTableViewCellSegmented*)cell atIndex:(NSInteger)index;
{
	NSString *key = nil;
	UISegmentedControl *segment = [cell segment];
	NSInteger selectedSegment = -1;
	switch (index) {
		case MDInfoTableViewDataSourceRowEnvArch:
			key = NSLocalizedString(@"SubEnvArch", nil);
			[segment insertSegmentWithTitle:NSLocalizedString(@"ValueARM", nil) atIndex:0 animated:NO];
			[segment insertSegmentWithTitle:NSLocalizedString(@"ValueX86", nil) atIndex:1 animated:NO];
			[segment insertSegmentWithTitle:NSLocalizedString(@"ValuePPC", nil) atIndex:2 animated:NO];
			if (SISIsArchARMFamily())   { selectedSegment = 0; }
			if (SISIsArchIntelFamily()) { selectedSegment = 1; }
			if (SISIsArchPPCFamily())   { selectedSegment = 2; }
			break;
		case MDInfoTableViewDataSourceRowEnvSim:
			key = NSLocalizedString(@"SubEnvDevice", nil);
			[segment insertSegmentWithTitle:NSLocalizedString(@"ValueDev", nil) atIndex:0 animated:NO];
			[segment insertSegmentWithTitle:NSLocalizedString(@"ValueSim", nil) atIndex:1 animated:NO];
			selectedSegment = SISIsTargetSimulator() ? 1 : 0;
			break;
	}
	[segment setSelectedSegmentIndex:selectedSegment];
	[[cell label] setText:key];	
}

-(void)populateOSCell:(MDInfoTableViewCellKeyValue*)cell atIndex:(NSInteger)index;
{
	NSString *key = nil;
	NSString *value = nil;
	switch (index) {
		case MDInfoTableViewDataSourceRowOSCurrent:
			key = NSLocalizedString(@"SubOSRun", nil);
			value = SISGetCurrentOSVersion();
			break;
		case MDInfoTableViewDataSourceRowOSBuild:
			key = NSLocalizedString(@"SubOSBuild", nil);
			value = SISGetCompileTimeMaxOSVersion();
			break;
		case MDInfoTableViewDataSourceRowOSMin:
			key = NSLocalizedString(@"SubOSMin", nil);
			value = SISGetCompileTimeMinOSVersion();
			break;
	}
	[[cell keyLabel] setText:key];
	[[cell valueLabel] setText:value];
}

-(void)populateHardwareCell:(MDInfoTableViewCellKeyValue*)cell atIndex:(NSInteger)index;
{
	NSString *key = nil;
	NSString *value = nil;
	NSNumberFormatter *nf = [self numberFormatter];
	NSDateFormatter *df = [self dateFormatter];
	switch (index) {
		case MDInfoTableViewDataSourceRowHardwareMachine:
			key = NSLocalizedString(@"SubHardMachine", nil);
			value = SISGetHWMachine();
			break;
		case MDInfoTableViewDataSourceRowHardwareModel:
			key = NSLocalizedString(@"SubHardModel", nil);
			value = SISGetHWModel();
			break;
		case MDInfoTableViewDataSourceRowHardwareNCPU:
			key = NSLocalizedString(@"SubHardNCPU", nil);
			value = [nf stringFromNumber:[NSNumber numberWithUnsignedInt:SISGetHWNCPU()]];
			break;
		case MDInfoTableViewDataSourceRowHardwareMemSize:
			key = NSLocalizedString(@"SubHardRAM", nil);
			value = [nf stringFromNumber:[NSNumber numberWithUnsignedLongLong:SISGetHWMemSize()]];
			break;
		case MDInfoTableViewDataSourceRowHardwarePageSize:
			key = NSLocalizedString(@"SubHardPage", nil);
			value = [nf stringFromNumber:[NSNumber numberWithUnsignedLongLong:SISGetHWPageSize()]];
			break;
		case MDInfoTableViewDataSourceRowHardwareOSRelease:
			key = NSLocalizedString(@"SubHardRelease", nil);
			value = SISGetKernOSRelease();
			break;
		case MDInfoTableViewDataSourceRowHardwareOSVersion:
			key = NSLocalizedString(@"SubHardVersion", nil);
			value = SISGetKernOSVersion();
			break;
		case MDInfoTableViewDataSourceRowHardwareOSHostname:
			key = NSLocalizedString(@"SubHardHost", nil);
			value = SISGetKernHostname();
			break;
		case MDInfoTableViewDataSourceRowHardwareBootTime:
			key = NSLocalizedString(@"SubHardBoot", nil);
			value = [df stringFromDate:SISGetKernBootTime()];
			break;
	}
	[[cell keyLabel] setText:key];
	[[cell valueLabel] setText:value];
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
		case MDInfoTableViewDataSourceSectionOS:       return 3;
		case MDInfoTableViewDataSourceSectionEnv:      return 2;
		case MDInfoTableViewDataSourceSectionHardware: return 9;
		default: return 0;
	}
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;
{
	UITableViewCell *cell = nil;
	NSString *reuseID = nil;
	switch (indexPath.section) {
		case MDInfoTableViewDataSourceSectionOS:
			reuseID = @"OSCell";
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { cell = [[[MDInfoTableViewCellKeyValue alloc] initWithReuseIdentifier:reuseID] autorelease]; }
			[self populateOSCell:(MDInfoTableViewCellKeyValue*)cell atIndex:indexPath.row];
			break;
		case MDInfoTableViewDataSourceSectionEnv:
			reuseID = @"EnvCell";
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { cell = [[[MDInfoTableViewCellSegmented alloc] initWithReuseIdentifier:reuseID] autorelease]; }
			[self populateEnvCell:(MDInfoTableViewCellSegmented*)cell atIndex:indexPath.row];
			break;
		case MDInfoTableViewDataSourceSectionHardware:
			reuseID = @"SystemCell";
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { cell = [[[MDInfoTableViewCellKeyValue alloc] initWithReuseIdentifier:reuseID] autorelease]; }
			[self populateHardwareCell:(MDInfoTableViewCellKeyValue*)cell atIndex:indexPath.row];
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
		case MDInfoTableViewDataSourceSectionOS:       return NSLocalizedString(@"SectionOS", nil);
		case MDInfoTableViewDataSourceSectionEnv:      return NSLocalizedString(@"SectionEnv", nil);
		case MDInfoTableViewDataSourceSectionHardware: return NSLocalizedString(@"SectionHard", nil);
		default: return nil;
	}
}

@end
