//
//  MDIntroTableViewDataSource.m
//  MameDaifuku
//
//  Created by Me on 25/11/22.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDIntroTableViewDataSource.h"

@interface MDIntroTableViewCellImage: UITableViewCell {
	UIImageView *_MD_imageView;
}
@property (readonly) UIImageView *MD_imageView;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end

@implementation MDIntroTableViewCellImage

@synthesize MD_imageView = _MD_imageView;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	NSParameterAssert(self);
	_MD_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	[_MD_imageView setContentMode:UIViewContentModeCenter];
	[[self contentView] addSubview:_MD_imageView];
	return self;
}

-(void)layoutSubviews;
{
	[super layoutSubviews];
	[[self MD_imageView] setFrame:[[self contentView] bounds]];
}

-(void)dealloc;
{
	[_MD_imageView release];
	[super dealloc];
}

@end

@implementation MDIntroTableViewDataSource
@end

@implementation MDIntroTableViewDataSource (UITableViewDataSource)

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;
{
	UITableViewCell *cell = nil;
	NSString *reuseID = @"Reuse";
	switch (indexPath.section) {
		case 0:
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { cell = [[[MDIntroTableViewCellImage alloc] initWithReuseIdentifier:reuseID] autorelease]; }
			[[(MDIntroTableViewCellImage*)cell MD_imageView] setImage:[UIImage imageNamed:@"mamedaifuku.png"]];
			break;
		case 1:
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:reuseID] autorelease]; }
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

@implementation MDIntroTableViewDataSource (UITableViewDelegate)
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
  switch (indexPath.section) {
		case 0:  return 230;
		case 1:  return 44;
		default: return -1;
	}
}
@end