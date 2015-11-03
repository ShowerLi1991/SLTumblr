//
//  BlogController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/11/1.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "BlogController.h"
#import "SLTumblrSDK.h"
#import "BaseCell.h"
#import "BlogInfoHeaderView.h"
#import "GeometricParameters.h"
#import "BlogInfo.h"
#import "InfoView.h"


@interface BlogController ()

@property (copy, nonatomic) NSString * name;

@end

@implementation BlogController


+ (instancetype)blogControllerWithBlogName:(NSString *)name {
    BlogController * blog = [[BlogController alloc] init];
    blog.name = name;
    return blog;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[BlogInfoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"blogInfoHeader"];

    [self loadDataAndReload:true completionHandler:nil];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell * cell = (BaseCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.infoView.followButton.hidden = true;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BlogInfoHeaderView * infoHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"blogInfoHeader" forIndexPath:indexPath];
    
    [infoHeader setDataModel:self.blogInfo];
    
    return infoHeader;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(k_cell_width, 225);
}



- (void)startRefreshingNew:(UIRefreshControl *)refresh {
    [self loadDataAndReload:true completionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [refresh endRefreshing];
        });
    }];
}

- (void)startRefreshingOld:(UIRefreshControl *)refresh {
    [self addDataAndReload:true completionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [refresh endRefreshing];
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startReload:true];
}


- (void)loadDataAndReload:(BOOL)reload completionHandler:(void(^)())handler {
    [[SLTumblrSDK sharedSLTumblrSDK] blogPosts:_name parameters:@{ @"limit" : @20, @"offset" : @0 } type:nil callback:^(id result, NSError *error) {
        
        [self.result removeAllObjects];
        [self.result addObjectsFromArray:result[@"posts"]];
        
        self.blogInfo = [BlogInfo blogInfoWithDict:result[@"blog"]];
        
        if (result[@"blog"]!= nil) {
            [self startReload:reload];
        }
        if (handler != nil) {
            handler();
        }
    }];
}


- (void)addDataAndReload:(BOOL)reload completionHandler:(void(^)())handler {
    
    [[SLTumblrSDK sharedSLTumblrSDK] blogPosts:_name parameters:@{ @"limit" : @20, @"offset" : @(self.result.count) } type:nil callback:^(id result, NSError *error) {
        
        [self.result addObjectsFromArray:result[@"posts"]];
        if (result[@"blog"]!= nil) {
            [self startReload:reload];
        }
        if (handler != nil) {
            handler();
        }
    }];
}

- (void)startReload:(BOOL)reload {
    if (reload) {
        self.postsModels = nil;
        [self.collectionView reloadData];
    }
}



@end
