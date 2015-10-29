//
//  VideoTypeView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/10.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface VideoTypeView : UIView

@property (copy, nonatomic) NSString * video_url;
@property (copy, nonatomic) NSNumber * thumbnail_height;
@property (strong, nonatomic) UIImageView * thumbnailView;
@property (strong, nonatomic) UILabel * captionLabel;
@property (strong, nonatomic) Embed * embed;

@end
