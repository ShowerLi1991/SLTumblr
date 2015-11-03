//
//  FollowModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FollowModel : NSObject

@property (copy, nonatomic) NSString * name;
@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * updated;
@property (copy, nonatomic) NSString * url;
@property (copy, nonatomic) NSString * blog_description;


// followers
@property (assign, nonatomic) BOOL following;

+ (NSArray *)followModelsWithArray:(NSArray *)result;

@end
