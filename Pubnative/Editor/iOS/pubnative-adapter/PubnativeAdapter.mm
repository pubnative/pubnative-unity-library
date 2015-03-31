//
//  PubnativeAdapter.m
//  Unity-iPhone
//
//  Created by David Martin on 04/12/14.
//
//

#import "PubnativeAdapter.h"
#import "Pubnative.h"

typedef NS_ENUM(NSInteger, Adapter_AdType)
{
    Adapter_AdType_Interstitial = 0,
    Adapter_AdType_Video = 1

};

@interface PubnativeAdapter () <PubnativeAdDelegate>

+ (instancetype)sharedAdapter;

@end

@implementation PubnativeAdapter

+ (instancetype)sharedAdapter
{
    static PubnativeAdapter *_sharedAdapter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAdapter = [[PubnativeAdapter alloc] init];
    });
    return _sharedAdapter;
}

- (void)request:(Adapter_AdType)type withToken:(NSString*)appToken
{
    Pubnative_AdType adType = Pubnative_AdType_Interstitial;
    switch (type)
    {
        case Adapter_AdType_Interstitial:   adType = Pubnative_AdType_Interstitial;       break;
        case Adapter_AdType_Video:          adType = Pubnative_AdType_VideoInterstitial;  break;
    }
    [Pubnative requestAdType:adType
                withAppToken:appToken
                 andDelegate:self];
}

#pragma mark - CALLBACKS -

#pragma mark PubnativeAdDelegate

- (void)pnAdDidLoad:(UIViewController *)ad
{
    UnitySendMessage("PNAdapter_Instance", "pn_ad_loaded", "");
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:ad animated:YES completion:nil];
}

- (void)pnAdReady:(UIViewController *)ad {}
- (void)pnAdDidFail:(NSError *)error 
{
    UnitySendMessage("PNAdapter_Instance", "pn_ad_error", [[NSString stringWithFormat:@"%@", [error localizedDescription]] UTF8String]);
}
- (void)pnAdWillShow {}
- (void)pnAdDidShow 
{
    UnitySendMessage("PNAdapter_Instance", "pn_ad_shown", "");
}
- (void)pnAdWillClose {}
- (void)pnAdDidClose 
{
    UnitySendMessage("PNAdapter_Instance", "pn_ad_closed", "");
}

@end

extern "C" void Pubnative_Request(Adapter_AdType adType, const char* appToken)
{
    NSString *appTokenString = [NSString stringWithCString:appToken encoding:NSUTF8StringEncoding];
    [[PubnativeAdapter sharedAdapter] request:adType withToken:appTokenString];
}

