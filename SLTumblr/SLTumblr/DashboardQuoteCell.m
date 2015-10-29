//
//  DashboardQuoteCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/25.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashboardQuoteCell.h"
#import "QuoteTypeView.h"
#import "QuoteModel.h"

@implementation DashboardQuoteCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithType:@"quote"];
    if (self) {
    }
    return self;
}

- (void)setDataModel:(QuoteModel *)dataModel {
    [super setDataModel:dataModel];
    
    
    // type quote
    QuoteTypeView * quoteView = (QuoteTypeView *)[self.mainView viewWithTag:100002];
    quoteView.textLabel.text = dataModel.text;
    quoteView.sourceLabel.text = dataModel.source;
    
}

@end
