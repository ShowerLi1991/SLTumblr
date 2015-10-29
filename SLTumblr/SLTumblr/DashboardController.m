//
//  DashboardController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/22.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashboardController.h"
#import "PostsViewController.h"
#import "SLTumblrSDK.h"



@interface DashboardController ()

@property (strong, nonatomic) PostsViewController * vc;
@property (strong, nonatomic) NSDictionary * result;

@end

@implementation DashboardController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    PostsViewController * vc = [[PostsViewController alloc] init];
    self.vc = vc;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [[SLTumblrSDK sharedSLTumblrSDK] userDashboard:@{@"limit" : @50, @"offset" : @0} callback:^(id result, NSError *error) {
        NSLog(@"%@", result);
        self.vc.result = result[@"posts"];
        NSLog(@"counttttt = %li", self.vc.result.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
        });
    }];
    


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.vc.result = self.result;
    [self.vc.collectionView reloadData];
}

- (void)loadData {
    [[SLTumblrSDK sharedSLTumblrSDK] userDashboard:@{@"limit" : @50, @"offset" : @0, @"type" : @"text"} callback:^(id result, NSError *error) {
        NSLog(@"%@", result);
        self.result = result[@"posts"];
        NSLog(@"counttttt = %li", self.vc.result.count);
    }];
}




@end
