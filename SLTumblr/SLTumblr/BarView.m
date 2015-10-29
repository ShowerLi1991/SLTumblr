//
//  BarView.m
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BarView.h"
#import "GeometricParameters.h"

@implementation BarView

- (void)setBarType:(BarViewType)barType {
    if (_barType != barType) {
        _barType = barType;
        [self setNeedsLayout];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_bar_height]];
        
        _noteButton = [[UIButton alloc] init];
        _noteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_noteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _noteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_noteButton];
        _noteButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_noteButton addConstraint:[NSLayoutConstraint constraintWithItem:_noteButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_noteButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_noteButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
  
        
        _reblogButton = [[UIButton alloc] init];
        [_reblogButton setImage:[UIImage imageNamed:@"btn_reblog_normal"] forState:UIControlStateNormal];
        [self addSubview:_reblogButton];
        _reblogButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_reblogButton addConstraint:[NSLayoutConstraint constraintWithItem:_reblogButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.width]];
        [_reblogButton addConstraint:[NSLayoutConstraint constraintWithItem:_reblogButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_reblogButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_cell_width - (k_button_size.width + k_margin_width) * 2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_reblogButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_barType == BarViewTypeOthers) {
        self.operationButton.hidden = true;
        self.sharedButton.hidden = false;
        self.likedButton.hidden = false;
    } else {
        self.sharedButton.hidden = true;
        self.likedButton.hidden = true;
        self.operationButton.hidden = false;
    }
}

- (UIButton *)sharedButton {
    if (_sharedButton == nil) {
        _sharedButton = [[UIButton alloc] init];
        [_sharedButton setImage:[UIImage imageNamed:@"btn_shared_normal"] forState:UIControlStateNormal];
        [self addSubview:_sharedButton];
        _sharedButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_sharedButton addConstraint:[NSLayoutConstraint constraintWithItem:_sharedButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.width]];
        [_sharedButton addConstraint:[NSLayoutConstraint constraintWithItem:_sharedButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sharedButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_cell_width - (k_button_size.width + k_margin_width) * 3]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_sharedButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
        
    }
    return _sharedButton;
}

- (UIButton *)likedButton {
    if (_likedButton == nil) {
        _likedButton = [[UIButton alloc] init];
        [_likedButton setImage:[UIImage imageNamed:@"btn_like_normal"] forState:UIControlStateNormal];
        [_likedButton setImage:[UIImage imageNamed:@"btn_like_selected"] forState:UIControlStateSelected];
        [self addSubview:_likedButton];
        _likedButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_likedButton addConstraint:[NSLayoutConstraint constraintWithItem:_likedButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.width]];
        [_likedButton addConstraint:[NSLayoutConstraint constraintWithItem:_likedButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_likedButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_cell_width - k_button_size.width - k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_likedButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
    }
    return _likedButton;
}

- (UIButton *)operationButton {
    if (_operationButton == nil) {
        _operationButton = [[UIButton alloc] init];
        [_operationButton setImage:[UIImage imageNamed:@"btn_operation_normal"] forState:UIControlStateNormal];
        [self addSubview:_operationButton];
        _operationButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_operationButton addConstraint:[NSLayoutConstraint constraintWithItem:_operationButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.width]];
        [_operationButton addConstraint:[NSLayoutConstraint constraintWithItem:_operationButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_operationButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_cell_width - k_button_size.width - k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_operationButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
    }
    return _operationButton;
}


@end
