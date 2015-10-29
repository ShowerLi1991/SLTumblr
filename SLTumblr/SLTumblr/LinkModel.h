//
//  LinkModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"

@interface LinkModel : PostsModel

@property (copy, nonatomic) NSString * title;   // 标题
@property (copy, nonatomic) NSString * url;     // link 地址
@property (copy, nonatomic) NSString * author;  // link_author
@property (copy, nonatomic) NSString * excerpt; // 摘要
@property (copy, nonatomic) NSString * publisher; // 发行人
@property (copy, nonatomic) NSString * link_description; // 描述, 可以是图片

@end
