//
//  BlogInfoHeaderView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogInfoHeaderView.h"
#import "UIButton+WebCache.h"
#import "SLTumblrSDK.h"
#import "GeometricParameters.h"

@implementation BlogInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.hidden = true;

        self.followButton = [[UIButton alloc] init];
        [self addSubview:self.followButton];
        
        [self.followButton setTitle:@"follow" forState:UIControlStateNormal];
        [self.followButton setTitle:@"unfollow" forState:UIControlStateSelected];
        
        self.followButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
        self.followButton.layer.cornerRadius = 4;
        [self.followButton.layer setBorderWidth:1];
        [self.followButton.layer setBorderColor:[UIColor blackColor].CGColor];
        self.followButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.followButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [self.followButton addConstraint:[NSLayoutConstraint constraintWithItem:_followButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.followButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_followButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];

        _iconView = [[UIButton alloc] init];
        [self addSubview:_iconView];
        _iconView.translatesAutoresizingMaskIntoConstraints = false;
        
        [_iconView addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:128]];
        [_iconView addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:128]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_followButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_iconView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:k_margin_height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        
        _postsButton = [[UIButton alloc] init];
        [self addSubview:_postsButton];
        _postsButton.selected = true;
        [_postsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _postsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _postsButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postsButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postsButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postsButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-(k_margin_height + 10)]];
        
        _likesButton = [[UIButton alloc] init];
        [self addSubview:_likesButton];
        [_likesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likesButton.titleLabel.textAlignment = NSTextAlignmentCenter;

        _likesButton.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_likesButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_postsButton attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_likesButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_likesButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-(k_margin_height + 10)]];
        
        
        [_followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_iconView addTarget:self action:@selector(iconViewClick) forControlEvents:UIControlEventTouchUpInside];
        [_postsButton addTarget:self action:@selector(postsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_likesButton addTarget:self action:@selector(likesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}



- (void)followButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [[SLTumblrSDK sharedSLTumblrSDK] follow:self.blogInfo.name callback:^(id result, NSError *error) {
            if ([result[@"blog"][@"name"] isEqualToString:self.blogInfo.name]) {
                self.blogInfo.followed = button.selected;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"dashboardControllerRefresh" object:nil];
            } else {
                button.selected = !button.selected;
                self.blogInfo.followed = button.selected;
            }
        }];
    } else {
        [[SLTumblrSDK sharedSLTumblrSDK] unfollow:self.blogInfo.name callback:^(id result, NSError *error) {
            if ([result[@"blog"][@"name"] isEqualToString:self.blogInfo.name]) {
                self.blogInfo.followed = button.selected;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"dashboardControllerRefresh" object:nil];
            } else {
                button.selected = !button.selected;
                self.blogInfo.followed = button.selected;
            }
        }];
    }
}
- (void)iconViewClick {
 
}
- (void)postsButtonClick:(UIButton *)button {
}
- (void)likesButtonClick:(UIButton *)button {
}


- (void)setDataModel:(BlogInfo *)blogInfo {

    if (blogInfo != nil) {
        _blogInfo = blogInfo;
        
        if (blogInfo.followed) {
            _followButton.selected = true;
        } else {
            _followButton.selected = false;
        }
        
        [_iconView sd_setBackgroundImageWithURL:[NSURL URLWithString:[[SLTumblrSDK sharedSLTumblrSDK] avatarURLStringWithBlogName:self.blogInfo.name size:512]] forState:UIControlStateNormal];
        _titleLabel.text = blogInfo.title;
        
        [_postsButton setTitle:[NSString stringWithFormat:@"Posts: %@", blogInfo.posts_count] forState:UIControlStateNormal];
        
        if (blogInfo.share_likes) {
            [_likesButton setTitle:[NSString stringWithFormat:@"Likes: %@", blogInfo.likes] forState:UIControlStateNormal];
            _likesButton.hidden = false;
        } else {
            _likesButton.hidden = true;
        }
        
        self.hidden = false;
    }
    
}




- (void)drawRect:(CGRect)rect {
    
    UIBezierPath * path0 = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor colorWithRed:74/255.0 green:192/255.0 blue:226/255.0 alpha:1] setFill];
    [path0 fill];
    
    CGRect rectInSet = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 4, 10, 4));
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rectInSet];
    [[UIColor whiteColor] setFill];
    [path fill];

    [super drawRect:rect];
}

@end
