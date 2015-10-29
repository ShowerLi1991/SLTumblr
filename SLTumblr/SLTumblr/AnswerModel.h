//
//  AnswerModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/19.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"

@interface AnswerModel : PostsModel

@property (copy, nonatomic) NSString * asking_name;
@property (copy, nonatomic) NSString * asking_url;  // 提问人的主页
@property (copy, nonatomic) NSString * question;    // 问题
@property (copy, nonatomic) NSString * answer;      // 回答

@end
