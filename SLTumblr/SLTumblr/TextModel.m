//
//  TextModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        if ([dict[@"title"] isKindOfClass:[NSString class]]) {
            self.title = dict[@"title"];
        }
        self.body = dict[@"body"];
    }
    return self;
}

@end
