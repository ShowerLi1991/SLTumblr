//
//  DashboardCell.m
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashboardCell.h"
#import "GeometricParameters.h"
#import "UIButton+AFNetworking.h"
#import "SLTumblrSDK.h"



@implementation DashboardCell

- (instancetype)initWithType:(NSString *)type {
    self = [super initWithType:type];
    if (self != nil) {

        self.infoView.infoType = InfoViewTypeDashboard;
        self.infoView.InfoViewHeightConstraint.constant = 64;
        self.infoView.iconView.hidden = false;
        [self.infoView.iconView addTarget:self action:@selector(iconViewClick) forControlEvents:UIControlEventTouchUpInside];
        self.infoView.nameButton.hidden = false;
        [self.infoView.nameButton addTarget:self action:@selector(nameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.infoView.followButton.hidden = false;
        [self.infoView.reblogNameButton addTarget:self action:@selector(reblogNameButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.infoView.followButton addTarget:self action:@selector(followButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setDataModel:(PostsModel *)dataModel {

    // info
    [self.infoView.nameButton setTitle:dataModel.name forState:UIControlStateNormal];
    [self.infoView.iconView setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:dataModel.icon]];
    if (dataModel.reblog_name != nil) {
        [self.infoView.reblogNameButton setTitle:dataModel.reblog_name forState:UIControlStateNormal];
    }
    self.infoView.reblogNameButton.hidden = false;
    if (dataModel.is_root_item) {
        self.infoView.reblogNameButton.hidden = true;
    }
    self.infoView.followButton.hidden = true; // Dashboard默认allFollow
    
    // main
    if (dataModel.source_title.length > 0 && dataModel.source_url.length > 0) {
        self.sourceTagsView.exsitSource = true;
//        NSString * sourceHtmlString = self.sourceTagsView.sourceLabel.text = [NSString stringWithFormat:@"source:&nbsp;<a href=\"%@\">%@</a>", [dataModel.source_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]], dataModel.source_title];
//        self.sourceTagsView.sourceLabel.text = sourceHtmlString;

        self.sourceTagsView.sourceLabel.text = [NSString stringWithFormat:@"source: %@", dataModel.source_title];
    } else {
        self.sourceTagsView.exsitSource = false;
    }
    
    if (dataModel.tags.count > 0) {
        self.sourceTagsView.exsitTags = true;
        NSMutableArray * tagsM = [NSMutableArray array];
        for (NSString * tag in dataModel.tags) {
//            [tagsM addObject:[NSString stringWithFormat:@"<a class=\\\"tumblr_blog_tag\\\" href=\\\"%@\">#%@</a>", @"http://tag_test_url", tag]];
            [tagsM addObject:[NSString stringWithFormat:@"#%@", tag]];
        }
        NSString * tagsHTMLString = [tagsM componentsJoinedByString:@", "];
        self.sourceTagsView.tagsLabel.text = tagsHTMLString;
    } else {
        self.sourceTagsView.exsitTags = false;
    }

    // bar
    [self.barView.noteButton setTitle:[NSString stringWithFormat:@"%@ NOTE", dataModel.note_count] forState:UIControlStateNormal];
    self.barView.likedButton.selected = false;
    if (dataModel.isLiked) {
        self.barView.likedButton.selected = true;
    }

    self.barView.barType = BarViewTypeOthers;
    if ([dataModel.name isEqualToString:[SLTumblrSDK sharedSLTumblrSDK].blogName]) {
        self.barView.barType = BarViewTypeMe;
    }
}



- (void)nameButtonClick:(UIButton *)btn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@.tumblr.com", btn.currentTitle]]];
}

- (void)iconViewClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[[SLTumblrSDK sharedSLTumblrSDK] avatarURLStringWithBlogName:self.infoView.nameButton.currentTitle size:512] stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"]]];
}

- (void)reblogNameButtonClick {
    NSLog(@"%@", self.nextResponder);
}

- (void)followButtonClick {
    NSLog(@"%@", self.nextResponder);
}

@end
