//
//  AnswerTypeView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/26.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerTypeView : UIView

@property (strong, nonatomic) UIImageView * icon_small;
@property (strong, nonatomic) NSLayoutConstraint * askerButtonLeadingCons;
@property (strong, nonatomic) UIButton * askerButton;
@property (strong, nonatomic) UILabel * questionLabel;
@property (strong, nonatomic) UILabel * answerLabel;


@end
