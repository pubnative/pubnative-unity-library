//
//  PNTableViewManager.m
//  PubNativeDemo
//
//  Created by David Martin on 12/01/15.
//  Copyright (c) 2015 PubNative. All rights reserved.
//

#import "PNTableViewManager.h"
#import "PNVideoTableViewCell.h"
#import "PNBannerTableViewCell.h"
#import "PNIconTableViewCell.h"

NSString * const kPNTableViewManagerClearAllNotification = @"PNTableViewManagerClearAll";

@interface PNTableViewManager ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView                     *tableView;
@property (weak, nonatomic) NSObject<UITableViewDelegate>   *originalDelegate;
@property (weak, nonatomic) NSObject<UITableViewDataSource> *originalDataSource;

@end

@implementation PNTableViewManager

+ (instancetype)sharedManager
{
    static PNTableViewManager *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[PNTableViewManager alloc] init];
    });
    return _sharedManager;
}

+ (void)controlTable:(UITableView*)tableView
{
    if([PNTableViewManager sharedManager].tableView)
    {
        [PNTableViewManager sharedManager].tableView.delegate = [PNTableViewManager sharedManager].originalDelegate;
        [PNTableViewManager sharedManager].tableView.dataSource = [PNTableViewManager sharedManager].originalDataSource;
        [PNTableViewManager sharedManager].originalDelegate = nil;
        [PNTableViewManager sharedManager].originalDataSource = nil;
    }
    
    if(tableView)
    {
        [PNTableViewManager sharedManager].tableView = tableView;
        [PNTableViewManager sharedManager].originalDelegate = tableView.delegate;
        [PNTableViewManager sharedManager].originalDataSource = tableView.dataSource;
        tableView.delegate = [PNTableViewManager sharedManager];
        tableView.dataSource = [PNTableViewManager sharedManager];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPNTableViewManagerClearAllNotification object:nil];
    }
}

#pragma mark - Method Forwarding

- (BOOL)isKindOfClass:(Class)aClass
{
    return [super isKindOfClass:aClass] ||
    [self.originalDataSource isKindOfClass:aClass] ||
    [self.originalDelegate isKindOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [super conformsToProtocol:aProtocol] ||
    [self.originalDelegate conformsToProtocol:aProtocol] ||
    [self.originalDataSource conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] ||
    [self.originalDataSource respondsToSelector:aSelector] ||
    [self.originalDelegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.originalDataSource respondsToSelector:aSelector])
    {
        return self.originalDataSource;
    }
    else if ([self.originalDelegate respondsToSelector:aSelector])
    {
        return self.originalDelegate;
    }
    else
    {
        return [super forwardingTargetForSelector:aSelector];
    }
}

#pragma mark - DELEGATES -

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.originalDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.originalDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[PNVideoTableViewCell class]])
    {
        PNVideoTableViewCell *videoCell = (PNVideoTableViewCell*)cell;
        [videoCell willDisplayCell];
    }
    
    if([cell isKindOfClass:[PNBannerTableViewCell class]])
    {
        PNBannerTableViewCell *bannerCell = (PNBannerTableViewCell*)cell;
        [bannerCell willDisplayCell];
    }
    
    if([cell isKindOfClass:[PNIconTableViewCell class]])
    {
        PNIconTableViewCell *iconCell = (PNIconTableViewCell*)cell;
        [iconCell willDisplayCell];
    }
    
    if(self.originalDelegate != nil &&
       [self.originalDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
    {
        [self.originalDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[PNVideoTableViewCell class]])
    {
        PNVideoTableViewCell *videoCell = (PNVideoTableViewCell*)cell;
        [videoCell didEndDisplayingCell];
    }
    
    if([cell isKindOfClass:[PNBannerTableViewCell class]])
    {
        PNBannerTableViewCell *bannerCell = (PNBannerTableViewCell*)cell;
        [bannerCell didEndDisplayingCell];
    }
    
    if([cell isKindOfClass:[PNIconTableViewCell class]])
    {
        PNIconTableViewCell *iconCell = (PNIconTableViewCell*)cell;
        [iconCell didEndDisplayingCell];
    }
    
    if(self.originalDelegate != nil &&
       [self.originalDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)])
    {
        [self.originalDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}



@end
