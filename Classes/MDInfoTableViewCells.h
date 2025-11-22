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

@property (readonly) UILabel *keyLabel;
@property (readonly) UILabel *valueLabel;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end

@interface MDInfoTableViewCellSegmented: UITableViewCell {
	UISegmentedControl *_segment;
	UILabel *_label;
	NSInteger _osMajor;
}

@property (readonly) UISegmentedControl *segment;
@property (readonly) UILabel *label;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
