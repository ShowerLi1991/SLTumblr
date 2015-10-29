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

@interface ProfileController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UITableView * profileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:profileTable];
    profileTable.delegate = self;
    profileTable.dataSource = self;

    profileTable.backgroundColor = [UIColor colorWithRed:74/255.0 green:192/255.0 blue:226/255.0 alpha:1];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"logout"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logout"];
        }
        cell.textLabel.text = @"Logout";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        return cell;
    }

    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"profile"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"profile"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Following";
            cell.detailTextLabel.text = @"12345";
            break;
        case 1:
            cell.textLabel.text = @"Followed";
            cell.detailTextLabel.text = @"1234";
            break;
        default:
            break;
    }
    return cell;
}

@end
