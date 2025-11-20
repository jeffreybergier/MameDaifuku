//
//  MDRootViewController.m
//  MameDaifuku
//
//  Created by Me on 25/11/19.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import "MDIntroViewController.h"

@implementation MDIntroViewController

-(void)viewDidLoad;
{
	[super viewDidLoad];
	
	CGFloat labelY = 240;
	CGFloat labelPad = 8;
	CGRect bounds = [[self view] bounds];
	UIView *view = [self view];
	NSString *introText = @"Hello, I'm MameDaifuku, an iPhone App. I've been "
	                      @"developed and deployed on a very special iMac G4 "
	                      @"called IchigoDaifuku. Even though Apple never "
	                      @"allowed iPhone development on PowerPC Macs, I think "
	                      @"I am proof that it is indeed possible.";
	
	// Configure the image
	UIImage *image = [UIImage imageNamed:@"mamedaifuku.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	[imageView setFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, labelY)];
	[imageView setContentMode:UIViewContentModeCenter];
	[view addSubview:imageView];
	
	// Configure Label
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bounds.origin.x+labelPad, 
																														 bounds.origin.y+labelY+labelPad, 
																														 bounds.size.width-labelPad, 
																														 0)];
	[label setText:introText];
	[label setNumberOfLines:0];
	[label sizeToFit];
	[view addSubview:label];
	
	// Set background color
	[view setBackgroundColor:[UIColor whiteColor]];
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
