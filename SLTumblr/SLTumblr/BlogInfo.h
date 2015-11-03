//
//  BlogInfo.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogInfo : NSObject

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * name;
@property (copy, nonatomic) NSString * blog_description;
@property (copy, nonatomic) NSNumber * posts_count;
@property (copy, nonatomic) NSNumber * updated;

@property (assign, nonatomic, getter=isFollowed) BOOL followed;
@property (assign, nonatomic, getter=isShareLikes) BOOL share_likes;
@property (copy, nonatomic) NSNumber * likes;

@property (assign, nonatomic, getter=isNSFW) BOOL NSFW;

+ (instancetype)blogInfoWithDict:(NSDictionary *)dict;

@end
