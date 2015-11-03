//
//  InfoView.m
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "InfoView.h"
#import "GeometricParameters.h"
#import "PostsModel.h"

@implementation InfoView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        _InfoViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:64];
        [self addConstraint:_InfoViewHeightConstraint];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_infoType == InfoViewTypeDashboard) {
        if (self.reblogNameButton.hidden) {
            _nameButton.yCons.constant = (k_icon_button_side_length - k_button_size.height) * 0.5 + k_margin_height;
        } else {
            _nameButton.yCons.constant = k_margin_height;
            _reblogNameButton.xCons.constant = k_margin_width * 2 + k_icon_button_side_length;
            _reblogNameButton.yCons.constant = k_margin_height + k_icon_button_side_length - k_button_size.height;
        }
    } else {
        if (!self.reblogNameButton.hidden) {
            _reblogNameButton.xCons.constant = k_margin_width;
            _reblogNameButton.yCons.constant = k_margin_height;
        }
    }
}



- (BaseButton *)iconView {
    if (_iconView == nil) {
        _iconView = [[BaseButton alloc] init];
        [self addSubview:_iconView];
        _iconView.translatesAutoresizingMaskIntoConstraints = false;
        
        [_iconView addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_icon_button_side_length]];
        [_iconView addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_icon_button_side_length]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
    }
    return _iconView;
}



- (BaseButton *)nameButton {
    if (_nameButton == nil) {
        _nameButton = [[BaseButton alloc] init];
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_nameButton];
        _nameButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_nameButton addConstraint:[NSLayoutConstraint constraintWithItem:_nameButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_icon_button_side_length + k_margin_width * 2]];
        _nameButton.yCons = [NSLayoutConstraint constraintWithItem:_nameButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:(k_icon_button_side_length - k_button_size.height) * 0.5 + k_margin_height];
        [self addConstraint:_nameButton.yCons];
    }
    return _nameButton;
}

- (ReblogNameButton *)reblogNameButton {
    if (_reblogNameButton == nil) {
        _reblogNameButton = [[ReblogNameButton alloc] init];
        _reblogNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_reblogNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_reblogNameButton setImage:[UIImage imageNamed:@"reblog_name"] forState:UIControlStateNormal];
        [self addSubview:_reblogNameButton];
        _reblogNameButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_reblogNameButton addConstraint:[NSLayoutConstraint constraintWithItem:_reblogNameButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];

        _reblogNameButton.xCons = [NSLayoutConstraint constraintWithItem:_reblogNameButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width * 2 + k_icon_button_side_length];
        [self addConstraint:_reblogNameButton.xCons];
        _reblogNameButton.yCons = [NSLayoutConstraint constraintWithItem:_reblogNameButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height + k_icon_button_side_length - k_button_size.height];
        [self addConstraint:_reblogNameButton.yCons];
    }
    return _reblogNameButton;
}



- (BaseButton *)followButton {
    if (_followButton == nil) {
        _followButton = [[BaseButton alloc] init];
        [_followButton setTitle:@"follow" forState:UIControlStateNormal];
        [_followButton setTitle:@"unfollow" forState:UIControlStateSelected];
        
        
        _followButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
        _followButton.layer.cornerRadius = 4;
        [_followButton.layer setBorderWidth:1];
        [_followButton.layer setBorderColor:[UIColor blackColor].CGColor];
        
        
        _followButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_followButton];
        _followButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_followButton addConstraint:[NSLayoutConstraint constraintWithItem:_followButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:_followButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_followButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height + (k_icon_button_side_length - k_button_size.height) * 0.5]];
    }
    return _followButton;
}



@end
