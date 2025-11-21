//
//  MDInfoTableViewCells.h
//  MameDaifuku
//
//  Created by Me on 25/11/21.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MDInfoTableViewCellSegmented: UITableViewCell {
	UISegmentedControl *_segment;
	UILabel *_label;
}

@property (nonatomic, retain) UISegmentedControl *segment;
@property (nonatomic, retain) UILabel *label;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
