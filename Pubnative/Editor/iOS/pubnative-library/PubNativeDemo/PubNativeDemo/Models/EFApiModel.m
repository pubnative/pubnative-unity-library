//
// EFApiModel.m
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

#import "EFApiModel.h"

@implementation EFApiModel

@synthesize last_item;
@synthesize total_items;
@synthesize first_item;
@synthesize page_number;
@synthesize page_size;
@synthesize page_items;
@synthesize search_time;
@synthesize page_count;
@synthesize events;

#pragma mark NSObject

- (void)dealloc
{
    self.last_item = nil;
    self.total_items = nil;
    self.first_item = nil;
    self.page_number = nil;
    self.page_size = nil;
    self.page_items = nil;
    self.search_time = nil;
    self.page_count = nil;
    self.events = nil;
}

@end
