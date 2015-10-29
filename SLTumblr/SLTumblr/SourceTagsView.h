//
//  SourceTagsView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/22.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SourceLabel.h"
#import "TagsLabel.h"

@interface SourceTagsView : UIView

@property (strong, nonatomic) SourceLabel * sourceLabel;
@property (strong, nonatomic) TagsLabel * tagsLabel;


// 如果 source 和 tags 都为空 设置sourceTagsView 的高度为空
@property (assign, nonatomic) BOOL exsitSource;
@property (assign, nonatomic) BOOL exsitTags;

@end
