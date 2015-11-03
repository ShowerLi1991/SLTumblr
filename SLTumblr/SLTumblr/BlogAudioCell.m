//
//  BlogAudioCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogAudioCell.h"
#import "AudioModel.h"
#import "AudioTypeView.h"

@implementation BlogAudioCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithKind:@"blogPosts" type:@"audio"];
    if (self) {
    }
    return self;
}

- (void)setDataModel:(AudioModel *)dataModel {
    [super setDataModel:dataModel];
    
    // type audio
    AudioTypeView * audioView = (AudioTypeView *)[self.mainView viewWithTag:100005];
    NSMutableString * trackInfo = [NSMutableString string];
    if (dataModel.track_name.length > 0) {
        [trackInfo appendString:dataModel.track_name];
    } else {
        [trackInfo appendString:@"听取"];
    }
    
    if (dataModel.artist.length > 0) {
        [trackInfo appendFormat:@"\n%@", dataModel.artist];
    }
    
    
    
    audioView.track_nameLabel.text = trackInfo.copy;
    audioView.embed = dataModel.embed;
    audioView.captionLabel.text = dataModel.caption;
    
    audioView.audioModel = dataModel;
    
}

@end