//
//  PNAdRequest.h
//
//  Created by Csongor Nagy on 04/06/14.
//  Copyright (c) 2014 PubNative
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "PNAdRequestParameters.h"

typedef void (^PNAdRequestCompletionBlock)(NSArray *ads, NSError *error);

typedef NS_ENUM(NSInteger, PNAdRequestType)
{
    PNAdRequest_Native,
    PNAdRequest_Native_Video,
    PNAdRequest_Image
};

typedef NS_ENUM(NSInteger, PNFeedType)
{
    PNFeed_Native_Banner,
    PNFeed_Native_Icon,
    PNFeed_Native_Video,
    PNFeed_Native_Carousel,
    PNFeed_Native_InFeed
};

@interface PNAdRequest : NSObject

+ (instancetype)request:(PNAdRequestType)type
         withParameters:(PNAdRequestParameters *)parameters
          andCompletion:(PNAdRequestCompletionBlock)completionBlock;

- (void)startRequest;

@end