//
//  MainView.m
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "MainView.h"
#import "GeometricParameters.h"

#import "TextTypeView.h"
#import "PhotoTypeView.h"
#import "QuoteTypeView.h"
#import "LinkTypeView.h"
#import "ChatTypeView.h"
#import "AudioTypeView.h"
#import "VideoTypeView.h"
#import "AnswerTypeView.h"



@implementation MainView

- (instancetype)initWithType:(NSString *)type {
    self = [super initWithFrame:CGRectZero];
    if (self != nil) {

        UIView * typeView;
        if ([type isEqualToString:@"text"]) {
            TextTypeView * textView = [[TextTypeView alloc] init];
            textView.tag = 100000;
            typeView = textView;
        } else if ([type isEqualToString:@"photo"]) {
            PhotoTypeView * photoView = [[PhotoTypeView alloc] init];
            photoView.tag = 100001;
            typeView = photoView;
        } else if ([type isEqualToString:@"quote"]) {
            QuoteTypeView * quoteView = [[QuoteTypeView alloc] init];
            quoteView.tag = 100002;
            typeView = quoteView;
        } else if ([type isEqualToString:@"link"]) {
            LinkTypeView * linkView = [[LinkTypeView alloc] init];
            linkView.tag = 100003;
            typeView = linkView;
        } else if ([type isEqualToString:@"chat"]) {
            ChatTypeView * chatView = [[ChatTypeView alloc] init];
            chatView.tag = 100004;
            typeView = chatView;
        } else if ([type isEqualToString:@"audio"]) {
            AudioTypeView * audioView = [[AudioTypeView alloc] init];
            audioView.tag = 100005;
            typeView = audioView;
        } else if ([type isEqualToString:@"video"]) {
            VideoTypeView * videoView = [[VideoTypeView alloc] init];
            videoView.tag = 100006;
            typeView = videoView;
        } else if ([type isEqualToString:@"answer"]) {
            AnswerTypeView * answerView = [[AnswerTypeView alloc] init];
            answerView.tag = 100007;
            typeView = answerView;
        }
                
        [self addSubview:typeView];
        typeView.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[typeView]-0-|" options:0 metrics:nil views:@{@"typeView" : typeView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[typeView]-0-|" options:0 metrics:nil views:@{@"typeView" : typeView}]];
    }
    return self;
}







@end
