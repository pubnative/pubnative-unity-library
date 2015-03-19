//
// EFEventModel.m
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

#import "EFEventModel.h"

@implementation EFEventModel

@synthesize watching_count;
@synthesize olson_path;
@synthesize calendar_count;
@synthesize comment_count;
@synthesize region_abbr;
@synthesize postal_code;
@synthesize going_count;
@synthesize all_day;
@synthesize latitude;
@synthesize groups;
@synthesize url;
@synthesize Id;
@synthesize privacy;
@synthesize city_name;
@synthesize link_count;
@synthesize longitude;
@synthesize country_name;
@synthesize country_abbr;
@synthesize region_name;
@synthesize start_time;
@synthesize tz_id;
@synthesize Description;
@synthesize modified;
@synthesize venue_display;
@synthesize tz_country;
@synthesize performers;
@synthesize title;
@synthesize venue_address;
@synthesize geocode_type;
@synthesize tz_olson_path;
@synthesize recur_string;
@synthesize calendars;
@synthesize owner;
@synthesize going;
@synthesize country_abbr2;
@synthesize image;
@synthesize created;
@synthesize venue_id;
@synthesize tz_city;
@synthesize stop_time;
@synthesize venue_name;
@synthesize venue_url;

- (void)dealloc
{
    self.watching_count = nil;
    self.olson_path = nil;
    self.calendar_count = nil;
    self.comment_count = nil;
    self.region_abbr = nil;
    self.postal_code = nil;
    self.going_count = nil;
    self.all_day = nil;
    self.latitude = nil;
    self.groups = nil;
    self.url = nil;
    self.Id = nil;
    self.privacy = nil;
    self.city_name = nil;
    self.link_count = nil;
    self.longitude = nil;
    self.country_name = nil;
    self.country_abbr = nil;
    self.region_name = nil;
    self.start_time = nil;
    self.tz_id = nil;
    self.Description = nil;
    self.modified = nil;
    self.venue_display = nil;
    self.tz_country = nil;
    self.performers = nil;
    self.title = nil;
    self.venue_address = nil;
    self.geocode_type = nil;
    self.tz_olson_path = nil;
    self.recur_string = nil;
    self.calendars = nil;
    self.owner = nil;
    self.going = nil;
    self.country_abbr2 = nil;
    self.image = nil;
    self.created = nil;
    self.venue_id = nil;
    self.tz_city = nil;
    self.stop_time = nil;
    self.venue_name = nil;
    self.venue_url = nil;
}

@end
