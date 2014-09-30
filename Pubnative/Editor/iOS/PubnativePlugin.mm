#import "PubnativePlugin.h"
#import <AdSupport/AdSupport.h>

extern void UnityPause(bool pause);

@interface PubnativePlugin : NSObject

+ (NSString*)PubnativeIDFA;

@end

static PubnativePlugin *_sharedInstance;

@implementation PubnativePlugin

+ (PubnativePlugin*)sharedInstance
{
    if(_sharedInstance == nil)
    {
        _sharedInstance = [[PubnativePlugin alloc] init];
    }
    return _sharedInstance;
}

+ (NSString*)PubnativeIDFA
{
    return [[PubnativePlugin sharedInstance] PubnativeIDFA];
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

#ifdef __cplusplus

extern "C"
{
    const char* PubnativeUserIDNative()
    {
        return [[PubnativePlugin PubnativeIDFA] UTF8String];
    }
}

#endif