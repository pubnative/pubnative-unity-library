//
// EFEventModel.h
//
// Created by Csongor Nagy on 06/02/15.
// Copyright (c) 2015 PubNative
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

#import "YADMJSONApiModel.h"
#import "EFPerformersModel.h"
#import "EFImageModel.h"

@protocol EFEventModel

@property (strong, nonatomic) NSString                  *watching_count;
@property (strong, nonatomic) NSString                  *olson_path;
@property (strong, nonatomic) NSString                  *calendar_count;
@property (strong, nonatomic) NSString                  *comment_count;
@property (strong, nonatomic) NSString                  *region_abbr;
@property (strong, nonatomic) NSString                  *postal_code;
@property (strong, nonatomic) NSString                  *going_count;
@property (strong, nonatomic) NSString                  *all_day;
@property (strong, nonatomic) NSString                  *latitude;
@property (strong, nonatomic) NSString                  *groups;
@property (strong, nonatomic) NSString                  *url;
@property (strong, nonatomic) NSString                  *Id;
@property (strong, nonatomic) NSString                  *privacy;
@property (strong, nonatomic) NSString                  *city_name;
@property (strong, nonatomic) NSString                  *link_count;
@property (strong, nonatomic) NSString                  *longitude;
@property (strong, nonatomic) NSString                  *country_name;
@property (strong, nonatomic) NSString                  *country_abbr;
@property (strong, nonatomic) NSString                  *region_name;
@property (strong, nonatomic) NSString                  *start_time;
@property (strong, nonatomic) NSString                  *tz_id;
@property (strong, nonatomic) NSString                  *Description;
@property (strong, nonatomic) NSString                  *modified;
@property (strong, nonatomic) NSString                  *venue_display;
@property (strong, nonatomic) NSString                  *tz_country;
@property (strong, nonatomic) EFPerformersModel         *performers;
@property (strong, nonatomic) NSString                  *title;
@property (strong, nonatomic) NSString                  *venue_address;
@property (strong, nonatomic) NSString                  *geocode_type;
@property (strong, nonatomic) NSString                  *tz_olson_path;
@property (strong, nonatomic) NSString                  *recur_string;
@property (strong, nonatomic) NSString                  *calendars;
@property (strong, nonatomic) NSString                  *owner;
@property (strong, nonatomic) NSString                  *going;
@property (strong, nonatomic) NSString                  *country_abbr2;
@property (strong, nonatomic) EFImageModel              *image;
@property (strong, nonatomic) NSString                  *created;
@property (strong, nonatomic) NSString                  *venue_id;
@property (strong, nonatomic) NSString                  *tz_city;
@property (strong, nonatomic) NSString                  *stop_time;
@property (strong, nonatomic) NSString                  *venue_name;
@property (strong, nonatomic) NSString                  *venue_url;

@end

@interface EFEventModel : YADMJSONApiModel <EFEventModel>

@end
