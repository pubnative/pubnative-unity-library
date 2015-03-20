//
//  PNIconTableViewCell.m
//  PubNativeDemo
//
//  Created by David Martin on 12/02/15.
//  Copyright (c) 2015 PubNative. All rights reserved.
//

#import "PNIconTableViewCell.h"
#import "PNTrackingManager.h"
#import "PNAdRenderingManager.h"
#import "PNAdConstants.h"

@interface PNIconTableViewCell ()

@property (strong, nonatomic) NSTimer       *impressionTimer;
@property (strong, nonatomic) UIImageView   *iconImageView;

@end

@implementation PNIconTableViewCell

#pragma mark NSObject

- (void)dealloc
{
    [self.iconImageView removeFromSuperview];
    self.iconImageView = nil;
    
    [self.impressionTimer invalidate];
    self.impressionTimer = nil;
    
    self.model = nil;
}

#pragma mark UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.iconImageView = [[UIImageView alloc] initWithFrame:self.frame];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.iconImageView];
        
        [self addSponsorLabel];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

#pragma mark PNIconTableViewCell

- (void)addSponsorLabel
{
    UILabel *sponsorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 115, 15)];
    sponsorLabel.font = [UIFont systemFontOfSize:9.0f];
    sponsorLabel.text = kPNAdConstantSponsoredContentString;
    sponsorLabel.textAlignment = NSTextAlignmentCenter;
    sponsorLabel.backgroundColor = [UIColor purpleColor];
    sponsorLabel.textColor = [UIColor whiteColor];
    sponsorLabel.alpha = 0.75f;
    [self addSubview:sponsorLabel];
}

- (void)willDisplayCell
{
    [self.impressionTimer invalidate];
    self.impressionTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(impressionTimerTick:) userInfo:nil repeats:NO];
    
    [self loadAd];
}

- (void)didEndDisplayingCell
{
    [self.impressionTimer invalidate];
    self.impressionTimer = nil;
}

- (void)loadAd
{
    PNNativeAdRenderItem *renderItem = [PNNativeAdRenderItem renderItem];
    renderItem.icon = self.iconImageView;
    [PNAdRenderingManager renderNativeAdItem:renderItem
                                      withAd:self.model];
}

- (void)iconTap:(UITapGestureRecognizer*)recognizer
{
    [self openOffer];
}

- (void)openOffer
{
    if(self.model && self.model.click_url)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.click_url]];
    }
}

- (void)impressionTimerTick:(NSTimer *)timer
{
    if([timer isValid])
    {
        [PNTrackingManager trackImpressionWithAd:self.model
                                      completion:nil];
    }
}

@end
