//
//  PNTableViewCellFeed.h
//  PubNativeDemo
//
//  Created by David Martin on 08/01/15.
//  Copyright (c) 2015 PubNative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNNativeVideoAdModel.h"

@interface PNVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) PNNativeVideoAdModel *model;

- (void)willDisplayCell;
- (void)didEndDisplayingCell;

@end