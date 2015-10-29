//
//  ChatModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "ChatModel.h"
#import "GeometricParameters.h"

@implementation ChatModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        self.title = dict[@"title"];
        self.body = dict[@"body"];
        self.dialogue = dict[@"dialogue"];
    }
    return self;
}

- (void)setDialogue:(NSArray *)dialogue {
    _dialogue = [self dialoguesDidSelectedWithDialogues:dialogue];
}

- (NSArray *)dialoguesDidSelectedWithDialogues:(NSArray *)dialogues {
    NSMutableArray * dialoguesSelected = [NSMutableArray arrayWithCapacity:dialogues.count];
    
    for (NSInteger i = 0; i < dialogues.count; i++) {
        NSDictionary * dialogue = dialogues[i];
        Dialogue * dialogue_content = [[Dialogue alloc] init];
        dialogue_content.label = dialogue[@"label"];
        dialogue_content.name = dialogue[@"name"];
        dialogue_content.phrase = dialogue[@"phrase"];
        
        
        NSMutableString * lineString = [NSMutableString string];
        if (dialogue_content.name.length > 0) {
            [lineString appendFormat:@"%@: ", dialogue_content.name];
        }
        [lineString appendString:dialogue_content.phrase];
        
        dialogue_content.lineString = lineString.copy;
        
        UIFont * font = [UIFont systemFontOfSize:17.0];
        CGRect rect = [dialogue_content.lineString boundingRectWithSize:CGSizeMake(k_cell_width - 2 * k_margin_width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes: @{ NSFontAttributeName : font} context:nil];
        dialogue_content.rowHeight = rect.size.height;
        
        [dialoguesSelected addObject:dialogue_content];
    }
    
    return dialoguesSelected.copy;
}

@end


@implementation Dialogue
@end