//
//  MDIntroTableViewDataSource.m
//  MameDaifuku
//
//  Created by Me on 25/11/22.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDIntroTableViewDataSource.h"
#import "XPCrossPlatform.h"

static const CGFloat kVPadding = 4;
static const CGFloat kHPadding = 8;
static       UIFont *kBioFont  = nil;

@interface MDIntroTableViewCellImage: UITableViewCell {
	UIImageView *_MD_imageView;
}
@property (readonly) UIImageView *MD_imageView;
+(CGFloat)heightForCellWithImage:(UIImage*)image;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end

@implementation MDIntroTableViewCellImage

@synthesize MD_imageView = _MD_imageView;

+(CGFloat)heightForCellWithImage:(UIImage*)image;
{
	NSParameterAssert(image);
	return [image size].height+(kVPadding*2);
}

-(id)init; 
{ 
  NSAssert(NO, @"Designated Initializer: initWithReuseIdentifier:");
	return nil;
}

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	NSParameterAssert(self);
	_MD_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	[_MD_imageView setContentMode:UIViewContentModeCenter];
	[_MD_imageView setClipsToBounds:YES];
	[[self contentView] addSubview:_MD_imageView];
	return self;
}

-(void)layoutSubviews;
{
	[super layoutSubviews];
	CGRect bounds = [[self contentView] bounds];
	CGRect frame = CGRectMake(kVPadding, kVPadding, 
														bounds.size.width-(kVPadding*2), 
														bounds.size.height-(kVPadding*2));
	[[self MD_imageView] setFrame:frame];
}

-(void)dealloc;
{
	[_MD_imageView release];
	[super dealloc];
}

@end

@interface MDIntroTableViewCellLabel: UITableViewCell {
	UILabel *_MD_textLabel;
}
@property (readonly) UILabel *MD_textLabel;
+(UIFont*)labelFont;
+(CGFloat)heightForCellWithString:(NSString*)string tableViewWidth:(CGFloat)width;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end

@implementation MDIntroTableViewCellLabel

@synthesize MD_textLabel = _MD_textLabel;

+(UIFont*)labelFont;
{
	if (!kBioFont) {
	  kBioFont = [[UIFont systemFontOfSize:18] retain];
	}
	NSParameterAssert(kBioFont);
	return kBioFont;
}
+(CGFloat)heightForCellWithString:(NSString*)string tableViewWidth:(CGFloat)width;
{
	NSParameterAssert(string);
	CGSize output = CGSizeZero;
	output = [string sizeWithFont:[self labelFont] 
							constrainedToSize:CGSizeMake(width-(kHPadding*2), CGFLOAT_MAX)];
	output.height += (kVPadding*2);
	return output.height;
}

-(id)init; 
{ 
  NSAssert(NO, @"Designated Initializer: initWithReuseIdentifier:");
	return nil;
}

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	NSParameterAssert(self);
	_MD_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	[_MD_textLabel setFont:[[self class] labelFont]];
	[_MD_textLabel setNumberOfLines:0];
	[[self contentView] addSubview:_MD_textLabel];
	return self;
}

-(void)layoutSubviews;
{
	[super layoutSubviews];
	CGRect bounds = [[self contentView] bounds];
	CGRect frame = CGRectMake(kHPadding, kVPadding, 
														bounds.size.width-(kHPadding*2), 
														bounds.size.height-(kVPadding*2));
	[[self MD_textLabel] setFrame:frame];
}

-(void)dealloc;
{
	[_MD_textLabel release];
	[super dealloc];
}

@end

@implementation MDIntroTableViewDataSource

@synthesize pic = _pic;
@synthesize bio = _bio;

-(id)init; 
{ 
	self = [super init];
	NSParameterAssert(self);
	_pic = [[UIImage imageNamed:@"profile.png"] retain];
	_bio = @"Hello, I'm MameDaifuku, an iPhone App. I've been "
	       @"developed and deployed on a very special iMac G4 "
	       @"called IchigoDaifuku. Even though Apple never "
	       @"allowed iPhone development on PowerPC Macs, I think "
	       @"I am proof that it is indeed possible.";
	NSParameterAssert(_pic);
	NSParameterAssert(_bio);
	return self;
}

-(id)initWithTableViewController:(UITableViewController*)tableVC;
{
  self = [self init];
	NSParameterAssert(self);
	[[tableVC tableView] setDataSource:self];
	[[tableVC tableView] setDelegate:self];
	[[tableVC tableView] XP_setAllowsSelection:NO];
	[tableVC setTitle:@"自己紹介"];
	[tableVC setTabBarItem:
	 [[[UITabBarItem alloc] initWithTitle:@"自己紹介" 
																	image:[UIImage imageNamed:@"address.png"] 
																		tag:0] autorelease]];
	return self;
}

-(void)dealloc;
{
	[_pic release];
	[_bio release];
	[super dealloc];
}

@end

@implementation MDIntroTableViewDataSource (UITableViewDataSource)

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;
{
	UITableViewCell *cell = nil;
	NSString *reuseID = nil;
	switch (indexPath.section) {
		case 0:
			reuseID = @"Pic";
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { cell = [[[MDIntroTableViewCellImage alloc] initWithReuseIdentifier:reuseID] autorelease]; }
			[[(MDIntroTableViewCellImage*)cell MD_imageView] setImage:[self pic]];
			break;
		case 1:
			reuseID = @"Bio";
			cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
			if (!cell) { cell = [[[MDIntroTableViewCellLabel alloc] initWithReuseIdentifier:reuseID] autorelease]; }
			[[(MDIntroTableViewCellLabel*)cell MD_textLabel] setText:[self bio]];
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
		case 0:  return @"Pic";
		case 1:  return @"Bio";
		default: return nil;
	}
}

@end

@implementation MDIntroTableViewDataSource (UITableViewDelegate)
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;
{
  switch (indexPath.section) {
		case 0: return [MDIntroTableViewCellImage heightForCellWithImage: [self pic]];
		case 1: return [MDIntroTableViewCellLabel heightForCellWithString:[self bio] 
																											 tableViewWidth:[tableView frame].size.width];
		default: return -1;
	}
}
@end