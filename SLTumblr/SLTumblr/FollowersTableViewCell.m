//
//  FollowersTableViewCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "FollowersTableViewCell.h"
#import "GeometricParameters.h"
#import "SLTumblrSDK.h"
#import "UIImageView+WebCache.h"


@implementation FollowersTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false;
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_sceen_width]];
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        self.iconView.translatesAutoresizingMaskIntoConstraints = false;
        [self.iconView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_icon_follow_side_length]];
        [self.iconView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_icon_follow_side_length]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
    
        
        self.followButton = [[UIButton alloc] init];
        [self.contentView addSubview:self.followButton];
        
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
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.followButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-k_margin_width]];
        [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.followButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [self.followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLabel];
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:k_margin_width]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.followButton attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-k_margin_width]];
        
    }
    return self;
}


- (void)followButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [[SLTumblrSDK sharedSLTumblrSDK] follow:self.nameLabel.text callback:^(id result, NSError *error) {
            if ([result[@"blog"][@"name"] isEqualToString:self.nameLabel.text]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"dashboardControllerRefresh" object:nil];
            } else {
                button.selected = !button.selected;
            }
        }];
    } else {
        [[SLTumblrSDK sharedSLTumblrSDK] unfollow:self.nameLabel.text callback:^(id result, NSError *error) {
            if ([result[@"blog"][@"name"] isEqualToString:self.nameLabel.text]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"dashboardControllerRefresh" object:nil];
            } else {
                button.selected = !button.selected;
            }
        }];
    }
}


- (void)setModel:(FollowModel *)model {
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[[SLTumblrSDK sharedSLTumblrSDK] avatarURLStringWithBlogName:model.name size:128]]];
    self.nameLabel.text = model.name;
    self.followButton.selected = model.following;
}

@end
