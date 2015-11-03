//
//  MyPostsViewController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "MyPostsViewController.h"
#import "SLTumblrSDK.h"
#import "BaseCell.h"
#import "InfoView.h"


@interface MyPostsViewController ()

@end

@implementation MyPostsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"MyPosts";
    
    [self loadDataAndReload:true completionHandler:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell * cell = (BaseCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.infoView.followButton.hidden = true;
    return cell;
}


- (void)startRefreshingNew:(UIRefreshControl *)refresh {
    [self loadDataAndReload:true completionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [refresh endRefreshing];
        });
    }];
}

- (void)startRefreshingOld:(UIRefreshControl *)refresh {
    [self addDataAndReload:true completionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [refresh endRefreshing];
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startReload:true];
}


- (void)loadDataAndReload:(BOOL)reload completionHandler:(void(^)())handler {
    [[SLTumblrSDK sharedSLTumblrSDK] userPosts:@{ @"limit" : @20, @"offset" : @0 } type:nil callback:^(id result, NSError *error) {
        
        [self.result removeAllObjects];
        [self.result addObjectsFromArray:result[@"posts"]];
        
        if (result[@"blog"]!= nil) {
            [self startReload:reload];
        }
        if (handler != nil) {
            handler();
        }
    }];
}

- (void)addDataAndReload:(BOOL)reload completionHandler:(void(^)())handler {
    
    [[SLTumblrSDK sharedSLTumblrSDK] userPosts:@{ @"limit" : @20, @"offset" : @(self.result.count) } type:nil callback:^(id result, NSError *error) {
        
        [self.result addObjectsFromArray:result[@"posts"]];
        if (result[@"blog"]!= nil) {
            [self startReload:reload];
        }
        if (handler != nil) {
            handler();
        }
    }];
}

- (void)startReload:(BOOL)reload {
    if (reload) {
        self.postsModels = nil;
        [self.collectionView reloadData];
    }
}


@end
