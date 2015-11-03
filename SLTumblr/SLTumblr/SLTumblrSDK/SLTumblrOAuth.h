//
//  SLTumblrOAuth.h
//  SLTumblrSDK
//
//  Created by SL🐰鱼子酱 on 15/9/13.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 负责OAuth认证
@interface SLTumblrOAuth : NSObject



+ (instancetype)sharedSLTumblrOAuth;


// 返回  Authorization 字符串
+ (NSString *)authorizationWithURLString:(NSString *)URLString HTTPMethod:(NSString *)method postDicts:(NSDictionary *)postDicts authDicts:xauthParameter;

@end
