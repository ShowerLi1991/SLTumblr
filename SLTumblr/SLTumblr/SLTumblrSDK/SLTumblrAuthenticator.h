//
//  SLTumblrAuthenticator.h
//  SLTumblrSDK
//
//  Created by SL🐰鱼子酱 on 15/9/13.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SLTumblrAuthenticator : NSObject

+ (instancetype)sharedSLTumblrAuthenticator;

#pragma mark AppDelegate
+ (void)loginAuthenticatorWithURL:(NSURL *)URL success:(void(^)())success;


#pragma mark ----------------OAuth-------------------

+ (void)OAuthAndCallback:(void(^)(NSError * error))callback;

+ (void)accessToken:(NSURL *)callbackURL callback:(void(^)(BOOL auth))callback;





#pragma mark ----------------xAuth-------------------





@end
