//
//  BaseButton.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/24.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButton : UIButton

@property (strong, nonatomic) NSLayoutConstraint * xCons;
@property (strong, nonatomic) NSLayoutConstraint * yCons;
@property (strong, nonatomic) NSLayoutConstraint * widthCons;
@property (strong, nonatomic) NSLayoutConstraint * heightCons;

@end
