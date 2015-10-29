//
//  VideoModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"

@interface VideoModel : PostsModel

@property (copy, nonatomic) NSString * caption;
@property (copy, nonatomic) NSString * video_type;
@property (strong, nonatomic) Embed * embed; // 如果video_url 不存在  使用内嵌代码播放视频  HTML for embedding the audio player
@property (copy, nonatomic) NSString * video_url;
@property (copy, nonatomic) NSString * thumbnail_url;
@property (copy, nonatomic) NSNumber * thumbnail_height;

@end
