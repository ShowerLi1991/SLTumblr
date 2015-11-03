//
//  DashboardPhotoCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/11.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashboardPhotoCell.h"
#import "PhotoModel.h"
#import "PhotoTypeView.h"
#import "MainView.h"


@implementation DashboardPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithKind:@"dashPosts" type:@"photo"];
    if (self != nil) {
        
    }
    return self;
}

- (void)setDataModel:(PhotoModel *)dataModel {
    [super setDataModel:dataModel];
    
    
    // type photo
    PhotoTypeView * photoView = (PhotoTypeView *)[self.mainView viewWithTag:100001];
    photoView.photos = dataModel.photos;
    photoView.captionLabel.text = dataModel.caption;
    
}

@end
