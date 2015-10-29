//
//  QuoteModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"

@interface QuoteModel : PostsModel

@property (copy, nonatomic) NSString * text;
@property (copy, nonatomic) NSString * source;

@end
