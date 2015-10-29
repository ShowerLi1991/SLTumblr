//
//  PhotoTypeView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/10.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTypeView : UIView

// photo_url, count <= 10
@property (strong, nonatomic) NSArray * photos;
@property (strong, nonatomic) UILabel * captionLabel;

@end
