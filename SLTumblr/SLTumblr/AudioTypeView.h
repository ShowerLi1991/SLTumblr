//
//  AudioTypeView.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/26.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioModel.h"
#import "TrackLabel.h"

@interface AudioTypeView : UIView

//@property (strong, nonatomic) UILabel * artistLabel;

@property (strong, nonatomic) AudioModel * audioModel;
@property (strong, nonatomic) TrackLabel * track_nameLabel;
@property (strong, nonatomic) UILabel * captionLabel;
@property (strong, nonatomic) Embed * embed;

@end
