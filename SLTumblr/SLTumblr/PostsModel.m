//
//  PostsModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/28.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"
#import "SLTumblrSDK.h"

#import "TextModel.h"
#import "PhotoModel.h"
#import "QuoteModel.h"
#import "LinkModel.h"
#import "ChatModel.h"
#import "AudioModel.h"
#import "VideoModel.h"
#import "AnswerModel.h"


@implementation PostsModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        // infoView
        self.name = dict[@"blog_name"];
        self.icon = [[SLTumblrSDK sharedSLTumblrSDK] avatarURLStringWithBlogName:self.name size:96];
        self.is_root_item = [[dict[@"trail"] firstObject][@"is_root_item"] boolValue];

        self.reblog_name = @"暂无";
        self.followed = [dict[@"followed"] boolValue];
        
        
        // mainView
        self.reblog_text = [[dict[@"trail"] firstObject] valueForKey:@"content"];
        self.source_title = dict[@"source_title"];
        self.source_url = dict[@"source_url"];
        if ([dict[@"tags"] count] > 0) {
            self.tags = dict[@"tags"];
        }
        
        // barView
        self.note_count = dict[@"note_count"];
        self.liked = [dict[@"liked"] boolValue];
        
        
        // 基本信息
        self.id = dict[@"id"];
        self.type = dict[@"type"];
        self.post_url = dict[@"post_url"];
        self.short_url = dict[@"short_url"];
        
        self.date = dict[@"date"];
        self.timestamp = dict[@"timestamp"];
        self.reblog_key = dict[@"reblog_key"];
        self.state = dict[@"state"];
    }
    return self;
}

+ (NSArray *)modelsWithArray:(NSArray *)arrayDict {
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * post in arrayDict) {
        if (post[@"type"] != nil) {
            NSString * typeModelName = [NSString stringWithFormat:@"%@Model", [post[@"type"] capitalizedString]];
            Class TypeModel = NSClassFromString(typeModelName);
            id temp = [[TypeModel alloc] initWithDict:post];
            [arr addObject:temp];
        }
    }
    return arr.copy;
}


@end

@implementation Embed
@end
