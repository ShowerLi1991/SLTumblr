//
//  LikesController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/31.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "LikesController.h"
#import "SLTumblrSDK.h"
#import "BaseCell.h"

@interface LikesController ()

@end

@implementation LikesController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.result.count > 0) {
    } else {
        [self loadDataAndReload:true completionHandler:nil];
    }

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likesControllerRefresh) name:@"likesControllerRefresh" object:nil];
    
}

- (void)likesControllerRefresh {
    [self loadDataAndReload:true completionHandler:nil];
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
    [[SLTumblrSDK sharedSLTumblrSDK] userLikes:@{ @"limit" : @40, @"offset" : @0 } callback:^(id result, NSError *error) {

        [self.result removeAllObjects];
        self.postsModels = nil;
        
        [self.result addObjectsFromArray:result[@"liked_posts"]];

        if ([result[@"liked_posts"] count] > 0) {
            [self startReload:reload];
        }
        if (handler != nil) {
            handler();
        }
    }];
}

- (void)addDataAndReload:(BOOL)reload completionHandler:(void(^)())handler {
    [[SLTumblrSDK sharedSLTumblrSDK] userLikes:@{ @"limit" : @40, @"offset" : @(self.result.count)} callback:^(id result, NSError *error) {
        
        [self.result addObjectsFromArray:result[@"liked_posts"]];
        if ([result[@"liked_posts"] count] > 0) {
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
