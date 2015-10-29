//
//  ChatViewDialogueCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/26.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "ChatViewDialogueCell.h"

@implementation ChatViewDialogueCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.lineLabel = [[UILabel alloc] init];
        [self addSubview:self.lineLabel];
        self.lineLabel.numberOfLines = 0;
        self.lineLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
