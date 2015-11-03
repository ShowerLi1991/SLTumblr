//
//  BlogController.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogColletionViewController.h"
#import "BlogInfo.h"

@interface BlogController : BlogColletionViewController

@property (strong, nonatomic) BlogInfo * blogInfo;

+ (instancetype)blogControllerWithBlogName:(NSString *)name;

@end
