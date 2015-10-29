//
//  BaseCell.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/24.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoView.h"
#import "MainView.h"
#import "BarView.h"
#import "SourceTagsView.h"

#import "PostsModel.h"

@interface BaseCell : UICollectionViewCell

@property (strong, nonatomic) id dataModel;
@property (strong, nonatomic) InfoView * infoView;
@property (strong, nonatomic) MainView * mainView;
@property (strong, nonatomic) SourceTagsView * sourceTagsView;
@property (strong, nonatomic) BarView * barView;

- (instancetype)initWithType:(NSString *)type;
- (void)setDataModel:(PostsModel *)dataModel;



@end
