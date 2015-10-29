//
//  PostsModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/28.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostsModel : NSObject


// InfoView 显示信息
@property (copy, nonatomic) NSString * name;
@property (copy, nonatomic) NSString * icon;
@property (assign, nonatomic) BOOL is_root_item;    //? 是原创blog
@property (copy, nonatomic) NSString * reblog_name; // 目前无法实现
@property (assign, nonatomic, getter=isFollowed) BOOL followed;


// MainView显示信息
#warning 根据类型不同这里返回的信息不同
@property (copy, nonatomic) NSString * context_text;
@property (copy, nonatomic) NSString * reblog_text;
@property (copy, nonatomic) NSString * source_title;
@property (copy, nonatomic) NSString * source_url;
@property (copy, nonatomic) NSArray * tags;


// BarView显示信息
@property (copy, nonatomic) NSNumber * note_count;
@property (assign, nonatomic, getter=isLiked) BOOL liked;

// post基本信息
@property (copy, nonatomic) NSNumber * id;

@property (copy, nonatomic) NSString * type;
@property (copy, nonatomic) NSString * post_url;
@property (copy, nonatomic) NSString * short_url;   // 短链接

@property (copy, nonatomic) NSDate * date;
@property (copy, nonatomic) NSNumber * timestamp;
@property (copy, nonatomic) NSString * reblog_key;
@property (copy, nonatomic) NSString * state;

@property (copy, nonatomic) NSString * header_image;    // 暂时无法获取

#pragma mark - retuanArrayFromDict
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (NSArray *)modelsWithDict:(NSDictionary *)dict;
@end



@interface Embed : NSObject

@property (copy, nonatomic) NSString * scr;
@property (copy, nonatomic) NSNumber * height;
@property (copy, nonatomic) NSNumber * width;

@end
