//
//  FollowViewController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "FollowViewController.h"
#import "FollowModel.h"


@implementation FollowViewController

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView.rowHeight = 80;
    
    
    
}

#warning 使用coredata 缓存




- (NSArray *)followModels {
    if (_followModels == nil) {
        if (_result != nil) {
            _followModels = [FollowModel followModelsWithArray:self.result];
        }
    }
    return _followModels;
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.followModels.count;
}




@end
