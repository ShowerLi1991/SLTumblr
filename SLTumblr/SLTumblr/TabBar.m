//
//  TabBar.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/9/6.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    int i = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width/5;
    CGFloat height = self.bounds.size.height - 1;
    for (UIControl * control in self.subviews) {
        if ([control isKindOfClass:[UIControl class]] && ![control isKindOfClass:[UIButton class]]) {
            control.frame = CGRectMake(i * width + 2, 1, width - 4, height);
            i += (i == 1 ? 2 : 1);
        }
    }
    self.writeButton.frame = CGRectMake(self.frame.size.width * 0.5 - (width - 15) * 0.5, -13, width - 15, height + 12);
    self.clipsToBounds = false;
}



- (UIButton *)writeButton {
    if (_writeButton == nil) {
        _writeButton = [[UIButton alloc] init];
        [_writeButton setImage:[UIImage imageNamed:@"btn_post_normal"] forState:UIControlStateNormal];
//        _writeButton.imageEdgeInsets = UIEdgeInsetsMake(-14, 5.5, 2, 5.5);
        
        _writeButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_writeButton];

    }
    return _writeButton;
}

@end
