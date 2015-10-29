//
//  ChatModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"
#import <UIKit/UIKit.h>

@interface ChatModel : PostsModel

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * body;    // 老板: 年终奖15薪
@property (copy, nonatomic) NSArray * dialogue; // 分段对话


@end



@interface Dialogue : NSObject

@property (copy, nonatomic) NSString * label;   // 老板
@property (copy, nonatomic) NSString * name;    // 老板
@property (copy, nonatomic) NSString * phrase;  // 年终奖15薪

@property (copy, nonatomic) NSString * lineString;
@property (assign, nonatomic) CGFloat rowHeight;

@end
