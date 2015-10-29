//
//  InfoView.h
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReblogNameButton.h"
#import "BaseButton.h"


typedef NS_ENUM(NSInteger, InfoViewType) {
    InfoViewTypeDashboard = 0,
    InfoViewTypeBlogPosts,
};

@interface InfoView : UIView

@property (assign, nonatomic) InfoViewType infoType;
@property (strong, nonatomic) BaseButton * iconView;
@property (strong, nonatomic) BaseButton * nameButton;
@property (strong, nonatomic) ReblogNameButton * reblogNameButton;
@property (strong, nonatomic) BaseButton * followButton;

@property (strong, nonatomic) NSLayoutConstraint * InfoViewHeightConstraint;


@end
