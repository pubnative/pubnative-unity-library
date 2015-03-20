//
//  PNIconTableViewCell.h
//  PubNativeDemo
//
//  Created by David Martin on 12/02/15.
//  Copyright (c) 2015 PubNative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNNativeAdModel.h"

@interface PNIconTableViewCell : UITableViewCell

@property (nonatomic, strong) PNNativeAdModel *model;

- (void)willDisplayCell;
- (void)didEndDisplayingCell;

@end
