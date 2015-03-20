//
// AdViewController.m
//
// Created by David Martin on 05/02/15.
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

#import "AdViewController.h"

@interface AdViewController ()

@property (weak, nonatomic) IBOutlet UIView *adContainer;

@property (strong, nonatomic) UIViewController *currentAdVC;

@end

@implementation AdViewController

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(self.currentAdVC)
    {
        [self.currentAdVC.view removeFromSuperview];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark AdViewController

- (void)presentAdWithViewController:(UIViewController*)adViewController
                               type:(Pubnative_AdType)type
{
    self.currentAdVC = adViewController;
    
    switch (type)
    {
        case Pubnative_AdType_Banner:
        {
            self.currentAdVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.adContainer.frame), 100);
            self.currentAdVC.view.center = [self.adContainer convertPoint:self.adContainer.center
                                                                 fromView:self.view];
            self.currentAdVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                                     UIViewAutoresizingFlexibleHeight |
                                                     UIViewAutoresizingFlexibleTopMargin |
                                                     UIViewAutoresizingFlexibleBottomMargin;
            
            self.currentAdVC.view.alpha = 0;
            
            [self.adContainer addSubview:self.currentAdVC.view];
            
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 self.currentAdVC.view.alpha = 1;
                             }];
        }
        break;
            
        case Pubnative_AdType_VideoBanner:
        {
            self.currentAdVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.adContainer.frame), 150);
            self.currentAdVC.view.center = [self.adContainer convertPoint:self.adContainer.center
                                                                 fromView:self.view];
            self.currentAdVC.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                                     UIViewAutoresizingFlexibleRightMargin |
                                                     UIViewAutoresizingFlexibleTopMargin |
                                                     UIViewAutoresizingFlexibleBottomMargin;
            self.currentAdVC.view.alpha = 0;

            [self.adContainer addSubview:self.currentAdVC.view];
            
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 self.currentAdVC.view.alpha = 1;
                             }];
        }
        break;
            
        case Pubnative_AdType_Icon:
        {
            self.currentAdVC.view.frame = CGRectMake(0, 0, 100, 100);
            self.currentAdVC.view.center = [self.adContainer convertPoint:self.adContainer.center
                                                                 fromView:self.view];
            
            self.currentAdVC.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                                     UIViewAutoresizingFlexibleRightMargin |
                                                     UIViewAutoresizingFlexibleTopMargin |
                                                     UIViewAutoresizingFlexibleBottomMargin;
            
            self.currentAdVC.view.alpha = 0;

            [self.adContainer addSubview:self.currentAdVC.view];
            
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 self.currentAdVC.view.alpha = 1;
                             }];
        }
        break;
            
        default: break;
    }
}

- (IBAction)doneButtonPushed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
