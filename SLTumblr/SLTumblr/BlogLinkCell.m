//
//  BlogLinkCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogLinkCell.h"
#import "LinkTypeView.h"
#import "LinkModel.h"

@implementation BlogLinkCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithKind:@"blogPosts" type:@"link"];
    if (self) {
    }
    return self;
}

- (void)setDataModel:(LinkModel *)dataModel {
    [super setDataModel:dataModel];
    
    
    // type link
    LinkTypeView * linkView = (LinkTypeView *)[self.mainView viewWithTag:100003];
    linkView.publisherLabel.text = dataModel.publisher;
    linkView.titleLabel.text = dataModel.title;
    linkView.excerptLabel.text = dataModel.excerpt;
    linkView.descriptionLabel.text = dataModel.link_description;
    linkView.url = dataModel.url;
    
}

@end
