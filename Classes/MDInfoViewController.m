//
//  MDRootViewController.m
//  MameDaifuku
//
//  Created by Me on 25/11/19.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDInfoViewController.h"

@implementation MDInfoViewController

@synthesize language = _language;

-(void)viewDidLoad;
{
	[super viewDidLoad];
	if ([self language] == 0) {
		[[self view] setBackgroundColor:[UIColor greenColor]];
	} else {
		[[self view] setBackgroundColor:[UIColor blueColor]];
	}
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
{
  return YES;
}

-(void)viewDidUnload;
{
	// Release any retained subviews of the main view.
}


-(void)dealloc;
{
	[super dealloc];
}


@end
