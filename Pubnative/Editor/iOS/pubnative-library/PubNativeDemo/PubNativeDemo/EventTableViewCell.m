//
// EventTableViewCell.m
//
// Created by Csongor Nagy on 10/02/15.
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

#import "EventTableViewCell.h"

@implementation EventTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(EFEventModel*)eventModel
{
    self.eventTitle.text = eventModel.title;
    self.eventTitle.numberOfLines = 0;
    [self.eventTitle sizeToFit];
    
    NSString *location = [NSString stringWithFormat:@"%@,%@\n%@", eventModel.city_name, eventModel.country_name, eventModel.venue_address];
    self.eventLocation.text = location;
    
    self.eventDate.text = eventModel.start_time;
    
    self.eventImageView.alpha = 0;
    
    if ((NSNull*)eventModel.image != [NSNull null])
    {
        [PNCacheManager dataWithURLString:eventModel.image.block250.url
                            andCompletion:^(NSData *data) {
                                UIImage *eventImage = [UIImage imageWithData:data];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self.eventImageView setImage:eventImage];
                                    
                                    [UIView animateWithDuration:0.3f
                                                     animations:^{
                                                         self.eventImageView.alpha = 1;
                                                     }];
                                });
                            }];
    }
    else
    {
        UIImage *camera = [UIImage imageNamed:@"camera"];
        [self.eventImageView setImage:camera];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.eventImageView.alpha = 1;
                         }];
    }
}

@end
