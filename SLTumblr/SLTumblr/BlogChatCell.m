//
//  BlogChatCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogChatCell.h"
#import "ChatModel.h"
#import "ChatTypeView.h"
#import "MainView.h"

@implementation BlogChatCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithKind:@"blogPosts" type:@"chat"];
    if (self) {
    }
    return self;
}

- (void)setDataModel:(ChatModel *)dataModel {
    [super setDataModel:dataModel];
    
    
    // type chat
    ChatTypeView * chatView = (ChatTypeView *)[self.mainView viewWithTag:100004];
    chatView.dialogue = dataModel.dialogue;
}

@end