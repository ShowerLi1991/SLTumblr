//
//  FollowModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "FollowModel.h"

@implementation FollowModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self != nil) {
        self.name = dict[@"name"];
        self.updated = dict[@"updated"];
        self.url = dict[@"url"];
        if ([dict[@"title"] length] > 0) {
            self.title = dict[@"title"];
        }
        if ([dict[@"description"] length] > 0) {
            self.blog_description = dict[@"description"];
        }
        if (dict[@"following"] != nil) {
            self.following = [dict[@"following"] boolValue];
        }
        
    }
    return self;
}

+ (NSArray *)followModelsWithArray:(NSArray *)result {
    NSMutableArray * arrayM = [NSMutableArray array];
    for (NSDictionary * dict in result) {
        FollowModel * one = [[FollowModel alloc] initWithDict:dict];
        [arrayM addObject:one];
    }
    return arrayM.copy;
}


@end
