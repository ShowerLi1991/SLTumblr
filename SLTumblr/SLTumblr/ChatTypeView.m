//
//  ChatTypeView.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/25.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "ChatTypeView.h"
#import "GeometricParameters.h"
#import "ChatModel.h"
#import "ChatViewDialogueCell.h"

@interface ChatTypeView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView * dialogueView;
@property (strong, nonatomic) NSLayoutConstraint * dialogueViewHeightCons;

@end

@implementation ChatTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        UITableView * dialogueView = [[UITableView alloc] init];
        [self addSubview:dialogueView];
        
        dialogueView.allowsSelection = false;
        dialogueView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.dialogueView = dialogueView;
        
        dialogueView.dataSource = self;
        dialogueView.delegate = self;
    
        dialogueView.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[dialogueView]-margin-|" options:0 metrics:@{@"margin" : @(k_margin_width)} views:@{@"dialogueView" : dialogueView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[dialogueView]-margin-|" options:0 metrics:@{@"margin" : @(k_margin_height)} views:@{@"dialogueView" : dialogueView}]];
        
        self.dialogueViewHeightCons = [NSLayoutConstraint constraintWithItem:self.dialogueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.1];
        [dialogueView addConstraint:self.dialogueViewHeightCons];
        
        [dialogueView registerClass:[ChatViewDialogueCell class] forCellReuseIdentifier:@"chatViewDialogueCell"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChatViewDialogueCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chatViewDialogueCell" forIndexPath:indexPath];
    
    if ((indexPath.row & 1) == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    Dialogue * dialogue = self.dialogue[indexPath.row];

    cell.lineLabel.text = dialogue.lineString;
    cell.lineLabel.frame = CGRectMake(0, 0, k_cell_width - k_margin_width * 2, dialogue.rowHeight + k_margin_height);
    
    return cell;
}

- (void)setDialogue:(NSArray *)dialogue {
    _dialogue = dialogue;
    [self.dialogueView reloadData];
    self.dialogueViewHeightCons.constant = self.dialogueView.contentSize.height;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Dialogue * dialogue = self.dialogue[indexPath.row];

    return dialogue.rowHeight + k_margin_height;
}

@end
