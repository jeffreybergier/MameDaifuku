//
//  MDIntroTableViewDataSource.h
//  MameDaifuku
//
//  Created by Me on 25/11/22.
//  Copyright 2025 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDIntroTableViewDataSource: NSObject
@end

@interface MDIntroTableViewDataSource (UITableViewDataSource) <UITableViewDataSource>
@end

@interface MDIntroTableViewDataSource (UITableViewDelegate) <UITableViewDelegate>
@end