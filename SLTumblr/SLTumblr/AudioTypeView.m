//
//  AudioTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/26.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "AudioTypeView.h"
#import "AudioPlayerController.h"
#import "PlayButton.h"
#import "GeometricParameters.h"

@interface AudioTypeView ()

@property (strong, nonatomic) PlayButton * playButton;

@end

@implementation AudioTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
 
        
        self.playButton = [[PlayButton alloc] init];
        [self addSubview:self.playButton];
        
        [self.playButton setImage:[UIImage imageNamed:@"play_button_playing"] forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"play_button_stop"] forState:UIControlStateSelected];
        [self.playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];

        
        self.track_nameLabel = [[TrackLabel alloc] init];
        [self addSubview:self.track_nameLabel];
        self.track_nameLabel.font = [UIFont systemFontOfSize:15];
        self.track_nameLabel.textAlignment = NSTextAlignmentCenter;
        self.track_nameLabel.numberOfLines = 0;
        
        
        self.captionLabel = [[UILabel alloc] init];
        self.captionLabel.numberOfLines = 0;
        [self addSubview:self.captionLabel];
        
        self.playButton.translatesAutoresizingMaskIntoConstraints = false;
        self.track_nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.captionLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        // playButtonCons
        [self.playButton addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
        [self.playButton addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:k_margin_height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.playButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:k_margin_width]];

        

        
        // trackLabel Cons
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.track_nameLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.track_nameLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-k_margin_width]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.track_nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.track_nameLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        
        
        // captionLabe Cons
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.captionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:k_margin_height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.captionLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-k_margin_height]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[captionLabel]-margin-|" options:0 metrics:@{@"margin" : @(k_margin_width)} views:@{@"captionLabel" : self.captionLabel}]];
        
    }
    return self;
}


- (void)playButtonClick {
    
    AudioPlayerController * audioViewController = [AudioPlayerController sharedAudioPlayerController];;
    [audioViewController stopPlaying];
    
    
    
    if (self.playButton.isSelected) {
        self.playButton.selected = false;        
        self.audioModel.playing = false;
    } else {
        self.playButton.selected = true;
        self.audioModel.playing = true;
        UIResponder * responder = self.nextResponder;
        while (1) {
            responder = responder.nextResponder;
            if ([responder isKindOfClass:[UIViewController class]]) {
                break;
            }
        }
        UIViewController * vc = (UIViewController *)responder;
        
        
        audioViewController.playModel[@"playing"] = self.audioModel;
        [vc presentViewController:audioViewController animated:true completion:^{
            [audioViewController startPlayingWithEmbed:self.embed];
        }];
    }
}

- (void)setAudioModel:(AudioModel *)audioModel {
    _audioModel = audioModel;
    if (audioModel.playing) {
        self.playButton.selected = true;
    } else {
        self.playButton.selected = false;
    }
}



@end
