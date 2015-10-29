//
//  ReblogNameButton.m
//  SLTMCellTest
//
//  Created by SL🐰鱼子酱 on 15/9/23.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "ReblogNameButton.h"
#import "InfoView.h"

@implementation ReblogNameButton

- (void)setHidden:(BOOL)hidden {
    if (self.hidden != hidden) {
        [super setHidden:hidden];
        if ([self.nextResponder isKindOfClass:[InfoView class]]) {
            InfoView * respView = (InfoView *)self.nextResponder;
            [respView setNeedsLayout];
        }
    }
}

@end
