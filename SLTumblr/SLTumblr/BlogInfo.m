//
//  BlogInfo.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogInfo.h"

@implementation BlogInfo

+ (instancetype)blogInfoWithDict:(NSDictionary *)dict {
    
    BlogInfo * info = [[BlogInfo alloc] init];
    info.title = dict[@"title"];
    info.name = dict[@"name"];
    info.blog_description = dict[@"description"];
    info.posts_count = dict[@"posts"];
    info.updated = dict[@"updated"];
    info.followed = [dict[@"followed"] boolValue];
    info.share_likes = [dict[@"share_likes"] boolValue];
    if (info.share_likes) {
        info.likes = dict[@"likes"];
    }
    info.NSFW = [dict[@"is_nsfw"] boolValue];
    
    return info;
}

@end
