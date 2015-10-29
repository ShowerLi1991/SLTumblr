//
//  QuoteModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "QuoteModel.h"

@implementation QuoteModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        self.source = dict[@"source"];
        self.text = dict[@"text"];
    }
    return self;
}
@end
