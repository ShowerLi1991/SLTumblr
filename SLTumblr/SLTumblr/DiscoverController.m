//
//  DiscoverController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/9/17.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DiscoverController.h"
#import "GeometricParameters.h"

@interface DiscoverController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField * textField;
@property (strong, nonatomic) UIButton * maskView;

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:74/255.0 green:192/255.0 blue:226/255.0 alpha:1];
    
    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(7, 1, k_cell_width, 27)];
    tf.placeholder = @"🔍 Search";
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.textAlignment = NSTextAlignmentCenter;
    tf.backgroundColor = [UIColor whiteColor];
    tf.returnKeyType = UIReturnKeySearch;
    
    
    self.navigationItem.titleView = tf;
    tf.delegate = self;
    
    
    self.textField = tf;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    UIButton * maskView = [[UIButton alloc] initWithFrame:self.view.frame];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    [maskView addTarget:self action:@selector(maskViewTouchEndEditing) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:maskView];
    return true;
}

- (void)maskViewTouchEndEditing {
    [self.textField resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.maskView != nil) {
        [self.maskView removeFromSuperview];
    }
    return true;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSLog(@"ReturnClick");
    return true;
}



@end
