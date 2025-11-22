//
//  MDInfoTableViewCells.h
//  MameDaifuku
//
//  Created by Me on 25/11/21.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDInfoTableViewCellKeyValue: UITableViewCell {
	UILabel *_keyLabel;
	UILabel *_valueLabel;
}

@property (nonatomic, retain) UILabel *keyLabel;
@property (nonatomic, retain) UILabel *valueLabel;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end

@interface MDInfoTableViewCellSegmented: UITableViewCell {
	UISegmentedControl *_segment;
	UILabel *_label;
	NSInteger _osMajor;
}

@property (nonatomic, retain) UISegmentedControl *segment;
@property (nonatomic, retain) UILabel *label;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
