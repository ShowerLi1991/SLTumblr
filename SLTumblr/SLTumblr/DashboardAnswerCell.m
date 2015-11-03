//
//  DashboardAnswerCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/26.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashboardAnswerCell.h"
#import "AnswerModel.h"
#import "AnswerTypeView.h"
#import "SLTumblrSDK.h"
#import "UIImageView+WebCache.h"
#import "GeometricParameters.h"


@implementation DashboardAnswerCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithKind:@"dashPosts" type:@"answer"];
    if (self) {
    }
    return self;
}

- (void)setDataModel:(AnswerModel *)dataModel {
    [super setDataModel:dataModel];
    
    
    // type quote
    AnswerTypeView * answerView = (AnswerTypeView *)[self.mainView viewWithTag:100007];
    [answerView.askerButton setTitle:dataModel.asking_name forState:UIControlStateNormal];
    if (dataModel.asking_url.length > 0) {
        answerView.askerButtonLeadingCons.constant = 2 * k_margin_width + 32;
        NSString * iconURLString = [[SLTumblrSDK sharedSLTumblrSDK] avatarURLStringWithBlogName:[self blogNameWithBlogURLString:dataModel.asking_url] size:64];
        [answerView.icon_small sd_setImageWithURL:[NSURL URLWithString:iconURLString]];
    } else {
        answerView.icon_small.image = nil;
        answerView.askerButtonLeadingCons.constant = k_margin_width;
    }
    answerView.questionLabel.text = dataModel.question;
    answerView.answerLabel.text = dataModel.answer;
}

- (NSString *)blogNameWithBlogURLString:(NSString *)url {
    return [[[[url componentsSeparatedByString:@"://"] lastObject] componentsSeparatedByString:@"."] firstObject];
}

@end
