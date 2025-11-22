//
//  MDInfoTableViewCells.m
//  MameDaifuku
//
//  Created by Me on 25/11/21.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDInfoTableViewCells.h"

@implementation MDInfoTableViewCellKeyValue

@synthesize keyLabel = _keyLabel;
@synthesize valueLabel = _valueLabel;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	NSParameterAssert(self);
	_keyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	[_keyLabel setFont:[UIFont systemFontOfSize:14]];
	[_keyLabel setTextColor:[UIColor darkGrayColor]];
	[_valueLabel setFont:[UIFont boldSystemFontOfSize:18]];
	[_valueLabel setTextColor:[UIColor blackColor]];
	[[self contentView] addSubview:_keyLabel];
	[[self contentView] addSubview:_valueLabel];
	return self;
}

-(void)layoutSubviews;
{
	[super layoutSubviews];
	static CGFloat vPadding = 4;
	static CGFloat hPadding = 8;
	CGRect frame = CGRectZero;
	CGRect bounds = [[self contentView] bounds];
	CGFloat valueHeight = 0;
	UIView *key = [self keyLabel];
	UIView *value = [self valueLabel];
	
	[key sizeToFit];
	frame = [key frame];
	frame.origin = CGPointMake(bounds.size.width-frame.size.width-hPadding, 
														 bounds.size.height-frame.size.height-vPadding);
	[key setFrame:frame];
	[value sizeToFit];
	valueHeight = [value frame].size.height;
	[value setFrame:CGRectMake(hPadding, bounds.size.height-valueHeight-vPadding, 
														 bounds.size.width-frame.size.width-(hPadding*3), 
														 valueHeight)];
}

-(void)dealloc;
{
	[_keyLabel release];
	[_valueLabel release];
	[super dealloc];
}

@end

@implementation MDInfoTableViewCellSegmented

@synthesize segment = _segment;
@synthesize label = _label;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	NSParameterAssert(self);
  _osMajor = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
	_segment = [[UISegmentedControl alloc] initWithFrame:CGRectZero];
	_label = [[UILabel alloc] initWithFrame:CGRectZero];
	[_segment setUserInteractionEnabled:NO];
	[_label setFont:[UIFont systemFontOfSize:14]];
	[_label setTextColor:[UIColor darkGrayColor]];
	[[self contentView] addSubview:_segment];
	[[self contentView] addSubview:_label];
	return self;
}

-(void)layoutSubviews;
{
	[super layoutSubviews];
	static CGFloat vPadding = 4;
	static CGFloat hPadding = 8;
	CGRect frame = CGRectZero;
	CGRect bounds = [[self contentView] bounds];
	UILabel *label = [self label];
	UISegmentedControl *segment = [self segment];
	
	[label sizeToFit];
	frame = [label frame];
	frame.origin = CGPointMake(bounds.size.width-frame.size.width-hPadding, 
														 bounds.size.height-frame.size.height-vPadding);
	[label setFrame:frame];
	// Segment uses vPadding for X and Y to look even on top and bottom on left side
	[segment setFrame:CGRectMake(vPadding, vPadding, 
															 bounds.size.width-frame.size.width-(hPadding*3), 
															 bounds.size.height-(vPadding*2))];
}

-(void)prepareForReuse;
{
	if (_osMajor >= 3) {
		[_segment removeAllSegments];
	} else {
		// HACK: For 2.2.1 which does not remove all segments
		[_segment removeFromSuperview];
		[self setSegment:[[[UISegmentedControl alloc] initWithFrame:CGRectZero] autorelease]];
		[[self contentView] addSubview:_segment];
	}
	[super prepareForReuse];
}

-(void)dealloc;
{
	[_segment release];
	[_label release];
	[super dealloc];
}

@end
