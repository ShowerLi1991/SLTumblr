//
//  PhotoModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"

@interface PhotoModel : PostsModel

@property (copy, nonatomic) NSArray * photos;
@property (copy, nonatomic) NSString * caption;

@end


@interface Photos : NSObject

@property (copy, nonatomic) NSString * url; // fitting
@property (copy, nonatomic) NSString * minimun_url; // 75*75
@property (copy, nonatomic) NSString * original_url;
@property (copy, nonatomic) NSNumber * height;

@end
