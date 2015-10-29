//
//  AnswerTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/26.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "AnswerTypeView.h"
#import "GeometricParameters.h"

@implementation AnswerTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.icon_small = [[UIImageView alloc] init];
        [self addSubview:self.icon_small];
        
        self.askerButton = [[UIButton alloc] init];
        [self addSubview:self.askerButton];
        
        self.questionLabel = [[UILabel alloc] init];
        self.questionLabel.numberOfLines = 0;
        [self addSubview:self.questionLabel];
        
        self.answerLabel = [[UILabel alloc] init];
        self.answerLabel.numberOfLines = 0;
        [self addSubview:self.answerLabel];
        
        
        self.icon_small.translatesAutoresizingMaskIntoConstraints = false;
        self.askerButton.translatesAutoresizingMaskIntoConstraints = false;
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.answerLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        [self.icon_small addConstraint:[NSLayoutConstraint constraintWithItem:self.icon_small attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:32]];
        [self.icon_small addConstraint:[NSLayoutConstraint constraintWithItem:self.icon_small attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:32]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon_small attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon_small attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];

        self.askerButton.backgroundColor = [UIColor redColor];
        
        self.askerButtonLeadingCons = [NSLayoutConstraint constraintWithItem:self.askerButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:2 * k_margin_width + 32];
        [self addConstraint:self.askerButtonLeadingCons];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.askerButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.icon_small attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

        [self.askerButton addConstraint:[NSLayoutConstraint constraintWithItem:self.askerButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_button_size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.questionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.icon_small attribute:NSLayoutAttributeBottom multiplier:1.0 constant:k_margin_height]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[questionLabel]-margin-|" options:0 metrics:@{@"margin": @(k_margin_width)} views:@{@"questionLabel" : self.questionLabel}]];
         
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.answerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.questionLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:k_margin_height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.answerLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-k_margin_height]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[answerLabel]-margin-|" options:0 metrics:@{@"margin": @(k_margin_width)} views:@{@"answerLabel" : self.answerLabel}]];
        
    }
    return self;
}


@end
