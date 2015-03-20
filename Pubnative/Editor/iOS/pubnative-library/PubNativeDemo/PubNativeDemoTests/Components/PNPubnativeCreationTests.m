//
// PNPubnativeCreationTests.m
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

@interface PNPubnativeCreationTests : XCTestCase <PubnativeAdDelegate>

@property (strong, nonatomic)XCTestExpectation *expectation;

@end

@implementation PNPubnativeCreationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBanner
{
    self.expectation = [self expectationWithDescription:@"expectation"];
    [Pubnative requestAdType:Pubnative_AdType_Banner
                withAppToken:kPNTestConstantsAppToken
                 andDelegate:self];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testVideoBanner
{
    self.expectation = [self expectationWithDescription:@"expectation"];
    [Pubnative requestAdType:Pubnative_AdType_VideoBanner
                withAppToken:kPNTestConstantsAppToken
                 andDelegate:self];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testIcon
{
    self.expectation = [self expectationWithDescription:@"expectation"];
    [Pubnative requestAdType:Pubnative_AdType_Icon
                withAppToken:kPNTestConstantsAppToken
                 andDelegate:self];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testInterstitial
{
    self.expectation = [self expectationWithDescription:@"expectation"];
    [Pubnative requestAdType:Pubnative_AdType_Interstitial
                withAppToken:kPNTestConstantsAppToken
                 andDelegate:self];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testVideoInterstitial
{
    self.expectation = [self expectationWithDescription:@"expectation"];
    [Pubnative requestAdType:Pubnative_AdType_VideoInterstitial
                withAppToken:kPNTestConstantsAppToken
                 andDelegate:self];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

#pragma mark - DELEGATE -
#pragma mark PubnativeAdDelegate

- (void)pnAdDidLoad:(UIViewController*)ad
{
    XCTAssertNotNil(ad, @"ad view controller expected");
    [self.expectation fulfill];
}

- (void)pnAdDidFail:(NSError*)error
{
    XCTAssert(NO, @"No fail expected while creating the ad");
}

@end
