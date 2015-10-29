//
//  AudioPlayerView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/28.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioTypeView.h"

@interface AudioPlayerView : UIWebView

@property (strong, nonatomic) NSLayoutConstraint * widthCons;
@property (strong, nonatomic) NSLayoutConstraint * heightCons;
@property (strong, nonatomic) Embed * embed;

@end
