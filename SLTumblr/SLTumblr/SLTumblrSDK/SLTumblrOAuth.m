//
//  SLTumblrOAuth.m
//  SLTumblrSDK
//
//  Created by SL🐰鱼子酱 on 15/9/13.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "SLTumblrOAuth.h"
#import <CommonCrypto/CommonHMAC.h>
#import "SLTumblrTools.h"




@implementation SLTumblrOAuth

+ (instancetype)sharedSLTumblrOAuth {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


+ (NSString *)authorizationWithURLString:(NSString *)URLString HTTPMethod:(NSString *)method postDicts:(NSDictionary *)postDicts authDicts:xauthParameter {
    
    return [[SLTumblrOAuth sharedSLTumblrOAuth] authorizationWithURLString:URLString HTTPMethod:method postDicts:postDicts authDicts:xauthParameter];
    
}



- (NSString *)authorizationWithURLString:(NSString *)URLString HTTPMethod:(NSString *)method postDicts:(NSDictionary *)postDicts authDicts:(NSDictionary *)authParameter {
    
    NSString * baseURLString = [[URLString componentsSeparatedByString:@"?"] firstObject];
    if ([method isEqualToString:@"GET"] && postDicts == nil) {
        NSString * query = [URLString stringByReplacingOccurrencesOfString:[baseURLString stringByAppendingString:@"?"] withString:@""];
        postDicts = [SLTumblrTools dictionaryByQueryString:query];
    }
    
    
    NSMutableDictionary * headerParameters = [NSMutableDictionary dictionaryWithDictionary:
                                              @{
                                                @"oauth_timestamp" : [SLTumblrTools timestamp],
                                                @"oauth_nonce" : [SLTumblrTools nonce],
                                                @"oauth_version" : @"1.0",
                                                @"oauth_signature_method" : @"HMAC-SHA1",
                                                @"oauth_consumer_key" : [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerKey,
                                                }];
    
    if ([SLTumblrSDK sharedSLTumblrSDK].OAuthToken != nil) {
        headerParameters[@"oauth_token"] = [SLTumblrSDK sharedSLTumblrSDK].OAuthToken;
    }
    
    NSString * baseString = [self baseStringWithMethod:method baseURLString:baseURLString headerParameters:headerParameters.copy queryParameters:postDicts postParameters:authParameter];
    NSLog(@"%@", baseString);
    NSString * signature = [self signatureWithBaseString:baseString consumerSecret:[SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerSecret tokenSecret:[SLTumblrSDK sharedSLTumblrSDK].OAuthTokenSecret];
    
    headerParameters[@"oauth_signature"] = signature;
    
    if (authParameter != nil) {
        [headerParameters addEntriesFromDictionary:authParameter];
    }
    
    return [self authorizationStringWithOAuthDict:headerParameters.copy];
    
    
}


// Authorization String with Dict
- (NSString *)authorizationStringWithOAuthDict:(NSDictionary *)oauthDict {
    NSMutableArray *components = [NSMutableArray array];
    
    for (NSString *key in oauthDict) {
        NSString * value = oauthDict[key];
        [components addObject:[NSString stringWithFormat:@"%@=\"%@\"", key, [value stringByAddingOAuthPercentEncodingWithEscapesCharacters]]];
    }
    
    NSString * authorization = [NSString stringWithFormat:@"OAuth %@", [components componentsJoinedByString:@","]];
    
    return authorization;
}


// 需要加密的 baseString
- (NSString *)baseStringWithMethod:(NSString *)method baseURLString:(NSString *)baseURLString headerParameters:(NSDictionary *)headerParameters queryParameters:(NSDictionary *)queryParameters postParameters:(NSDictionary *)postParameters {
    
    NSMutableDictionary * tempDictM = [NSMutableDictionary dictionaryWithDictionary:headerParameters];
    
    if (queryParameters != nil) {
        [tempDictM addEntriesFromDictionary:queryParameters];
    }
    if (postParameters != nil) {
        [tempDictM addEntriesFromDictionary:postParameters];
    }
    
    NSString * headerSortedString = [SLTumblrTools queryBySortedKeysWithDictionary:tempDictM];
        
    NSString * baseString = [NSString stringWithFormat:@"%@&%@&%@",
                             method,
                             [baseURLString stringByAddingOAuthPercentEncodingWithEscapesCharacters],
                             [headerSortedString stringByAddingOAuthPercentEncodingWithEscapesCharacters]
                             ];
    return baseString;
}



/*!
 *  oauth_signature(数字签名):
 *  密方式:1.通过hmac-sha1加密, 加密方式 "value = queryData, key = consumerKey + "&" + tokenSecret"; 2.对返回的hashData做base64
 *  @param queryStringPercentEncoding 查询字段(百分号转义)
 *  @param consumerKey
 *  @param tokenSecret
 *
 *  @return oauth_signature
 */
- (NSString *)signatureWithBaseString:(NSString *)baseString consumerSecret:(NSString *)consumerKey tokenSecret:(NSString *)tokenSecret {
    
    NSString * keyString = [NSString stringWithFormat:@"%@&%@", consumerKey, tokenSecret != nil ? tokenSecret : @"" ];
    
    NSData * valueData = [baseString dataUsingEncoding:NSUTF8StringEncoding];
    NSData * keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    
    // hmacsha1
    void *buffer = malloc(CC_SHA1_DIGEST_LENGTH);
    CCHmac(kCCHmacAlgSHA1, [keyData bytes], [keyData length], [valueData bytes], [valueData length], buffer);
    NSData * hs1Data = [NSData dataWithBytesNoCopy:buffer length:CC_SHA1_DIGEST_LENGTH freeWhenDone:YES];
    
    return [hs1Data base64EncodedStringWithOptions:0];
    
}


@end
