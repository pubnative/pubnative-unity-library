//
// PNPubnativeDelegateTests.m
//
// Created by David Martin on 30/01/15.
// Copyright (c) 2015 PubNative. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Pubnative.h"
#import "PNTestConstants.h"

@interface PNPubnativeDelegateTests : XCTestCase <PubnativeAdDelegate>

@property (assign, nonatomic)Pubnative_AdType currentAdType;


@property (strong, nonatomic)UIViewController *rootVC;
@property (strong, nonatomic)UIViewController *currentAdVC;
@property (strong, nonatomic)XCTestExpectation *didLoadExpectation;
@property (strong, nonatomic)XCTestExpectation *willShowExpectation;
@property (strong, nonatomic)XCTestExpectation *didShowExpectation;
@property (strong, nonatomic)XCTestExpectation *willCloseExpectation;
@property (strong, nonatomic)XCTestExpectation *didCloseExpectation;

@end

@implementation PNPubnativeDelegateTests

- (void)setUp
{
    [super setUp];
    self.rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    self.didLoadExpectation = [self expectationWithDescription:@"didLoadExpectation"];
    self.willShowExpectation = [self expectationWithDescription:@"willShowExpectation"];
    self.didShowExpectation = [self expectationWithDescription:@"didShowExpectation"];
    self.willCloseExpectation = [self expectationWithDescription:@"willCloseExpectation"];
    self.didCloseExpectation = [self expectationWithDescription:@"didCloseExpectation"];
    
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    if(self.currentAdVC)
    {
        [self.currentAdVC.view removeFromSuperview];
    }
    self.currentAdVC = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBanner
{
    self.currentAdType = Pubnative_AdType_Banner;
    [self requestAd];
}

- (void)testVideoBanner
{
    self.currentAdType = Pubnative_AdType_VideoBanner;
    [self requestAd];
}

- (void)testIcon
{
    self.currentAdType = Pubnative_AdType_Icon;
    [self requestAd];
}

- (void)testInterstitial
{
    self.currentAdType = Pubnative_AdType_Interstitial;
    [self requestAd];
}

- (void)testVideoInterstitial
{
    self.currentAdType = Pubnative_AdType_VideoInterstitial;
    [self requestAd];
}

- (void)requestAd
{
    [Pubnative requestAdType:self.currentAdType
                withAppToken:kPNTestConstantsAppToken
                 andDelegate:self];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

#pragma mark - DELEGATE -
#pragma mark PubnativeAdDelegate

- (void)pnAdDidLoad:(UIViewController*)ad
{
    XCTAssertNotNil(ad, @"ad view controller expected");
    [self.didLoadExpectation fulfill];
    self.currentAdVC = ad;
    [self.rootVC.view addSubview:self.currentAdVC.view];
    
    CGFloat delay = 2.0f;
    if(Pubnative_AdType_VideoBanner == self.currentAdType)
    {
        delay = 5.0f;
    }
    [self performSelector:@selector(removeDelayed) withObject:nil afterDelay:delay];
}

- (void)removeDelayed
{
    [self.currentAdVC.view removeFromSuperview];
}

- (void)pnAdDidFail:(NSError*)error
{
    XCTAssert(NO, @"No fail expected while creating the ad");
}

- (void)pnAdWillShow
{
    [self.willShowExpectation fulfill];
}

- (void)pnAdDidShow
{
    [self.didShowExpectation fulfill];
}

- (void)pnAdWillClose
{
    [self.willCloseExpectation fulfill];
}

- (void)pnAdDidClose
{
    [self.didCloseExpectation fulfill];
}

@end
