//
//  ProfileController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/31.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "ProfileController.h"
#import "ProfileTableView.h"
#import "SLTumblrSDK.h"
#import "MyPostsViewController.h"
#import "MyFollowingViewController.h"
#import "MyFollowersViewController.h"

@interface ProfileController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray * array;

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UITableView * profileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:profileTable];
    
    profileTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    profileTable.delegate = self;
    profileTable.dataSource = self;

    profileTable.backgroundColor = [UIColor colorWithRed:74/255.0 green:192/255.0 blue:226/255.0 alpha:1];
    
    _array = @[
               @[
                   @{@"title" : @"Posts", },
                   @{@"title" : @"Following"},
                   @{@"title" : @"Followers"},
                   @{@"title" : @"Drafts"},
                   @{@"title" : @"Queue"},
                   @{@"title" : @"福利"}
                ],

               @[
                   @{@"title" : @"Logout"}
                ]
            ];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"profileCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView * view = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = view;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    }
    
    
    cell.textLabel.text = self.array[indexPath.section][indexPath.row][@"title"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (indexPath.section == 1) {
        cell.textLabel.textColor = [UIColor redColor];
    } else if ([self.array[indexPath.section][indexPath.row][@"title"] isEqualToString:@"福利"]) {
        cell.textLabel.textColor = [UIColor cyanColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.navigationController pushViewController:[[MyPostsViewController alloc] init] animated:true];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        [self.navigationController pushViewController:[[MyFollowingViewController alloc] init] animated:true];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        [self.navigationController pushViewController:[[MyFollowersViewController alloc] init] animated:true];
    }
    
}

@end
