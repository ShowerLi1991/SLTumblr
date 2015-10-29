//
//  AnswerModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/19.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "AnswerModel.h"

@implementation AnswerModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        self.asking_name = dict[@"asking_name"];
        if ([dict[@"asking_url"] isKindOfClass:[NSString class]]) {
            self.asking_url = dict[@"asking_url"];
        }
        self.question = dict[@"question"];
        self.answer = dict[@"answer"];
    }
    return self;
}
@end
