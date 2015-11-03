//
//  SLTumblrSDK.m
//  SLTumblrSDK
//
//  Created by SL🐰鱼子酱 on 15/9/23.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "SLTumblrSDK.h"
#import "SLTumblrTools.h"
#import "SLTumblrAuthenticator.h"

@implementation SLTumblrSDK


+ (instancetype)sharedSLTumblrSDK {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark ------------------Authentication-------------

#warning TODO-xauth 暂时未添加
//- (void)xAuthWithEmailAddress:(NSString *)emailAddress password:(NSString *)password callback:(SLAuthenticatorCallback)callback {
//    [SLTumblrAuthenticator xAuthPostWithEmailAddress:emailAddress password:password callback:callback];
//}



#pragma mark ----------------- User ----------------------

- (void)userInfo:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/info";
    [SLTumblrTools GETWithURLString:urlString parametersDict:nil authenticationType:OAuthType callback:callback];
}

- (void)userDashboard:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/dashboard";
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

- (void)userLikes:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/likes";
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

- (void)userFollowing:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/following";
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

- (void)userFollowers:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/followers", self.blogName];
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

- (void)userQueue:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/posts/queue", self.blogName];
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

- (void)userDrafts:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/posts/draft", self.blogName];
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

- (void)userSubmissions:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/posts/submission", self.blogName];
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

- (void)userPosts:(NSDictionary *)parameters type:(NSString *)type callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/posts", self.blogName];
    NSMutableDictionary * parametersM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    parametersM[@"type"] = type;
    [SLTumblrTools GETWithURLString:urlString parametersDict:parametersM.copy authenticationType:OAuthType callback:callback];
}

#pragma mark ------------------blog----------------------

#warning TODO-blogTheme未完成
- (void)blogTheme:(NSString *)blogName callback:(SLTumblrCallback)callback {
    //    https://api.tumblr.com/v2/blog/520-520.tumblr.com/info?api_key=BUHsuO5U9DF42uJtc8QTZlOmnUaJmBJGuU1efURxeklbdiLn9L
}

- (void)blogInfo:(NSString *)blogName callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/info", blogName];
    [SLTumblrTools GETWithURLString:urlString parametersDict:nil authenticationType:OAuthType callback:callback];
}

- (void)blogPosts:(NSString *)blogName parameters:(NSDictionary *)parameters type:(NSString *)type callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/posts", blogName];
    NSMutableDictionary * parametersM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    parametersM[@"type"] = type;
    [SLTumblrTools GETWithURLString:urlString parametersDict:parametersM.copy authenticationType:OAuthType callback:callback];
}

- (void)blogLikes:(NSString *)blogName parameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/likes", blogName];
    [SLTumblrTools GETWithURLString:urlString parametersDict:parameters authenticationType:OAuthType callback:callback];
}

// 返回图片地址
- (NSString *)avatarURLStringWithBlogName:(NSString *)blogName size:(NSUInteger)size {
    NSString * urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/avatar/%@", blogName, @(size)];
    return urlString;
}

#warning TODO-blogTagged未完成
- (void)blogTagged:(NSString *)tag parameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    
}

- (void)worldTagged:(NSString *)tag parameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/tagged";
    NSMutableDictionary * parametersM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    parametersM[@"tag"] = tag;
    [SLTumblrTools GETWithURLString:urlString parametersDict:parametersM authenticationType:OAuthType callback:callback];
}

#pragma mark ------------------Operation------------------------


- (void)follow:(NSString *)blogName callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/follow";
    [SLTumblrTools POSTWithURLString:urlString parametersDict:@{@"url" : [blogName fullBlogName]} callback:callback];
}

- (void)unfollow:(NSString *)blogName callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/unfollow";
    [SLTumblrTools POSTWithURLString:urlString parametersDict:@{@"url" : [blogName fullBlogName]} callback:callback];
}

- (void)like:(NSNumber *)postID reblogKey:(NSString *)reblogKey callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/like";
    [SLTumblrTools POSTWithURLString:urlString parametersDict:@{ @"id" : postID, @"reblog_key" : reblogKey } callback:callback];
}

- (void)unlike:(NSNumber *)postID reblogKey:(NSString *)reblogKey callback:(SLTumblrCallback)callback {
    NSString * urlString = @"https://api.tumblr.com/v2/user/unlike";
    [SLTumblrTools POSTWithURLString:urlString parametersDict:@{ @"id" : postID, @"reblog_key" : reblogKey } callback:callback];
}



#pragma mark ------------------Posting------------------------

- (NSString *)postingURLString {
    return [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/post", [SLTumblrSDK sharedSLTumblrSDK].blogName];
}

- (void)textPostingWithParameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    [self creatPostWithType:@"text" parameters:parameters callback:callback];

}

- (void)quotePostingWithParameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    [self creatPostWithType:@"quote" parameters:parameters callback:callback];

}

- (void)linkPostingWithParameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    [self creatPostWithType:@"link" parameters:parameters callback:callback];

}

- (void)chatPostingWithParameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    [self creatPostWithType:@"chat" parameters:parameters callback:callback];
}

- (void)photoPostingWithImageArray:(NSArray *)imageArray parameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSMutableArray * datas = [NSMutableArray array];
    for (UIImage * image in imageArray) {
        [datas addObject:UIImagePNGRepresentation(image)];
    }
    [SLTumblrTools multipartPostRequestWithURLString:[self postingURLString] type:@"photo" multipartDatas:datas parametersDict:parameters callbakc:callback];
}

- (void)videoPostingWithVideoData:(NSData *)videoData parameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    [SLTumblrTools multipartPostRequestWithURLString:[self postingURLString] type:@"video" multipartDatas:@[videoData] parametersDict:parameters callbakc:callback];
}

- (void)audioPostingWithAudioData:(NSData *)audioData parameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    [SLTumblrTools multipartPostRequestWithURLString:[self postingURLString] type:@"audio" multipartDatas:@[audioData] parametersDict:parameters callbakc:callback];
}


#pragma mark ------------------Posting Mgr------------------------


- (void)creatPostWithType:(NSString *)type parameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [self postingURLString];
    NSMutableDictionary * parametersM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    parametersM[@"type"] = type;
    [SLTumblrTools POSTWithURLString:urlString parametersDict:parametersM callback:callback];
}

- (void)editPostWithParameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"%@/edit", [self postingURLString]];
    [SLTumblrTools POSTWithURLString:urlString parametersDict:parameters callback:callback];
    
}

- (void)reblogPostWithParameters:(NSDictionary *)parameters callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"%@/reblog", [self postingURLString]];
    [SLTumblrTools POSTWithURLString:urlString parametersDict:parameters callback:callback];
}

- (void)deletePostWithId:(NSString *)postID callback:(SLTumblrCallback)callback {
    NSString * urlString = [NSString stringWithFormat:@"%@/delete", [self postingURLString]];
    [SLTumblrTools POSTWithURLString:urlString parametersDict:@{@"id" : postID} callback:callback];
}



@end
