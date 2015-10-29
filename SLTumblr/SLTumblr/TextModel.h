//
//  TextModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"

@interface TextModel : PostsModel

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * body;

@end
