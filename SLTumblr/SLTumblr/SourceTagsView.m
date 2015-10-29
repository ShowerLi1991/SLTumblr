
//
//  SourceTagsView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/22.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "SourceTagsView.h"
#import "GeometricParameters.h"

@interface SourceTagsView ()

@property (strong, nonatomic) NSLayoutConstraint * labelHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint * tagsMarginConstraint;

@end

@implementation SourceTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.clipsToBounds = true;
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        _labelHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height];
        [self addConstraint:_labelHeightConstraint];
        
        _exsitSource = true;
        _exsitTags = true;
        
        _sourceLabel = [[SourceLabel alloc] init];
        [self addSubview:_sourceLabel];
        _sourceLabel.backgroundColor = [UIColor redColor];
        
        _tagsLabel = [[TagsLabel alloc] init];
        [self addSubview:_tagsLabel];
        _tagsLabel.backgroundColor = [UIColor greenColor];
        
        _sourceLabel.translatesAutoresizingMaskIntoConstraints = false;
        _tagsLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sourceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sourceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sourceLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width]];
        
        
        _tagsMarginConstraint = [NSLayoutConstraint constraintWithItem:_tagsLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_sourceLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:k_margin_width];
        [self addConstraint:_tagsMarginConstraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tagsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
         
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tagsLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    }
    return self;
}



- (void)setExsitSource:(BOOL)exsitSource {
    if (_exsitSource == exsitSource) {
        return;
    } else {
        _exsitSource = exsitSource;
        if (!exsitSource) {
            _sourceLabel.text = @"";
        }
//        [self setNeedsLayout];
    }
}

- (void)setExsitTags:(BOOL)exsitTags {
    if (_exsitTags == exsitTags) {
        return;
    } else {
        _exsitTags = exsitTags;
        if (!exsitTags) {
            _tagsLabel.text = @"";
        }
//        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self exsitSourceAndTags];
}

- (void)exsitSourceAndTags {
    if (_exsitTags && _exsitSource) {
        _labelHeightConstraint.constant = k_button_size.height;
        _tagsMarginConstraint.constant = k_margin_width;
    } else if (_exsitTags && !_exsitSource) {
        _labelHeightConstraint.constant = k_button_size.height;
        _tagsMarginConstraint.constant = 0;
    } else if (!_exsitTags && _exsitSource) {
        _labelHeightConstraint.constant = k_button_size.height;
        _tagsMarginConstraint.constant = k_margin_width;
    } else {
        _labelHeightConstraint.constant = 0;
        _tagsMarginConstraint.constant = k_margin_width;
    }
}


@end
