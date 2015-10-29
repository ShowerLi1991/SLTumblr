//
//  AudioPlayerView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/28.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "AudioPlayerView.h"

@implementation AudioPlayerView

- (void)setEmbed:(Embed *)embed {
    _embed = embed;
    self.widthCons.constant = [embed.width doubleValue];
    self.heightCons.constant = [embed.height doubleValue];
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:embed.scr]]];
}

@end
