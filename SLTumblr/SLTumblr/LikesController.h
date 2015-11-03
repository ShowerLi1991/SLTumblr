//
//  LikesController.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/31.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashCollectionViewController.h"


@interface LikesController : DashCollectionViewController

- (void)loadDataAndReload:(BOOL)reload completionHandler:(void(^)())handler;

@end
