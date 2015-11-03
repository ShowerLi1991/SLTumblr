//
//  DashboardTextCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/22.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashboardTextCell.h"
#import "TextModel.h"
#import "TextTypeView.h"


@implementation DashboardTextCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithKind:@"dashPosts" type:@"text"];
    if (self != nil) {
    }
    return self;
}


- (void)setDataModel:(TextModel *)dataModel {
    [super setDataModel:dataModel];
    

    // type text
    TextTypeView * textView = (TextTypeView *)[self.mainView viewWithTag:100000];
    textView.titleLabel.text = dataModel.title;
    textView.bodyLabel.text = dataModel.body;

}

@end
