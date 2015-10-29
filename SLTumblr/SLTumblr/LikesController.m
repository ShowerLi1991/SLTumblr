//
//  LikesController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/31.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "LikesController.h"
#import "PostsViewController.h"
#import "SLTumblrSDK.h"

@interface LikesController ()

@property (strong, nonatomic) PostsViewController * vc;
@property (strong, nonatomic) NSDictionary * result;

@end

@implementation LikesController

- (void)viewDidLoad {
    [super viewDidLoad];

    PostsViewController * vc = [[PostsViewController alloc] init];
    self.vc = vc;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.vc.result = self.result;
    [self.vc.collectionView reloadData];
}

- (void)loadData {
    [[SLTumblrSDK sharedSLTumblrSDK] userLikes:@{@"limit" : @50, @"type" : @"text"} callback:^(id result, NSError *error) {
        NSLog(@"%@", result);
        self.result = result[@"liked_posts"];
    }];
}

@end
