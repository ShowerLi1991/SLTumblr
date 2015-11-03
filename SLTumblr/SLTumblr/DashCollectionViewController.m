//
//  DashCollectionViewController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "DashCollectionViewController.h"
#import "GeometricParameters.h"
#import "PostsModel.h"

#import "BaseCell.h"
#import "DashboardTextCell.h"
#import "DashboardPhotoCell.h"
#import "DashboardQuoteCell.h"
#import "DashboardLinkCell.h"
#import "DashboardChatCell.h"
#import "DashboardAudioCell.h"
#import "DashboardVideoCell.h"
#import "DashboardAnswerCell.h"




@interface DashCollectionViewController ()

@property (strong, nonatomic) NSMutableDictionary * sizeCache;

@end

@implementation DashCollectionViewController

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
    self.flowLayout.estimatedItemSize = CGSizeMake(estimatedWidth, 450);
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
    
    
    [self setRefreshController];
    
}

- (void)setRefreshController {
    
    UIRefreshControl * refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(startRefreshingNew:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:refresh];
}

- (void)startRefreshingNew:(UIRefreshControl *)refresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refresh endRefreshing];
    });
}


- (NSMutableArray *)result {
    if (_result == nil) {
        _result = [NSMutableArray array];
    }
    return _result;
}

#pragma mark 模型数组懒加载
- (NSArray *)postsModels {
    if (_postsModels == nil) {
        if (self.result.count > 0) {
            _postsModels = [PostsModel modelsWithArray:self.result.copy];
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
    
    BaseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"dash%@Cell", [model.type capitalizedString]] forIndexPath:indexPath];
    [cell setDataModel:model];

    
    return cell;
}


- (void)viewDidLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (NSMutableDictionary *)sizeCache {
    if (_sizeCache == nil) {
        _sizeCache = [NSMutableDictionary dictionary];
    }
    return _sizeCache;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    PostsModel * model = self.postsModels[indexPath.item];
    self.sizeCache[[model.id stringValue]] = [NSValue valueWithCGSize:cell.bounds.size];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostsModel * model = self.postsModels[indexPath.item];
    NSValue * sizeV = [self.sizeCache objectForKey:[model.id stringValue]];
    if (sizeV != nil) {
        return [sizeV CGSizeValue];
    } else {

        return CGSizeMake(k_cell_width, 300);
    }

}



#pragma mark 添加父类方法



@end
