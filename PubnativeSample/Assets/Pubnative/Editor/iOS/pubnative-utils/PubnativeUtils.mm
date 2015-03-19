#import <AdSupport/AdSupport.h>

extern void UnityPause(bool pause);

@interface PubnativeUtils : NSObject

+ (NSString*)PubnativeIDFA;

@end

static PubnativeUtils *_sharedInstance;

@implementation PubnativeUtils

+ (PubnativeUtils*)sharedInstance
{
    if(_sharedInstance == nil)
    {
        _sharedInstance = [[PubnativeUtils alloc] init];
    }
    return _sharedInstance;
}

+ (NSString*)PubnativeIDFA
{
    return [[PubnativeUtils sharedInstance] PubnativeIDFA];
}

- (NSString*)PubnativeIDFA
{
    NSString *result = @"";
    
    if(NSClassFromString(@"ASIdentifierManager")) 
    {
        if([ASIdentifierManager sharedManager].advertisingTrackingEnabled)
        {
            result = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
        }
    }
    
    return result;
}

@end

extern "C" const char* PubnativeUserIDNative()
{
    return [[PubnativeUtils PubnativeIDFA] UTF8String];
}