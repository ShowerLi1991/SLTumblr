//
//  SLTumblrAuthenticator.m
//  SLTumblrSDK
//
//  Created by SL🐰鱼子酱 on 15/9/13.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "SLTumblrAuthenticator.h"
#import "SLTumblrOAuth.h"
#import "SLTumblrTools.h"

typedef void (^SLAuthenticatorCallback)(NSURLResponse *response, id responseObject, NSError *error);

@interface SLTumblrAuthenticator ()

@end

@implementation SLTumblrAuthenticator


+ (instancetype)sharedSLTumblrAuthenticator {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


#pragma mark - xAuth验证方法

// 待续




#pragma mark - OAuth验证方法

+ (void)OAuthAndCallback:(void(^)(NSError * error))callback {
    
    SLTumblrAuthenticator * instance = [SLTumblrAuthenticator sharedSLTumblrAuthenticator];
    [instance requestTokenCallback:^(NSError *error) {
        [instance authorizeToken];
    }];
}


// request_token set_token
- (void)requestTokenCallback:(void(^)(NSError * error))handler {
    
    [SLTumblrTools isAssignedOAuthAPIKey];
    
    NSDictionary  * requestParameters = @{
                                          @"oauth_consumer_key" : [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerKey,
                                          @"oauth_consumer_secret" : [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerSecret
                                          };
    
    NSURL * URL = [NSURL URLWithString:@"https://www.tumblr.com/oauth/request_token"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[[SLTumblrTools queryBySortedKeysWithDictionary:requestParameters] stringByRemovingPercentEncoding] dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"iPhone AppleWebKit" forHTTPHeaderField:@"User-Agent"];
    NSString * authorization = [SLTumblrOAuth authorizationWithURLString:[URL absoluteString] HTTPMethod:request.HTTPMethod postDicts:nil authDicts:requestParameters];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    
    SLAuthenticatorCallback callback = ^(NSURLResponse *response, id responseObject, NSError *error){
        
        NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (statusCode/100 == 2) {
            NSDictionary * tokenDict = [SLTumblrTools  dictionaryByQueryString:responseObject];
            [SLTumblrSDK sharedSLTumblrSDK].OAuthToken = tokenDict[@"oauth_token"];
            [SLTumblrSDK sharedSLTumblrSDK].OAuthTokenSecret = tokenDict[@"oauth_token_secret"];
            handler(nil);
        } else {
            NSError * error = [NSError errorWithDomain:@" request_token failed " code:statusCode userInfo:nil];
            handler(error);
        }
    };
    [self setRequet:request forCallback:callback];
}



// authorize_token
- (void)authorizeToken {
        
    NSString * URLString = [NSString stringWithFormat:@"https://www.tumblr.com/oauth/authorize?oauth_token=%@", [SLTumblrSDK sharedSLTumblrSDK].OAuthToken];
    NSURL * URL = [NSURL URLWithString:URLString];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:URL];
    });
    
}

// access_token
+ (void)accessToken:(NSURL *)callbackURL callback:(void(^)(BOOL auth))callback {
    
    return [[SLTumblrAuthenticator sharedSLTumblrAuthenticator] accessToken:callbackURL callback:callback];;
}

- (void)accessToken:(NSURL *)callbackURL callback:(void(^)(BOOL auth))callback {
    
    if (![[callbackURL absoluteString] hasPrefix:@"sltumblr://OAuthSuccess"]) {
        callback(false);
        return;
    }
    
    NSDictionary * urlParameters = [SLTumblrTools dictionaryByQueryString:callbackURL.query];

    NSURL * URL = [NSURL URLWithString:@"https://www.tumblr.com/oauth/access_token"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSDictionary * requestParameters = @{
                                            @"oauth_verifier" : urlParameters[@"oauth_verifier"]
                                         };
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[SLTumblrTools queryBySortedKeysWithDictionary:requestParameters] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * authorization = [SLTumblrOAuth authorizationWithURLString:[URL absoluteString] HTTPMethod:request.HTTPMethod postDicts:nil authDicts:requestParameters];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (statusCode/100 == 2) {
            NSDictionary * tokenDict = [SLTumblrTools  dictionaryByQueryString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
            [SLTumblrSDK sharedSLTumblrSDK].OAuthToken = tokenDict[@"oauth_token"];
            [SLTumblrSDK sharedSLTumblrSDK].OAuthTokenSecret = tokenDict[@"oauth_token_secret"];
            [[SLTumblrSDK sharedSLTumblrSDK] userInfo:^(id result, NSError *error) {
                if (result == nil) {
                    callback(false);
                } else {                    
                    [SLTumblrSDK sharedSLTumblrSDK].blogName = result[@"user"][@"name"];
                    callback(true);
                }
            }];
        } else {
            callback(false);
        }
 
    }] resume];
}



#pragma mark - 发送请求


- (void)setRequet:(NSMutableURLRequest *)request forCallback:(SLAuthenticatorCallback)callback {
    
    NSURLSession * manager = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        callback(response, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], error);
    }];
    
    [dataTask resume];
}


#pragma mark AppDelegate

+ (void)loginAuthenticatorWithURL:(NSURL *)URL success:(void(^)())success {
    [SLTumblrAuthenticator accessToken:URL callback:^(BOOL auth) {
        if (auth) {
            success();
        } else {
            [SLTumblrAuthenticator OAuthAndCallback:^(NSError *error) {
                if (error != nil) {
                    NSLog(@"%@", error);
                }
            }];
        }
    }];
    
}

@end
