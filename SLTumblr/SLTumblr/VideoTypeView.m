//
//  VideoTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/10.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "VideoTypeView.h"
#import "GeometricParameters.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "AudioPlayerController.h"

@interface VideoTypeView ()

@property (strong, nonatomic) UIButton * playButton;
@property (strong, nonatomic) NSLayoutConstraint * thumbnailHeightCons;

@end

@implementation VideoTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.thumbnailView = [[UIImageView alloc] init];
        [self addSubview:self.thumbnailView];
        self.thumbnailView.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.thumbnailView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[thumbnail]-0-|" options:0 metrics:nil views:@{@"thumbnail" : self.thumbnailView}]];
        
        self.thumbnailHeightCons = [NSLayoutConstraint constraintWithItem:self.thumbnailView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
        [self.thumbnailView addConstraint:self.thumbnailHeightCons];
        
        
        self.playButton = [[UIButton alloc] init];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"btn_video_play"] forState:UIControlStateNormal];
        [self addSubview:self.playButton];
        [self.playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.playButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [self.playButton addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
        [self.playButton addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.thumbnailView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.thumbnailView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        self.captionLabel = [[UILabel alloc] init];
        self.captionLabel.numberOfLines = 0;
        [self addSubview:self.captionLabel];
        
        self.captionLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[captionLabel]-margin-|" options:0 metrics:@{@"margin" : @(k_margin_width)} views:@{@"captionLabel" : self.captionLabel}]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.captionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.thumbnailView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:k_margin_height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.captionLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-k_margin_height]];
        
    }
    return self;
}

- (void)setThumbnail_height:(NSNumber *)thumbnail_height {
    _thumbnail_height = thumbnail_height;
    self.thumbnailHeightCons.constant = [thumbnail_height doubleValue];
}

- (void)playButtonClick {
    
    [[AudioPlayerController sharedAudioPlayerController] stopPlaying];
    
    
    UIResponder * responder = self.nextResponder;
    while (1) {
        responder = responder.nextResponder;
        if ([responder isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    UIViewController * vc = (UIViewController *)responder;
    
    if (self.embed == nil) {
        
        NSURL * url = [NSURL URLWithString:self.video_url];
        if (url != nil) {
            AVPlayer * player = [[AVPlayer alloc] initWithURL:url];
            AVPlayerViewController * playerViewController = [[AVPlayerViewController alloc] init];
            playerViewController.player = player;
            
            [vc presentViewController:playerViewController animated:false completion:^{
                [playerViewController.player play];
            }];
            
        }
        else {
            NSError * error = [NSError errorWithDomain:@"视频url未找到, 请使用player播放器" code:404 userInfo:nil];
            NSLog(@"%@", error);
        }
    } else {
        //embed
        
        AudioPlayerController * audioViewController = [AudioPlayerController sharedAudioPlayerController];;
        
        [audioViewController stopPlaying];
        
        [vc presentViewController:audioViewController animated:false completion:^{
            [audioViewController startPlayingWithEmbed:self.embed];
        }];
    }
    
    
}


@end
