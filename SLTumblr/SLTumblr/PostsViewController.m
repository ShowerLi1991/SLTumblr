//
//  PostsViewController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/9/11.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PostsViewController.h"
#import "GeometricParameters.h"
#import "PostsModel.h"

#import "BaseCell.h"
#import "DashboardTextCell.h"
#import "DashboardPhotoCell.h"
#import "DashboardQuoteCell.h"
#import "DashboardLinkCell.h"
#import "DashboardChatCell.h"

#import "DashboardVideoCell.h"
#import "ChatModel.h"
#import "DashboardAudioCell.h"
#import "DashboardAnswerCell.h"
#import "AudioTypeView.h"


@interface PostsViewController ()


@end

@implementation PostsViewController

// 可以发布的类型: text, quote, link, video, audio, photo, chat
// 可以接受的类型: text, quote, link, video, audio, photo, chat, answer


- (void)loadView {
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];

    self.view = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
    
    self.collectionView = (UICollectionView *)self.view;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat estimatedWidth = k_cell_width;
    self.flowLayout.estimatedItemSize = CGSizeMake(estimatedWidth, 300);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    

    self.collectionView.backgroundColor = [UIColor colorWithRed:74/255.0 green:192/255.0 blue:226/255.0 alpha:1];
    self.collectionView.bounces = true;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[DashboardTextCell class] forCellWithReuseIdentifier:@"dashTextCell"];
    [self.collectionView registerClass:[DashboardPhotoCell class] forCellWithReuseIdentifier:@"dashPhotoCell"];
    [self.collectionView registerClass:[DashboardQuoteCell class] forCellWithReuseIdentifier:@"dashQuoteCell"];
    [self.collectionView registerClass:[DashboardLinkCell class] forCellWithReuseIdentifier:@"dashLinkCell"];
    [self.collectionView registerClass:[DashboardChatCell class] forCellWithReuseIdentifier:@"dashChatCell"];
    [self.collectionView registerClass:[DashboardAudioCell class] forCellWithReuseIdentifier:@"dashAudioCell"];
    [self.collectionView registerClass:[DashboardVideoCell class] forCellWithReuseIdentifier:@"dashVideoCell"];
    [self.collectionView registerClass:[DashboardAnswerCell class] forCellWithReuseIdentifier:@"dashAnswerCell"];

}



#pragma mark 模型数组懒加载
- (NSArray *)postsModels {
    if (_postsModels == nil) {
        if (self.result != nil) {
            _postsModels = [PostsModel modelsWithDict:self.result];
        }
    }
    return _postsModels;
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postsModels.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PostsModel * model = self.postsModels[indexPath.item];
    NSLog(@"indexpath.item = %li, id: %@, count = %li", indexPath.item, model.id, self.postsModels.count);
    
    NSLog(@"type = %@", model.type);
    
    BaseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"dash%@Cell", [model.type capitalizedString]] forIndexPath:indexPath];
    [cell setDataModel:model];
    
    return cell;
}


- (void)viewDidLayoutSubviews {
    [super viewWillLayoutSubviews];
}




#warning sizeCacheForCollectionViewCell

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
}
*/



#pragma mark 添加父类方法




// 下拉刷新
- (void)refreshPosts {
    NSLog(@"下拉刷新");
}

// 上拉显示更多
- (void)morePosts {
    NSLog(@"显示更多");
}

// 空数据点击
- (void)emtpyButtonClick {
    NSLog(@"点击了emptyButton");
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

