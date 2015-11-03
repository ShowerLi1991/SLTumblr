//
//  KindCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "KindCell.h"
#import "SLTumblrSDK.h"
#import "GeometricParameters.h"
#import "UIButton+AFNetworking.h"
#import "BlogController.h"
#import "InfoView.h"
#import "BarView.h"
#import "PostsModel.h"
#import "SourceTagsView.h"

@interface KindCell ()

@property (copy, nonatomic) NSString * kind;

@end

@implementation KindCell

- (instancetype)initWithKind:(NSString *)kind type:(NSString *)type {
    self = [super initWithType:type];
    if (self != nil) {
        _kind = kind;
        
        if ([_kind isEqualToString:@"dashPosts"]) {
            self.infoView.infoType = InfoViewTypeDashboard;
            self.infoView.InfoViewHeightConstraint.constant = 64;
            self.infoView.iconView.hidden = false;
            [self.infoView.iconView addTarget:self action:@selector(iconViewClick) forControlEvents:UIControlEventTouchUpInside];
            self.infoView.nameButton.hidden = false;
            [self.infoView.nameButton addTarget:self action:@selector(nameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            self.infoView.followButton.hidden = false;
            [self.infoView.followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.infoView.reblogNameButton addTarget:self action:@selector(reblogNameButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if ([_kind isEqualToString:@"blogPosts"]) {
            self.infoView.infoType = InfoViewTypeBlogPosts;
            self.infoView.InfoViewHeightConstraint.constant = 8;
            
        }
        
        [self.barView.likedButton addTarget:self action:@selector(likedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


- (void)setDataModel:(PostsModel *)dataModel {
    [super setDataModel:dataModel];
    
    // info
    if ([_kind isEqualToString:@"dashPosts"]) {
        [self.infoView.nameButton setTitle:dataModel.name forState:UIControlStateNormal];
        [self.infoView.iconView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:dataModel.icon]];
    }
    
    if (dataModel.reblog_name != nil) {
        [self.infoView.reblogNameButton setTitle:dataModel.reblog_name forState:UIControlStateNormal];
    }
    self.infoView.reblogNameButton.hidden = false;
    if (dataModel.is_root_item) {
        self.infoView.reblogNameButton.hidden = true;
    }
    
    if (dataModel.isFollowed) {
        self.infoView.followButton.selected = true; // Dashboard默认allFollow
    } else {
        self.infoView.followButton.selected = false;
    }
    
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
    BlogController * blog = [BlogController blogControllerWithBlogName:btn.currentTitle];
    blog.navigationItem.title = btn.currentTitle;
    
    UIResponder * responder = self.nextResponder;
    while (1) {
        responder = responder.nextResponder;
        if ([responder isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    UIViewController * vc = (UIViewController *)responder;
    
    [vc.navigationController pushViewController:blog animated:true];

}

- (void)iconViewClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[[SLTumblrSDK sharedSLTumblrSDK] avatarURLStringWithBlogName:self.infoView.nameButton.currentTitle size:512] stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"]]];
}

- (void)reblogNameButtonClick {
    NSLog(@"%@", self.nextResponder);
}

- (void)followButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [[SLTumblrSDK sharedSLTumblrSDK] follow:self.dataModel.name callback:^(id result, NSError *error) {
            if ([result[@"blog"][@"name"] isEqualToString:self.dataModel.name]) {
                self.dataModel.followed = button.selected;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"dashboardControllerRefresh" object:nil];
            } else {
                button.selected = !button.selected;
                self.dataModel.followed = button.selected;
            }
        }];
    } else {
        [[SLTumblrSDK sharedSLTumblrSDK] unfollow:self.dataModel.name callback:^(id result, NSError *error) {
            if ([result[@"blog"][@"name"] isEqualToString:self.dataModel.name]) {
                self.dataModel.followed = button.selected;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"dashboardControllerRefresh" object:nil];
            } else {
                button.selected = !button.selected;
                self.dataModel.followed = button.selected;
            }
        }];
    }
}

- (void)likedButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [[SLTumblrSDK sharedSLTumblrSDK] like:self.dataModel.id reblogKey:self.dataModel.reblog_key callback:^(id result, NSError *error) {
            if ([result isKindOfClass:[NSArray class]]) {
                self.dataModel.liked = button.selected;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"likesControllerRefresh" object:nil];
            } else {    // NSDictionary failed class
                button.selected = !button.selected;
                self.dataModel.liked = button.selected;
            }
        }];
    } else {
        [[SLTumblrSDK sharedSLTumblrSDK] unlike:self.dataModel.id reblogKey:self.dataModel.reblog_key callback:^(id result, NSError *error) {
            if ([result isKindOfClass:[NSArray class]]) {
                self.dataModel.liked = button.selected;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"likesControllerRefresh" object:nil];
            } else {    // NSDictionary failed class
                button.selected = !button.selected;
                self.dataModel.liked = button.selected;
            }
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([_kind isEqualToString:@"blogPosts"]) {
        if (self.infoView.reblogNameButton.hidden) {
            self.infoView.InfoViewHeightConstraint.constant = 8;
        } else {
            self.infoView.InfoViewHeightConstraint.constant = 38;
        }
    }
}


@end
