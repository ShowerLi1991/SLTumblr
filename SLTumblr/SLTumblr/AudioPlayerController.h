//
//  AudioPlayerController.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/28.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioTypeView.h"
#import "AudioPlayerView.h"

@interface AudioPlayerController : UIViewController

@property (strong, nonatomic) AudioPlayerView * audioPlayerView;
@property (strong, nonatomic) NSMutableDictionary * playingScr;


- (void)startPlayingWithEmbed:(Embed *)embed;
- (void)stopPlaying;
+ (instancetype)sharedAudioPlayerController;

@end
