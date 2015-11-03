//
//  BlogInfoHeaderView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlogInfo;
@interface BlogInfoHeaderView : UICollectionReusableView


@property (strong, nonatomic) BlogInfo * blogInfo;
@property (strong, nonatomic) UIButton * iconView;

@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * descriptionLabel;
@property (strong, nonatomic) UIButton * postsButton;
@property (strong, nonatomic) UIButton * likesButton;

@property (strong, nonatomic) UIButton * followButton;

- (void)setDataModel:(BlogInfo *)blogInfo;


@end
