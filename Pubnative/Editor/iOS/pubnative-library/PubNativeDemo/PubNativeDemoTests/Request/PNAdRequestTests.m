//
// PNAdRequestTests.m
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
#import "PNAdRequest.h"
#import "PNTestConstants.h"

@interface PNAdRequestTests : XCTestCase

@property (nonatomic, strong) PNAdRequestCompletionBlock  block;
@property (nonatomic, strong) PNAdRequestParameters *parameters;
@property (nonatomic, strong) PNAdRequest *request;

@end

@implementation PNAdRequestTests

- (void)setUp
{
    [super setUp];
    self.parameters = [PNAdRequestParameters requestParameters];
    self.parameters.app_token = kPNTestConstantsAppToken;
}

- (void)tearDown
{
    self.block = nil;
    self.request = nil;
    self.parameters = nil;
    [super tearDown];
}

- (void)testNativeRequestCreation
{
    PNAdRequest *nativeNotNil = [PNAdRequest request:PNAdRequest_Native
                                      withParameters:self.parameters
                                       andCompletion:nil];
    
    XCTAssertNotNil(nativeNotNil, @"Expected Native request to be allocated");

    PNAdRequest *nativeNil = [PNAdRequest request:PNAdRequest_Native
                                   withParameters:nil
                                    andCompletion:nil];
    
    XCTAssertNil(nativeNil, @"Expected Native nil request");
}

- (void)testImageRequestCreation
{
    PNAdRequest *imageNotNil = [PNAdRequest request:PNAdRequest_Image
                                     withParameters:self.parameters
                                      andCompletion:nil];
    
    XCTAssertNotNil(imageNotNil, @"Expected request to be allocated");
    
    PNAdRequest *imageNil = [PNAdRequest request:PNAdRequest_Image
                                  withParameters:nil
                                   andCompletion:nil];
    
    XCTAssertNil(imageNil, @"Expected nil request");
}

- (void)testVideoRequestCreation
{
    PNAdRequest *videoNotNil = [PNAdRequest request:PNAdRequest_Native_Video
                                     withParameters:self.parameters
                                      andCompletion:nil];
    
    XCTAssertNotNil(videoNotNil, @"Expected request to be allocated");
    
    PNAdRequest *videoNil = [PNAdRequest request:PNAdRequest_Native_Video
                                  withParameters:nil
                                   andCompletion:nil];
    
    XCTAssertNil(videoNil, @"Expected nil request");
}

- (void)testDefaultRequestNative
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
    
    self.request = [PNAdRequest request:PNAdRequest_Native
                         withParameters:self.parameters
                          andCompletion:^(NSArray *ads, NSError *error)
    {
        [expectation fulfill];
    }];
    [self.request startRequest];
    
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testDefaultRequestImage
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];

    self.request = [PNAdRequest request:PNAdRequest_Image
                         withParameters:self.parameters
                          andCompletion:^(NSArray *ads, NSError *error)
                    {
                        [expectation fulfill];
                    }];
    [self.request startRequest];
    
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)testDefaultRequestNativeVideo
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"expectation"];
    
    self.request = [PNAdRequest request:PNAdRequest_Native_Video
                         withParameters:self.parameters
                          andCompletion:^(NSArray *ads, NSError *error)
                    {
                        [expectation fulfill];
                    }];
    [self.request startRequest];
    
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

@end
