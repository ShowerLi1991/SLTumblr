//
//  AudioModel.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsModel.h"


@interface AudioModel : PostsModel

@property (strong, nonatomic) Embed * embed; // HTML for embedding the audio player
@property (copy, nonatomic) NSNumber * plays; // 音乐播放次数
@property (copy, nonatomic) NSString * album_art;   // 艺术家图片url
@property (copy, nonatomic) NSString * artist; // 艺术家name
@property (copy, nonatomic) NSString * album; // 专辑
@property (copy, nonatomic) NSString * track_name;  // 曲目名称
@property (copy, nonatomic) NSNumber * track_number;    // 曲目数
@property (copy, nonatomic) NSNumber * year;    // 发行时间
@property (copy, nonatomic) NSString * caption;
@property (assign, nonatomic, getter = isPlaying) BOOL playing;

@end


