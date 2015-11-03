//
//  MyFollowersViewController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "MyFollowersViewController.h"
#import "FollowersTableViewCell.h"

@interface MyFollowersViewController ()

@end

@implementation MyFollowersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MyFollowers";
    
    [[SLTumblrSDK sharedSLTumblrSDK] userFollowers:@{@"limit" : @20} callback:^(id result, NSError *error) {
        NSLog(@"%@", result);
        self.result = result[@"users"];
        [self.tableView reloadData];
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"followers"];
    if (cell == nil) {
        cell = [[FollowersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"followers"];
    }
    cell.model = self.followModels[indexPath.row];
    return cell;
}

@end
