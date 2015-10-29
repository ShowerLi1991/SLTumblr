//
//  BarView.h
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BarViewType) {
    BarViewTypeOthers = 0,
    BarViewTypeMe = 1,
};

@interface BarView : UIView

@property (assign, nonatomic) BarViewType barType;

@property (strong, nonatomic) UIButton * noteButton;
@property (strong, nonatomic) UIButton * sharedButton;
@property (strong, nonatomic) UIButton * reblogButton;
@property (strong, nonatomic) UIButton * likedButton;
@property (strong, nonatomic) UIButton * operationButton;

@end
