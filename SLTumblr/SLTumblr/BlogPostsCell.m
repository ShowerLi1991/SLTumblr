//
//  BlogPostsCell.m
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/22.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogPostsCell.h"

@implementation BlogPostsCell

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.infoView.infoType = InfoViewTypeBlogPosts;
        self.infoView.InfoViewHeightConstraint.constant = 8;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 子控件constant
    if (self.infoView.reblogNameButton.hidden) {
        self.infoView.InfoViewHeightConstraint.constant = 8;
    } else {
        self.infoView.InfoViewHeightConstraint.constant = 38;
    }
    
    
    NSLog(@"BlogPostsCellLayoutSubviews");

    
}

@end
