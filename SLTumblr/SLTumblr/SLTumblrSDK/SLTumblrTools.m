//
//  SLTumblrTools.m
//  SLTumblrSDK
//
//  Created by SL🐰鱼子酱 on 15/9/13.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "SLTumblrTools.h"
#import "SLTumblrOAuth.h"
#import "AFNetworking.h"



@implementation SLTumblrTools

+ (instancetype)sharedSLTumblrTools {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}






#pragma mark - ----------------两种访问方法------------------


/*
    GET访问方法 parametersDict需要参与baseString signature 验证
    url附带query参数
 */
+ (void)GETWithURLString:(NSString *)URLString parametersDict:(NSDictionary *)parametersDict authenticationType:(AuthenticationType)type callback:(SLTumblrCallback)callback {
    NSString * newURLString = [SLTumblrTools URLStringWithSortedQueryByURLString:URLString parametersDict:parametersDict];
    [[SLTumblrTools sharedSLTumblrTools] getRequestWithURLString:newURLString parametersDict:parametersDict authenticationType:type callback:callback];
}

/// POST访问方法
+ (void)POSTWithURLString:(NSString *)URLString parametersDict:(NSDictionary *)parametersDict callback:(SLTumblrCallback)callback {
    [[SLTumblrTools sharedSLTumblrTools] postRequestWithURLString:URLString parametersDict:parametersDict callback:callback];
}

/// MultipartPOST
+ (void)multipartPostRequestWithURLString:(NSString *)URLString type:(NSString *)type multipartDatas:(NSArray *)datas parametersDict:(NSDictionary *)parametersDict callbakc:(SLTumblrCallback)callback {
    [[SLTumblrTools sharedSLTumblrTools] multipartPostRequestWithURLString:URLString type:type multipartDatas:datas parametersDict:parametersDict callbakc:callback];
}

#pragma mark - -------------------分水岭----------------------



/// getRequest方法 url附带参数
- (void)getRequestWithURLString:(NSString *)URLString parametersDict:(NSDictionary *)parametersDict authenticationType:(AuthenticationType)type callback:(SLTumblrCallback)callback {
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    [request setValue:@"iPhone AppleWebKit" forHTTPHeaderField:@"User-Agent"];

    if (type == OAuthType) {
        NSString * authorization = [SLTumblrOAuth authorizationWithURLString:URLString HTTPMethod:request.HTTPMethod postDicts:nil authDicts:nil];
        [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    }

    [self setRequet:request forCallback:callback];
}

/// postRequest方法
- (void)postRequestWithURLString:(NSString *)URLString parametersDict:(NSDictionary *)parametersDict callback:(SLTumblrCallback)callback {
    
    NSMutableDictionary * parametersDictM = [NSMutableDictionary dictionaryWithDictionary:parametersDict];
    parametersDictM[@"api_key"] = [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerKey;
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    NSString * queryString = [SLTumblrTools queryBySortedKeysWithDictionary:parametersDictM];
    request.HTTPBody = [queryString dataUsingEncoding:NSUTF8StringEncoding];

    
    NSString * authorization = [SLTumblrOAuth authorizationWithURLString:URLString HTTPMethod:request.HTTPMethod postDicts:parametersDictM authDicts:nil];
    NSLog(@"%@", authorization);
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"iPhone AppleWebKit" forHTTPHeaderField:@"User-Agent"];
    
    [self setRequet:request forCallback:callback];
}

/// multipartPost
- (void)multipartPostRequestWithURLString:(NSString *)URLString type:(NSString *)type multipartDatas:(NSArray *)datas parametersDict:(NSDictionary *)parametersDict callbakc:(SLTumblrCallback)callback {
    
    NSMutableDictionary * parametersDictM = [NSMutableDictionary dictionaryWithDictionary:parametersDict];
    parametersDictM[@"api_key"] = [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerKey;
    parametersDictM[@"type"] = type;

//    NSURL * URL = [NSURL URLWithString:URLString];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
//    request.HTTPMethod = @"POST";
//    
//    NSString * boundary = [NSString stringWithFormat:@"JXHTTP-%@-%@", [[NSProcessInfo processInfo] globallyUniqueString], @([[SLTumblrTools timestamp] integerValue])];
//    NSString * contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
//    
//    NSMutableData * body = [NSMutableData data];
//    
//    for (NSString * key in [parametersDictM allKeys]) {
//        [body appendData:[self formDataWithData:[parametersDictM[key] dataUsingEncoding:NSUTF8StringEncoding] name:key filename:nil contentType:@"text/plain; charset=utf-8" boundary:boundary]];
//    }
//    
//    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString * name = [datas count] > 1 ? [NSString stringWithFormat:@"data[%li]", idx] : @"data";
//        [body appendData:[self formDataWithData:obj name:name filename:[NSString stringWithFormat:@"%li.jpg", idx] contentType:@"text/plain; charset=utf-8" boundary:boundary]];
//    }];
//    
//    NSString * tail = [NSString stringWithFormat:@"--%@--", boundary];
//    [body appendData:[tail dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    request.HTTPBody = body;

    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:parametersDictM constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        

        [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * name = [datas count] > 1? [NSString stringWithFormat:@"data[%li]", (unsigned long)idx] : @"data";
            [formData appendPartWithFileData:obj name:name fileName:[SLTumblrTools nonce] mimeType:@"text/plain; charset=utf-8"];
        }];

    } error:nil];


    NSString * authorization = [SLTumblrOAuth authorizationWithURLString:URLString HTTPMethod:request.HTTPMethod postDicts:parametersDictM authDicts:nil];
    NSLog(@"%@", authorization);
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"iPhone AppleWebKit" forHTTPHeaderField:@"User-Agent"];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            callback(responseObject, error);
        } else {
            if ([responseObject[@"meta"][@"status"] integerValue]/100 == 2) {
                callback(responseObject[@"response"], error);
            } else {
                callback(error, responseObject);
            }
        }
    }];
    
    [uploadTask resume];
    
}




- (NSData *)formDataWithData:(NSData *)data name:(NSString *)name filename:(NSString *)filename contentType:(NSString *)contentType boundary:(NSString *)boundary {
   
    NSMutableData * dataM = [NSMutableData data];
    NSMutableString * stringM = [NSMutableString string];
    
    [stringM appendFormat:@"--%@\r\r", boundary];
    [stringM appendFormat:@"Content-Disposition: form-data; name=\"%@\"", name];
    if (filename != nil) {
        [stringM appendFormat:@"; filename=\"%@\"", filename];
    }
    [stringM appendFormat:@"\r\nContent-Type: %@\r\n\r\n", contentType];
    [dataM appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];
    [stringM setString:@""];
    [dataM appendData:data];
    [dataM appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    return dataM.copy;
}




- (void)setRequet:(NSMutableURLRequest *)request forCallback:(SLTumblrCallback)callback {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            callback(responseObject, error);
        } else {
            if ([responseObject[@"meta"][@"status"] integerValue]/100 == 2) {
                callback(responseObject[@"response"], error);
            } else {
                callback(error, responseObject);
            }
        }
    }];
    
    [dataTask resume];
}


#pragma mark - ------------------获取参数---------------------

// 使用GET方法, 给地址加上参数, 并且排序
+ (NSString *)URLStringWithSortedQueryByURLString:(NSString *)URLString parametersDict:(NSDictionary *)parametersDict {
    
    NSString * URLStringWithAPI_Key = [URLString stringByAppendingConsumerKey];
    
    if (parametersDict == nil) {
        return URLStringWithAPI_Key;
    }
    
    NSString * baseURLString = [[URLStringWithAPI_Key componentsSeparatedByString:@"?"] firstObject];
    NSString * query = [[URLStringWithAPI_Key componentsSeparatedByString:@"?"] lastObject];
    NSMutableDictionary * allQueryDict = [SLTumblrTools dictionaryByQueryString:query].mutableCopy;
    
    [allQueryDict addEntriesFromDictionary:parametersDict];
    NSString * newURLString = [NSString stringWithFormat:@"%@?%@", baseURLString, [SLTumblrTools queryBySortedKeysWithDictionary:allQueryDict]];
    
    return newURLString;
}




/// 查询字段转字典(query to dict), 字典不排序
+ (NSDictionary *)dictionaryByQueryString:(NSString *)query {

    if (query == nil) {
        return nil;
    }
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSArray * components = [query componentsSeparatedByString:@"&"];
    for (NSString * component in components) {
        NSArray * keyValuePair = [component componentsSeparatedByString:@"="];
        if (keyValuePair.count == 2) {
            NSString * key = keyValuePair[0];
            NSString * value = keyValuePair[1];
            dict[key] = value;
        } else {
            return nil;
        }
    }
    return dict.copy;
}

/// 字典转查询字段(dict to query), 字典排序(sort)
+ (NSString *)queryBySortedKeysWithDictionary:(NSDictionary *)dict {
    NSMutableArray * parameters = [NSMutableArray array];
    
    for (id key in [[dict allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]) {

        NSString * value = [NSString stringWithFormat:@"%@", dict[key]];
        
        [parameters addObject:[NSString stringWithFormat:@"%@=%@", [key stringByAddingOAuthPercentEncodingWithEscapesCharacters], [value stringByAddingOAuthPercentEncodingWithEscapesCharacters]]];
    }
    
    return [parameters componentsJoinedByString:@"&"];
}

// UID
+ (NSString *)nonce {
    return [[NSProcessInfo processInfo] globallyUniqueString];
}

/// 现在时间的时间戳四舍五入值
+ (NSString *)timestamp {
    NSTimeInterval timerstamp = round([[NSDate date] timeIntervalSince1970]);
    return [NSString stringWithFormat:@"%lf", timerstamp];
}

/// 是否分配了 OAuthConsumerKey OAuthConsumerSecret
+ (void)isAssignedOAuthAPIKey {
    NSAssert([SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerKey != nil || [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerSecret != nil, @"ConsumerKey 或 ConsumerSecret 为空");
    [SLTumblrSDK sharedSLTumblrSDK].OAuthToken = nil;
    [SLTumblrSDK sharedSLTumblrSDK].OAuthTokenSecret = nil;
}


@end



@implementation NSString (SLTumblrTools)

static NSString * const escapesCharacters = @"!*'();:@& =+$,/?%#[]%";

/// StringByAddingOAuthPercentEncoding
- (NSString *)stringByAddingOAuthPercentEncodingWithEscapesCharacters {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:escapesCharacters].invertedSet];
}


- (NSString *)stringByAppendingConsumerKey {
    return [self stringByAppendingFormat:@"?api_key=%@", [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerKey];
}

- (NSString *)fullBlogName {
    return [self stringByAppendingString:@".tumblr.com"];
}

@end
