//
//  BaseCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/24.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BaseCell.h"
#import "GeometricParameters.h"

@implementation BaseCell

- (instancetype)initWithType:(NSString *)type {
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _infoView = [[InfoView alloc] init];
        _mainView = [[MainView alloc] initWithType:type];
        _sourceTagsView = [[SourceTagsView alloc] init];
        _barView = [[BarView alloc] init];
        
        [self.contentView addSubview:_infoView];
        [self.contentView addSubview:_mainView];
        [self.contentView addSubview:_sourceTagsView];
        [self.contentView addSubview:_barView];
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false;
        _infoView.translatesAutoresizingMaskIntoConstraints = false;
        _mainView.translatesAutoresizingMaskIntoConstraints = false;
        _sourceTagsView.translatesAutoresizingMaskIntoConstraints =false;
        _barView.translatesAutoresizingMaskIntoConstraints = false;
        
        NSMutableArray * constraints = [NSMutableArray array];
        NSDictionary * subviews = @{
                                    @"infoView" : _infoView,
                                    @"mainView" : _mainView,
                                    @"sourceTagsView" : _sourceTagsView,
                                    @"barView" : _barView
                                    };
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:k_cell_width]];
        
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[infoView]-0-|" options:0 metrics:nil views:subviews]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[infoView]-0-[mainView]-0-[sourceTagsView]-0-[barView]-0-|" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:nil views:subviews]];

        [self.contentView addConstraints:constraints];


    }
    return self;
}

- (void)setDataModel:(PostsModel *)dataModel {
    _dataModel = dataModel;
}

@end
