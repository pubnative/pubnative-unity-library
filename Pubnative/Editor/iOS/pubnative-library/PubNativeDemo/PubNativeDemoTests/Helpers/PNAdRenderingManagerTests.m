//
// PNAdRenderingManagerTests.m
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
#import "PNNativeAdModel.h"
#import "PNNativeAdRenderItem.h"
#import "PNAdRenderingManager.h"
#import "PNTestConstants.h"

@interface PNAdRenderingManagerTests : XCTestCase

@property (strong, nonatomic) XCTestExpectation     *iconExpectation;
@property (strong, nonatomic) XCTestExpectation     *bannerExpectation;
@property (strong, nonatomic) XCTestExpectation     *portraitBannerExpectation;

@property (strong, nonatomic) PNNativeAdRenderItem  *renderItem;
@property (strong, nonatomic) PNNativeAdModel       *nativeModel;

@property (strong, nonatomic) UILabel               *title;
@property (strong, nonatomic) UITextView            *descriptionField;
@property (strong, nonatomic) UIImageView           *icon;
@property (strong, nonatomic) UIImageView           *banner;
@property (strong, nonatomic) UIImageView           *portraitBanner;
@property (strong, nonatomic) UILabel               *cta_text;
@property (strong, nonatomic) UILabel               *app_name;
@property (strong, nonatomic) UITextView            *app_review;
@property (strong, nonatomic) UILabel               *app_publisher;
@property (strong, nonatomic) UILabel               *app_developer;
@property (strong, nonatomic) UILabel               *app_version;
@property (strong, nonatomic) UILabel               *app_size;
@property (strong, nonatomic) UILabel               *app_category;
@property (strong, nonatomic) UILabel               *app_sub_category;

@end

@implementation PNAdRenderingManagerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    self.iconExpectation = nil;
    self.bannerExpectation = nil;
    
    self.renderItem = nil;
    self.nativeModel = nil;
    
    self.title = nil;
    self.descriptionField = nil;
    self.icon = nil;
    self.banner = nil;
    self.portraitBanner = nil;
    self.cta_text = nil;
    
    self.app_name = nil;
    self.app_review = nil;
    self.app_publisher = nil;
    self.app_developer = nil;
    self.app_version = nil;
    self.app_size = nil;
    self.app_category = nil;
    self.app_sub_category = nil;
    
    self.nativeModel = nil;
    
    [super tearDown];
}

- (void)testItemAssignedModelAssigned
{
    [self checkAssignedItem:[self assignedRenderItem]
                  withModel:[self assignedModel]];
}

- (void)testItemAssignedModelNil
{
    [self checkNotAssignedItem:[self assignedRenderItem]
                     withModel:[self modelWithValue:nil]];
}

- (void)testItemAssignedModelNSNull
{
    [self checkNotAssignedItem:[self assignedRenderItem]
                     withModel:[self modelWithValue:[NSNull null]]];
}

- (void)testItemNildModelAssigned
{
    [self checkNotAssignedItem:[PNNativeAdRenderItem renderItem]
                     withModel:[self assignedModel]];
}

#pragma mark common check

- (void)checkAssignedItem:(PNNativeAdRenderItem*)item withModel:(PNNativeAdModel*)model
{
    self.renderItem = item;
    self.nativeModel = model;
    
    self.iconExpectation = [self expectationWithDescription:kPNAdRenderingManagerIconNotification];
    self.bannerExpectation = [self expectationWithDescription:kPNAdRenderingManagerBannerNotification];
    self.portraitBannerExpectation = [self expectationWithDescription:kPNAdRenderingManagerPortraitBannerNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkModelAssignedToItemNotification:)
                                                 name:kPNAdRenderingManagerIconNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkModelAssignedToItemNotification:)
                                                 name:kPNAdRenderingManagerBannerNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkModelAssignedToItemNotification:)
                                                 name:kPNAdRenderingManagerPortraitBannerNotification
                                               object:nil];
    
    [PNAdRenderingManager renderNativeAdItem:self.renderItem withAd:self.nativeModel];
    
    XCTAssert([self.renderItem.title.text isEqualToString:self.nativeModel.title], @"expected equal items");
    XCTAssert([self.renderItem.descriptionField.text isEqualToString:self.nativeModel.Description], @"expected equal items");
    XCTAssert([self.renderItem.cta_text.text isEqualToString:self.nativeModel.cta_text], @"expected equal items");
    
    XCTAssert([self.renderItem.app_name.text isEqualToString:self.nativeModel.app_details.name], @"expected equal items");
    XCTAssert([self.renderItem.app_review.text isEqualToString:self.nativeModel.app_details.review], @"expected equal items");
    XCTAssert([self.renderItem.app_publisher.text isEqualToString:self.nativeModel.app_details.publisher], @"expected equal items");
    XCTAssert([self.renderItem.app_developer.text isEqualToString:self.nativeModel.app_details.developer], @"expected equal items");
    XCTAssert([self.renderItem.app_version.text isEqualToString:self.nativeModel.app_details.version], @"expected equal items");
    XCTAssert([self.renderItem.app_size.text isEqualToString:self.nativeModel.app_details.size], @"expected equal items");
    XCTAssert([self.renderItem.app_category.text isEqualToString:self.nativeModel.app_details.category], @"expected equal items");
    XCTAssert([self.renderItem.app_sub_category.text isEqualToString:self.nativeModel.app_details.sub_category], @"expected equal items");
    
    [self waitForExpectationsWithTimeout:kPNTestConstantsTimeout handler:nil];
}

- (void)checkModelAssignedToItemNotification:(NSNotification*)notification
{
    if([kPNAdRenderingManagerIconNotification isEqualToString:notification.name])
    {
        XCTAssertNotNil(self.renderItem.icon.image, @"Expected some image setted up");
        [self.iconExpectation fulfill];
    }
    else if([kPNAdRenderingManagerBannerNotification isEqualToString:notification.name])
    {
        XCTAssertNotNil(self.renderItem.banner.image, @"Expected some image setted up");
        [self.bannerExpectation fulfill];
    }
    else if([kPNAdRenderingManagerPortraitBannerNotification isEqualToString:notification.name])
    {
        XCTAssertNotNil(self.renderItem.portrait_banner.image, @"Expected some image setted up");
        [self.portraitBannerExpectation fulfill];
    }
}

- (void)checkNotAssignedItem:(PNNativeAdRenderItem*)item withModel:(PNNativeAdModel*)model
{
    self.renderItem = item;
    self.nativeModel = model;
    
    [PNAdRenderingManager renderNativeAdItem:self.renderItem withAd:self.nativeModel];
    
    XCTAssertNil(self.renderItem.title.text, @"not expected assignation");
    
    if(self.renderItem.descriptionField)
    {
        XCTAssert([self.renderItem.descriptionField.text isEqualToString:@""], @"not expected assignation");
    }
    else
    {
        XCTAssertNil(self.renderItem.descriptionField.text, @"not expected assignation");
    }
    
    XCTAssertNil(self.renderItem.icon.image, @"not expected assignation");
    XCTAssertNil(self.renderItem.banner.image, @"not expected assignation");
    XCTAssertNil(self.renderItem.portrait_banner.image, @"not expected assignation");
    XCTAssertNil(self.renderItem.cta_text.text, @"not expected assignation");
    XCTAssertNil(self.renderItem.app_name.text, @"not expected assignation");
    
    if(self.renderItem.app_review)
    {
        XCTAssert([self.renderItem.app_review.text isEqualToString:@""], @"not expected assignation");
    }
    else
    {
        XCTAssertNil(self.renderItem.app_review.text, @"not expected assignation");
    }

    XCTAssertNil(self.renderItem.app_publisher.text, @"not expected assignation");
    XCTAssertNil(self.renderItem.app_developer.text, @"not expected assignation");
    XCTAssertNil(self.renderItem.app_version.text, @"not expected assignation");
    XCTAssertNil(self.renderItem.app_size.text, @"not expected assignation");
    XCTAssertNil(self.renderItem.app_category.text, @"not expected assignation");
    XCTAssertNil(self.renderItem.app_sub_category.text, @"not expected assignation");
}

#pragma mark - ITEMS -

- (PNNativeAdRenderItem*)assignedRenderItem
{
    PNNativeAdRenderItem *renderItem = [PNNativeAdRenderItem renderItem];
    renderItem.title = [[UILabel alloc] init];
    renderItem.descriptionField = [[UITextView alloc] init];
    renderItem.icon = [[UIImageView alloc] init];
    renderItem.banner = [[UIImageView alloc] init];
    renderItem.portrait_banner = [[UIImageView alloc] init];
    renderItem.cta_text = [[UILabel alloc] init];
    renderItem.app_name = [[UILabel alloc] init];
    renderItem.app_review = [[UITextView alloc] init];
    renderItem.app_publisher = [[UILabel alloc] init];
    renderItem.app_developer = [[UILabel alloc] init];
    renderItem.app_version = [[UILabel alloc] init];
    renderItem.app_size = [[UILabel alloc] init];
    renderItem.app_category = [[UILabel alloc] init];
    renderItem.app_sub_category = [[UILabel alloc] init];
    return renderItem;
}

- (PNNativeAdRenderItem*)nilRenderItem
{
    PNNativeAdRenderItem *renderItem = [PNNativeAdRenderItem renderItem];
    return renderItem;
}

- (PNNativeAdModel*)assignedModel
{
    PNNativeAdModel *model = [[PNNativeAdModel alloc] init];
    model.title = @"title";
    model.Description = @"Description";
    model.icon_url = @"http://pubnative.net/wp-content/uploads/2014/09/header21.png";
    model.banner_url = @"http://pubnative.net/wp-content/uploads/2014/09/header21.png";
    model.portrait_banner_url = @"http://pubnative.net/wp-content/uploads/2014/09/header21.png";
    model.cta_text = @"cta_text";
    
    PNAppModel *app_details = [[PNAppModel alloc] init];
    app_details.name = @"name";
    app_details.review = @"review";
    app_details.publisher = @"publisher";
    app_details.developer = @"developer";
    app_details.version = @"version";
    app_details.size = @"size";
    app_details.category = @"category";
    app_details.sub_category = @"sub_category";
    model.app_details = app_details;

    return model;
}

- (PNNativeAdModel*)modelWithValue:(id)value
{
    PNNativeAdModel *model = [[PNNativeAdModel alloc] init];
    model.title = value;
    model.Description = value;
    model.icon_url = value;
    model.banner_url  = value;
    model.portrait_banner_url = value;
    model.cta_text = value;
    
    PNAppModel *app_details = [[PNAppModel alloc] init];
    app_details.name = value;
    app_details.review = value;
    app_details.publisher = value;
    app_details.developer = value;
    app_details.version = value;
    app_details.size = value;
    app_details.category = value;
    app_details.sub_category = value;
    model.app_details = app_details;
    
    return model;
}

@end
