//
//  LinkTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/25.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "LinkTypeView.h"
#import "GeometricParameters.h"

@implementation LinkTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.publisherLabel = [[UILabel alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.excerptLabel = [[UILabel alloc] init];
        self.descriptionLabel = [[UILabel alloc] init];
        
        self.publisherLabel.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        self.excerptLabel.backgroundColor = [UIColor lightGrayColor];

        self.publisherLabel.numberOfLines = 0;
        self.titleLabel.numberOfLines = 0;
        self.excerptLabel.numberOfLines = 0;
        self.descriptionLabel.numberOfLines = 0;
        
        [self addSubview:self.publisherLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.excerptLabel];
        [self addSubview:self.descriptionLabel];
        
        self.publisherLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.excerptLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        NSDictionary * subviews = @{
                                    @"pub" : self.publisherLabel,
                                    @"title" : self.titleLabel,
                                    @"excerpt" : self.excerptLabel,
                                    @"description" : self.descriptionLabel
                                    };
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pub]-0-|" options:0 metrics:nil views:subviews]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[pub]-0-[title]-0-[excerpt]-margin-[description]-margin-|" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:@{@"margin" : @(k_margin_height)} views:subviews]];
        
        
        UIButton * mask = [[UIButton alloc] init];
        [self addSubview:mask];
        mask.backgroundColor = [UIColor clearColor];
        mask.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[mask]-0-|" options:0 metrics:nil views:@{@"mask" : mask}]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:mask attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.publisherLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:mask attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.excerptLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        
        [mask addTarget:self action:@selector(maskButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return self;
}

- (void)maskButtonClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.url]];
}



@end
