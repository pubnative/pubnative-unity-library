//
//  PNVideoInterstitialViewController.h
//  PubNativeDemo
//
//  Created by David Martin on 05/02/15.
//  Copyright (c) 2015 PubNative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNNativeVideoAdModel.h"
#import "PubnativeAdDelegate.h"

@interface PNVideoInterstitialViewController : UIViewController

@property (nonatomic, strong) NSObject<PubnativeAdDelegate> *delegate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                          model:(PNNativeVideoAdModel*)model;

@end
