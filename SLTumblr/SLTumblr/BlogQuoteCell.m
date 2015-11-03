//
//  BlogQuoteCell.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogQuoteCell.h"
#import "QuoteTypeView.h"
#import "QuoteModel.h"

@implementation BlogQuoteCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithKind:@"blogPosts" type:@"quote"];
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