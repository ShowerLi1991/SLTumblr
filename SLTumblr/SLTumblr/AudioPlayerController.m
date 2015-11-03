//
//  AudioPlayerController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/28.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "AudioPlayerController.h"
#import "GeometricParameters.h"
#import "AudioModel.h"

@interface AudioPlayerController ()

@property (strong, nonatomic) UIToolbar * backBar;

@end

@implementation AudioPlayerController

+ (instancetype)sharedAudioPlayerController {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _audioPlayerView = [[AudioPlayerView alloc] init];
    [self.view addSubview:_audioPlayerView];
    _audioPlayerView.scrollView.bounces = false;
    _audioPlayerView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_audioPlayerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_audioPlayerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    _audioPlayerView.widthCons = [NSLayoutConstraint constraintWithItem:_audioPlayerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    [_audioPlayerView addConstraint:_audioPlayerView.widthCons];
    
    _audioPlayerView.heightCons = [NSLayoutConstraint constraintWithItem:_audioPlayerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    [_audioPlayerView addConstraint:_audioPlayerView.heightCons];
    
    
    _backBar = [[UIToolbar alloc] init];
    [self.view addSubview:_backBar];
    _backBar.tintColor = [UIColor blackColor];
    _backBar.barTintColor = [UIColor blackColor];
    _backBar.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backBar]-0-|" options:0 metrics:nil views:@{@"backBar" : _backBar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backBar(49)]-20-|" options:0 metrics:nil views:@{@"backBar" : _backBar}]];
    
    UIBarButtonItem * spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemStop target:self action:@selector(dismissViewController)];
    backButton.tintColor = [UIColor whiteColor];
    [_backBar setItems:@[spaceButton, backButton]];
    _backBar.hidden = true;
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.backBar.hidden = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            onceToken = !onceToken;
            self.backBar.hidden = true;
        });
    });
}

- (NSMutableDictionary *)playingScr {
    if (_playingScr == nil) {
        _playingScr = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return _playingScr;
}

- (NSMutableDictionary *)playModel {
    if (_playModel == nil) {
        _playModel = [NSMutableDictionary dictionary];
    }
    return _playModel;
}

- (void)startPlayingWithEmbed:(Embed *)embed {

    [self.audioPlayerView stopLoading];
    self.audioPlayerView.embed = embed;
}

- (void)stopPlaying {
    
    ((AudioModel *)self.playModel[@"playing"]).playing = false;
    
    [self.audioPlayerView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
}



@end
