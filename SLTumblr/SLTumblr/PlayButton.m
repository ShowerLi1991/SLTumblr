//
//  PlayButton.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/29.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PlayButton.h"

@implementation PlayButton

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath * path1 = [UIBezierPath bezierPathWithRect:CGRectMake(rect.size.width * 0.5, 0, rect.size.width * 0.5, rect.size.height)];
    [[UIColor groupTableViewBackgroundColor] setFill];
    [path1 fill];
    
    UIBezierPath * path2 = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:25];
    [[UIColor darkGrayColor] setFill];
    [path2 fill];
    
    

    [super drawRect:rect];
}

@end
