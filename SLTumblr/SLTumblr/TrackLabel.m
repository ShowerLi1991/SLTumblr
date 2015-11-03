//
//  TrackLabel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/29.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "TrackLabel.h"

@implementation TrackLabel

- (void)drawRect:(CGRect)rect {
    

    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width - 28, 25) radius:25 startAngle:M_PI_2 endAngle:M_PI_2 * 3 clockwise:false];
    [[UIColor groupTableViewBackgroundColor] setFill];
    [path1 fill];
    
    
    
    UIBezierPath * path2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, rect.size.width - 25, 50)];
    [[UIColor groupTableViewBackgroundColor] setFill];
    [path2 fill];

    
    [super drawRect:rect];
}

@end
