//
//  FollowingTableViewCell.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/2.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowModel.h"

@interface FollowingTableViewCell : UITableViewCell

@property (strong, nonatomic) FollowModel * model;
@property (strong, nonatomic) UIImageView * iconView;
@property (strong, nonatomic) UILabel * nameLabel;
@property (strong, nonatomic) UILabel * titleLabel;
@end
