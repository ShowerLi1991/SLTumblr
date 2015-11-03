//
//  FollowingTableViewCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "FollowingTableViewCell.h"
#import "GeometricParameters.h"
#import "UIImageView+WebCache.h"
#import "SLTumblrSDK.h"


@implementation FollowingTableViewCell

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
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLabel];
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:k_margin_width]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-k_margin_width]];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:k_margin_width]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-k_margin_width]];
        
    }
    return self;
}



- (void)setModel:(FollowModel *)model {
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[[SLTumblrSDK sharedSLTumblrSDK] avatarURLStringWithBlogName:model.name size:128]]];
    self.nameLabel.text = model.name;
    self.titleLabel.text = model.title;
}


@end
