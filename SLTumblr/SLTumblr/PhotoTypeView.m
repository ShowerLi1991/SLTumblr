//
//  PhotoTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/10.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PhotoTypeView.h"
#import "GeometricParameters.h"
#import "UIImageView+WebCache.h"
#import "PhotoModel.h"
#import "BaseImageView.h"


@implementation PhotoTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {

        for (NSInteger i = 0; i < 10; i++) {
            BaseImageView * imageView = [[BaseImageView alloc] init];
            imageView.backgroundColor = [UIColor grayColor];
            imageView.userInteractionEnabled = true;
            imageView.tag = i + 100;
            [self addSubview:imageView];
            imageView.translatesAutoresizingMaskIntoConstraints = false;
            [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_cell_width]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            
            if (imageView.tag == 100) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            } else {
                imageView.marginCons = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[self viewWithTag:i+99] attribute:NSLayoutAttributeBottom multiplier:1.0 constant:2];
                [self addConstraint:imageView.marginCons];
            }
            
            imageView.heightCons = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
            [imageView addConstraint:imageView.heightCons];
        }
        
        self.captionLabel = [[UILabel alloc] init];
        self.captionLabel.numberOfLines = 0;
        [self addSubview:self.captionLabel];
        
        self.captionLabel.translatesAutoresizingMaskIntoConstraints = false;

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[captionLabel]-margin-|" options:0 metrics:@{@"margin" : @(k_margin_width)} views:@{@"captionLabel" : self.captionLabel}]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.captionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[self viewWithTag:109] attribute:NSLayoutAttributeBottom multiplier:1.0 constant:k_margin_height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.captionLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-k_margin_height]];
        
    }
    return self;
}



- (void)setPhotos:(NSArray *)photos {
    
    _photos = photos;
    
    for (NSInteger i = 0; i < 10; i++) {
        BaseImageView * imageView = (BaseImageView *)[self viewWithTag:i + 100];
        if (i < photos.count) {
            imageView.hidden = false;
        
            Photos * photo = photos[i];
            CGFloat pictureHeight = [photo.height doubleValue];
            [imageView sd_setImageWithURL:[NSURL URLWithString:photo.url]];
            imageView.heightCons.constant = pictureHeight;
            if (i > 0) {
                imageView.marginCons.constant = 2;
            }
            
        } else {
            imageView.image = nil;
            imageView.heightCons.constant = 0;
            imageView.marginCons.constant = 0;
            imageView.hidden = true;
        }  
    }
}

@end
