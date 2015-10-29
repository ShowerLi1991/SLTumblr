//
//  DashboardChatCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/25.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashboardChatCell.h"
#import "ChatModel.h"
#import "ChatTypeView.h"

@implementation DashboardChatCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithType:@"chat"];
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
