![PNLogo](PNLogo.png)

[![Build Status](https://travis-ci.org/pubnative/pubnative-ios-library.svg?branch=master)](https://travis-ci.org/pubnative/pubnative-ios-library)[![Coverage Status](https://coveralls.io/repos/pubnative/pubnative-ios-library/badge.svg?branch=master)](https://coveralls.io/r/pubnative/pubnative-ios-library?branch=master)

PubNative is an API-based publisher platform dedicated to native advertising which does not require the integration of an SDK. Through PubNative, publishers can request over 20 parameters to enrich their ads and thereby create any number of combinations for unique and truly native ad units.

# pubnative-ios-library

pubnative-ios-library is a collection of Open Source tools to implement API based native ads in iOS.

## Requirements

* ARC only; iOS 6.1+
* An App Token provided in pubnative dashboard

## Dependencies

* This library is using the [YADMLib](https://github.com/cnagy/YADMLib) for networking and JSON to data model mapping.


## Install

1. Download this repository
2. Copy the PubNative folder into your Xcode project

## Native Ad Formats

1. Implement `PubnativeAdDelegate`.
2. Request an ad using `Pubnative` class
3. Wait for the callback with `PubnativeAdDelegate`. 

There are 5 types of predefined ads, please see the demo to have more info on how to operate with each. 

Here there is a sample for each one.

### 1) Interstitial

```objective-c
#import "Pubnative.h"
//==================================================================

@interface MyClass : UIViewController<PubnativeAdDelegate>

@property (nonatomic, strong)UIViewControllerViewController *interstitialVC;

#pragma mark - Pubnative Interface Methods

- (void)showInterstitial
{
    [Pubnative requestAdType:Pubnative_AdType_Interstitial
                withAppToken:@"YOUR_APP_TOKEN_HERE"
                 andDelegate:self];
}

#pragma mark - PubnativeAdDelegate Methods

- (void)pnAdDidLoad:(UIViewController*)ad
{
    // Hold an instance of the VC so it doesn't get released
    self.interstitialVC = ad;

    // Present the interstitial
    [self presentViewController:self.interstitialVC.view 
                       animated:YES 
                     completion:nil];
}

- (void)pnAdReady:(UIViewController*)ad;
- (void)pnAdDidFail:(NSError*)error;
- (void)pnAdWillShow;
- (void)pnAdDidShow;
- (void)pnAdWillClose;
- (void)pnAdDidClose
{
    self.interstitialVC = nil;
}

@end

//==================================================================
```

### 2) Banner

```objective-c
#import "Pubnative.h"
//==================================================================

@interface MyClass : UIViewController<PubnativeAdDelegate>

@property (nonatomic, strong)UIViewController *bannerVC;

#pragma mark - Pubnative Interface Methods

- (void)showBanner
{
    [Pubnative requestAdType:Pubnative_AdType_Banner
                withAppToken:@"YOUR_APP_TOKEN_HERE"
                 andDelegate:self];
}

#pragma mark - PubnativeAdDelegate Methods

- (void)pnAdDidLoad:(UIViewController*)ad
{
    // Hold an instance of the VC so it doesn't get released
    self.bannerVC = ad;

    // Put the banner whenever you want assiging a frame
    self.bannerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);

    // Add the banner
    [self.view addSubview:self.bannerVC.view];
}

- (void)pnAdReady:(UIViewController*)ad;
- (void)pnAdDidFail:(NSError*)error;
- (void)pnAdWillShow;
- (void)pnAdDidShow;
- (void)pnAdWillClose;
- (void)pnAdDidClose
{
    [self.bannerVC.view removeFromSuperview];
    self.bannerVC = nil;
}

@end

//==================================================================
```

### 3)Video banner

```objective-c
#import "Pubnative.h"
//==================================================================

@interface MyClass : UIViewController<PubnativeAdDelegate>

@property (nonatomic, strong)UIViewController *videoBannerVC;

#pragma mark Pubnative

- (void)showBanner
{
    [Pubnative requestAdType:Pubnative_AdType_VideoBanner
                withAppToken:@"YOUR_APP_TOKEN_HERE"
                 andDelegate:self];
}

#pragma mark - PubnativeAdDelegate Methods

- (void)pnAdDidLoad:(UIViewController*)ad
{
    // Hold an instance of the VC so it doesn't get released
    self.videoBannerVC = ad;

    // Put the banner whenever you want assiging a frame
    self.videoBannerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);

    // Add the banner
    [self.view addSubview:self.videoBannerVC.view];
}

- (void)pnAdReady:(UIViewController*)ad;
- (void)pnAdDidFail:(NSError*)error;
- (void)pnAdWillShow;
- (void)pnAdDidShow;
- (void)pnAdWillClose;
- (void)pnAdDidClose
{
    [self.videoBannerVC.view removeFromSuperview];
    self.videoBannerVC = nil;
}

@end

//==================================================================
```

### 4)Video interstitial

```objective-c
#import "Pubnative.h"
//==================================================================

@interface MyClass : UIViewController<PubnativeAdDelegate>

@property (nonatomic, strong)UIViewController *videoInterstitialVC;

#pragma mark Pubnative

- (void)showBanner
{
[Pubnative requestAdType:Pubnative_AdType_VideoInterstitial
            withAppToken:@"YOUR_APP_TOKEN_HERE"
             andDelegate:self];
}

#pragma mark - PubnativeAdDelegate Methods

- (void)pnAdDidLoad:(UIViewController*)ad
{
    // Hold an instance of the VC so it doesn't get released
    self.videoInterstitialVC = ad;

    // Present the interstitial
    [self presentViewController:self.videoInterstitialVC.view 
                       animated:YES 
                     completion:nil];
}

- (void)pnAdReady:(UIViewController*)ad;
- (void)pnAdDidFail:(NSError*)error;
- (void)pnAdWillShow;
- (void)pnAdDidShow;
- (void)pnAdWillClose;
- (void)pnAdDidClose
{
    self.videoInterstitialVC = nil;
}

@end

//==================================================================
```

### 5)Icon

```objective-c
#import "Pubnative.h"
//==================================================================

@interface MyClass : UIViewController<PubnativeAdDelegate>

@property (nonatomic, strong)UIViewController *iconVC;

#pragma mark Pubnative

- (void)showIcon
{
    [Pubnative requestAdType:Pubnative_AdType_Icon
                withAppToken:@"YOUR_APP_TOKEN_HERE"
                andDelegate:self];
}

#pragma mark - PubnativeAdDelegate Methods

- (void)pnAdDidLoad:(UIViewController*)ad
{
    // Hold an instance of the VC so it doesn't get released
    self.iconVC = ad;

    // Put the banner whenever you want assiging a frame
    self.iconVC.view.frame = CGRectMake(0, 0, 200, 200);

    // Add the icon
    [self.view addSubview:self.iconVC.view];
}

- (void)pnAdReady:(UIViewController*)ad;
- (void)pnAdDidFail:(NSError*)error;
- (void)pnAdWillShow;
- (void)pnAdDidShow;
- (void)pnAdWillClose;
- (void)pnAdDidClose
{
    [self.iconVC.view removeFromSuperview];
    self.iconVC = nil;
}

@end

//==================================================================
```

## In-Feed Ad Formats

Currently there are 5 types of In-Feed formats, please see the demo to have more info on how to operate with each. 

Here there is a sample implementation.

1. Your UIViewController must have an UITableView.
2. Set up the PNTableViewManager to manage your UITableView, make the request and build your table

```objective-c
@interface MyFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView      *tableView;
@property (strong, nonatomic) PNNativeAdModel           *model;
@property (strong, nonatomic) NSMutableArray            *ads;
@property (strong, nonatomic) PNAdRequest               *request;
@property (assign, nonatomic) PNFeedType                type;

@end

@implementation MyFeedViewController

#pragma mark NSObject

- (void)dealloc
{
    self.model = nil;
    self.eventModel = nil;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    PNAdRequestParameters *parameters = [PNAdRequestParameters requestParameters];
    [parameters fillWithDefaults];
    parameters.ad_count = @5;
    parameters.app_token = @"YOUR_APP_TOKEN_HERE";

    self.request = [PNAdRequest request:requestType
                         withParameters:parameters
                          andCompletion:^(NSArray *ads, NSError *error)
                          {
                              if(error)
                              {
                                  NSLog(@"Pubnative - Request error: %@", error);
                              }
                              else
                              {
                                  NSLog(@"Pubnative - Request end");
                                  weakSelf.ads = [[NSMutableArray alloc] initWithArray:ads];
                                  weakSelf.model = [ads firstObject];
                                  [self.tableView reloadData];
                              }
                          }];
    [self.request startRequest];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [PNTableViewManager controlTable:self.tableView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [PNTableViewManager controlTable:nil];
}

#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = nil;
    
    // In-Feed Video Player
    if (self.type == PNFeed_Native_Video)
    {
        PNVideoTableViewCell *videoCell = [tableView dequeueReusableCellWithIdentifier:videoCellID];
        if (!videoCell)
        {
            videoCell = [[PNVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                                    reuseIdentifier:videoCellID];
        }
        videoCell.model = self.model;
        result = videoCell;
    }
    // In-Feed Banner
    else if (self.type == PNFeed_Native_Banner)
    {
        PNBannerTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:bannerCellID];
        if(!bannerCell)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PNBannerTableViewCell" 
                                                                     owner:self options:nil];
            bannerCell = [topLevelObjects objectAtIndex:0];
        }

        videoCell.model = self.model;
        result = bannerCell;
    }
    // In-Feed Native
    else if (self.type == PNFeed_Native_InFeed)
    {
        PNNativeTableViewCell *nativeCell = [tableView dequeueReusableCellWithIdentifier:nativeCellID];
        if(!nativeCell)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PNNativeTableViewCell" 
                                                                     owner:self 
                                                                   options:nil];
            nativeCell = [topLevelObjects objectAtIndex:0];
        }

        videoCell.model = self.model;
        result = nativeCell;
    }
    // In-Feed Ad Carousel
    else if (self.type == PNFeed_Native_Carousel)
    {
        PNCarouselTableViewCell *carouselCell = [tableView dequeueReusableCellWithIdentifier:carouselCellID];
        if (!carouselCell)
        {
            carouselCell = [[PNCarouselTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                                          reuseIdentifier:videoCellID];
        }
        [carouselCell setCollectionData:self.ads];
        result = carouselCell;
    }
    // In-Feed Icon
    else if (self.type == PNFeed_Native_Icon)
    {
        PNIconTableViewCell *iconCell = [tableView dequeueReusableCellWithIdentifier:iconCellID];
        if (!iconCell)
        {
            iconCell = [[PNIconTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                                  reuseIdentifier:iconCellID];
        }

        videoCell.model = self.model;
        result = iconCell;
    }

    return result;
}

@end
```

## Advanced usage

1. **Request**: Using `PNAdRequest` and `PNAdRequestParameters`
2. **Show**: Manually, or using `PNAdRenderingManager` and `PNNativeAdRenderItem`
3. **Confirm impression**: By using `PNTrackingManager`

### 1) Request 

To start getting native ads from our API, you should import `PNAdRequest.h`.

You will need to create a PNAdRequestParameters for configuration and (like setting up your App token) and request the type of ad you need.

You just need to control that the returned type in the array of ads is different depending on the request type:

* `PNAdRequest_Native`: returns `PNNativeAdModel`
* `PNAdRequest_Native_Video`: returns `PNNativeVideoAdModel`
* `PNAdRequest_Image`: returns `PNImageAdModel`

```objective-c
#import "PNAdRequest.h"
//==================================================================
// Create a new request parameters and set it up configuring at least your app token
PNAdRequestParameters *parameters = [PNAdRequestParameters requestParameters];
parameters.app_token = @"YOUR_APP_TOKEN_HERE";
parameters.icon_size = @"400x400"; 

// Create the request and start it
__weak typeof(self) weakSelf = self;
self.request = [PNAdRequest request:PNAdRequest_Native
                    withParameters:parameters
                     andCompletion:^(NSArray *ads, NSError *error)
{
   if(error)
   {
       NSLog(@"Pubnative - error requesting ads: %@", [error description]);
   }
   else
   {
       NSLog(@"Pubnative - loaded PNNativeAdModel ads: %d", [ads count]);
   }
}];
[self.request startRequest];
//==================================================================
```

### 2) Show

Once the ads are downloaded, you can use them manually by accessing properties inside the model. We developed a tool that will work for most cases `PNAdRenderingManager` and `PNNativeAdRenderItem`.

Simply create and stick a `PNNativeAdRenderItem` to your custom view and make the `PNAdRenderingManager` fill it with the ad (saving you time for image download, field availability check, etc).

The following example shows you how to fill icon, title and cta_text:

```objective-c
#import "PNAdRenderingManager.h"
//==================================================================
PNNativeAdRenderItem *renderItem = [PNNativeAdRenderItem renderItem];
renderItem.icon = self.iconView;
renderItem.title = self.titleLabel;
renderItem.cta_text = self.ctaLaxbel;

[PNAdRenderingManager renderNativeAdItem:renderItem withAd:self.ad];
//==================================================================
```

### 3) Confirm impressions

We developed an utility to make you confirm impressions easier and safer, just send the ad you want to confirm to `PNTrackingManager` and it will confirmed.

Common standard is to call this only when your ad remains at least half of the view that holds your ad remains 1 second in the screen.

```objective-c
#import "PNTrackingManager.h"
//==================================================================
[PNTrackingManager trackImpressionWithAd:self.ad
                              completion:^(id result, NSError *error)
{
    // Do whatever you want once the ad is confirmed
}];
//==================================================================
```

## Misc

### License

This code is distributed under the terms and conditions of the MIT license.

### Contribution guidelines

**NB!** If you fix a bug you discovered or have development ideas, feel free to make a pull request.

