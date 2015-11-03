//
//  MyFollowingViewController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "MyFollowingViewController.h"
#import "FollowingTableViewCell.h"
#import "BlogController.h"

@interface MyFollowingViewController ()

@end

@implementation MyFollowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MyFollowing";
    
    [[SLTumblrSDK sharedSLTumblrSDK] userFollowing:@{@"limit" : @20} callback:^(id result, NSError *error) {
        self.result = result[@"blogs"];
        [self.tableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"following"];
    if (cell == nil) {
        cell = [[FollowingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"following"];
    }
    cell.model = self.followModels[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * name = [self.followModels[indexPath.row] name];
    if (name.length > 0) {        
        BlogController * blog = [BlogController blogControllerWithBlogName:name];
        blog.navigationItem.title = name;
        [self.navigationController pushViewController:blog animated:true];
    }
    
}


@end
