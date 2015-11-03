//
//  BlogColletionViewController.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogColletionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray * result;
@property (strong, nonatomic) NSArray * postsModels;

@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout * flowLayout;

// 刷新
- (void)startRefreshingNew:(UIRefreshControl *)refresh;
@end
