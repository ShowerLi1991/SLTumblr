//
//  QuoteTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/25.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "QuoteTypeView.h"
#import "GeometricParameters.h"

@implementation QuoteTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        _textLabel.numberOfLines = 0;
        _textLabel.backgroundColor = [UIColor redColor];
        _sourceLabel = [[UILabel alloc] init];
        [self addSubview:_sourceLabel];
        _sourceLabel.numberOfLines = 0;
        _sourceLabel.backgroundColor = [UIColor greenColor];
        
        _textLabel.translatesAutoresizingMaskIntoConstraints = false;
        _sourceLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[textLabel]-margin-|" options:0 metrics:@{@"margin" : @(k_margin_width)} views:@{@"textLabel" : _textLabel}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[textLabel]-margin-[sourceLabel]-margin-|" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:@{@"margin" : @(k_margin_height)} views:@{@"textLabel" : _textLabel, @"sourceLabel" : _sourceLabel}]];
        
    }
    return self;
}

@end
