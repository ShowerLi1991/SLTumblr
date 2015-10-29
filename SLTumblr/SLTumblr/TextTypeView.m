//
//  TextTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "TextTypeView.h"
#import "GeometricParameters.h"

@implementation TextTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = [UIColor redColor];
        _bodyLabel = [[UILabel alloc] init];
        [self addSubview:_bodyLabel];
        _bodyLabel.numberOfLines = 0;
        _bodyLabel.backgroundColor = [UIColor greenColor];
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        _bodyLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[titleLabel]-margin-|" options:0 metrics:@{@"margin" : @(k_margin_width)} views:@{@"titleLabel" : _titleLabel}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[titleLabel]-margin-[bodyLabel]-margin-|" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:@{@"margin" : @(k_margin_height)} views:@{@"titleLabel" : _titleLabel, @"bodyLabel" : _bodyLabel}]];

    }
    return self;
}

@end
