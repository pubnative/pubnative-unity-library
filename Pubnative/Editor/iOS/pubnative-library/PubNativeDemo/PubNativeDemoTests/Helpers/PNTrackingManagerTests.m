//
// PNImpressionManagerTests.m
//
// Created by Csongor Nagy on 23/09/14.
// Copyright (c) 2014 PubNative
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

#import "PNTrackingManager.h"
#import "PNNativeAdModel.h"
#import "PNAdConstants.h"
#import "PNTestConstants.h"

NSString * const kPNTrackingManagerTestMockURL    = @"FancyURL";
NSString * const kPNTrackingManagerTestGoogleURL  = @"http://www.google.com";

@interface PNTrackingManagerTests : XCTestCase

@property (nonatomic, strong) PNNativeAdModel     *model;

@end

@implementation PNTrackingManagerTests

- (void)setUp
{
    [super setUp];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kPNAdConstantTrackingConfirmedAdsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.model = [[PNNativeAdModel alloc] init];
}

- (void)tearDown
{
    self.model = nil;
    
    [super tearDown];
}

- (void)testNilBeaconError
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
    [PNTrackingManager trackImpressionWithAd:self.model
                            completion:^(id result, NSError *error)
    {
        XCTAssertNil(result);
        XCTAssertNotNil(error, @"Expected error with empty beacon");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testEmptyBeaconError
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
    self.model.beacons = (NSArray<PNBeaconModel>*) [NSArray array];
    [PNTrackingManager trackImpressionWithAd:self.model
                                  completion:^(id result, NSError *error)
     {
         XCTAssertNil(result);
         XCTAssertNotNil(error, @"Expected error with empty beacon");
         [expectation fulfill];
     }];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testNotNilConfirmedAds
{
    NSArray *confirmedAds = [PNTrackingManager confirmedAds];
    XCTAssertNotNil(confirmedAds);
}

- (void)testSetConfirmedAdsWorks
{
    NSMutableArray *confirmedAds = [NSMutableArray arrayWithObjects:@1, @10, @100, nil];
    [PNTrackingManager setConfirmedAds:confirmedAds];
    NSMutableArray *retrievedConfirmedAds = [PNTrackingManager confirmedAds];
    
    XCTAssertEqualObjects(confirmedAds, retrievedConfirmedAds, @"Expected same object getting out");
}

- (void)testURLWorkingStoreBeacon
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
    
    // This should NOT save the ad as we are using a fancyURL
    PNBeaconModel *impressionBeacon = [[PNBeaconModel alloc] init];
    impressionBeacon.type = kPNAdConstantTrackingBeaconImpressionTypeString;
    impressionBeacon.url = kPNTrackingManagerTestGoogleURL;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:impressionBeacon];
    
    self.model.beacons = (NSArray<PNBeaconModel>*) array;
    
    __block NSArray *confirmedAds = [[NSUserDefaults standardUserDefaults] objectForKey:kPNAdConstantTrackingConfirmedAdsKey];
    [PNTrackingManager trackImpressionWithAd:self.model
                          completion:^(id result, NSError *error)
     {
         XCTAssertNotEqualObjects(confirmedAds,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:kPNAdConstantTrackingConfirmedAdsKey],
                                  @"Expected ad to be saved with good URL");
         [expectation fulfill];
     }];
    
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testURLErrorDontStoreBeacon
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
    
    // This should NOT save the ad as we are using a fancyURL
    PNBeaconModel *impressionBeacon = [[PNBeaconModel alloc] init];
    impressionBeacon.type = kPNAdConstantTrackingBeaconImpressionTypeString;
    impressionBeacon.url = kPNTrackingManagerTestMockURL;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:impressionBeacon];
    
    self.model.beacons = (NSArray<PNBeaconModel>*) array;
    self.model.app_details = [[PNAppModel alloc] init];
    self.model.app_details.url_scheme = @"testURLScheme";
    
    __block NSArray *confirmedAds = [[NSUserDefaults standardUserDefaults] objectForKey:kPNAdConstantTrackingConfirmedAdsKey];
    
    [PNTrackingManager trackImpressionWithAd:self.model
                            completion:^(id result, NSError *error)
    {
        XCTAssertEqualObjects(confirmedAds,
                              [[NSUserDefaults standardUserDefaults] objectForKey:kPNAdConstantTrackingConfirmedAdsKey],
                              @"Expected ad not to be saved with mock URL");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testTrackURLStrings
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
    [PNTrackingManager trackURLString:kPNTrackingManagerTestGoogleURL completion:^(id result, NSError *error)
    {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

@end
