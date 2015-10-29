//
//  PostsViewController.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/9/11.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) NSDictionary * result;
@property (strong, nonatomic) NSArray * postsModels;
@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout * flowLayout;
//@property (copy, nonatomic) NSString * tipString;


// 下拉刷新
- (void)refreshPosts;

// 上拉显示更多
- (void)morePosts;

// 空数据点击
- (void)emtpyButtonClick;

@end

