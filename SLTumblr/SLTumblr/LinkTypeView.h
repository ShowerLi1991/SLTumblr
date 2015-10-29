//
//  LinkTypeView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/25.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkTypeView : UIView

@property (strong, nonatomic) UILabel * publisherLabel;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * excerptLabel;
@property (strong, nonatomic) UILabel * descriptionLabel;
@property (copy, nonatomic) NSString * url;

@end
