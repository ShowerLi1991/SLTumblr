//
//  SLTumblrTools.h
//  SLTumblrSDK
//
//  Created by SL🐰鱼子酱 on 15/9/13.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLTumblrSDK.h"

typedef NS_OPTIONS(NSUInteger, AuthenticationType) {
    API_KeyType = 1,
    OAuthType = 2
};

@interface SLTumblrTools : NSObject



+ (instancetype)sharedSLTumblrTools;

/// 查询字段转字典(query to dict), 字典不排序
+ (NSDictionary *)dictionaryByQueryString:(NSString *)query;

/// 字典转查询字段(dict to query), 字典排序(sort)
+ (NSString *)queryBySortedKeysWithDictionary:(NSDictionary *)dict;

// UID
+ (NSString *)nonce;

// 时间戳
+ (NSString *)timestamp;

/// 是否分配了 OAuthConsumerKey OAuthConsumerSecret
+ (void)isAssignedOAuthAPIKey;

/// GET访问方法
+ (void)GETWithURLString:(NSString *)URLString parametersDict:(NSDictionary *)parametersDict authenticationType:(AuthenticationType)type callback:(SLTumblrCallback)callback;
/// POST访问方法
+ (void)POSTWithURLString:(NSString *)URLString parametersDict:(NSDictionary *)parametersDict callback:(SLTumblrCallback)callback;

+ (void)multipartPostRequestWithURLString:(NSString *)URLString type:(NSString *)type multipartDatas:(NSArray *)datas parametersDict:(NSDictionary *)parametersDict callbakc:(SLTumblrCallback)callback;

@end



@interface NSString (SLTumblrTools)

/// StringByAddingOAuthPercentEncoding
- (NSString *)stringByAddingOAuthPercentEncodingWithEscapesCharacters;

- (NSString *)stringByAppendingConsumerKey;
/// 补全blogName地址 xxx.tumblr.com
- (NSString *)fullBlogName;


@end



















