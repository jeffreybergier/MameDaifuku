//
//  MDInfoTableViewCells.m
//  MameDaifuku
//
//  Created by Me on 25/11/21.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDInfoTableViewCells.h"


@implementation MDInfoTableViewCellSegmented

@synthesize segment = _segment;
@synthesize label = _label;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
{
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
	NSParameterAssert(self);
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
	CGFloat padding = 4;
	CGRect frame = CGRectZero;
	CGRect bounds = [[self contentView] bounds];
	UILabel *label = [self label];
	UISegmentedControl *segment = [self segment];
	
	[label sizeToFit];
	frame = [label frame];
	frame.origin = CGPointMake(bounds.size.width-frame.size.width-padding, 
														 bounds.size.height-frame.size.height-padding);
	[label setFrame:frame];
	
	[segment setFrame:CGRectMake(padding, padding, 
															 bounds.size.width-frame.size.width-(padding*3), 
															 bounds.size.height-(padding*2))];
}

-(void)prepareForReuse;
{
	NSInteger osMajor = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
	if (osMajor >= 3) {
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
