//
//  LinkModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "LinkModel.h"

@implementation LinkModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        self.url = dict[@"url"];
        
        
        if ([dict[@"title"] isKindOfClass:[NSString class]]) {
            self.title = dict[@"title"];
        }
        self.publisher = dict[@"publisher"];
        if ([dict[@"author"] isKindOfClass:[NSString class]]) {
            self.author = dict[@"author"];
        }
        if ([dict[@"excerpt"] isKindOfClass:[NSString class]]) {
            self.excerpt = dict[@"excerpt"];
        }
        self.link_description = dict[@"description"];
    }
    return self;
}



@end

