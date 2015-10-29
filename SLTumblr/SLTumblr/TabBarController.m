//
//  TabBarController.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/8/22.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "TabBarController.h"
#import "DashboardController.h"
#import "LikesController.h"
#import "DiscoverController.h"
#import "ProfileController.h"
#import "TabBar.h"
#import "NavDashboardController.h"
#import "NavLikesController.h"
#import "NavDiscoverController.h"
#import "NavProfileController.h"

@interface TabBarController ()

@end

@implementation TabBarController



- (void)viewDidLoad {
    [super viewDidLoad];

    
    TabBar * myBar = [[TabBar alloc] init];
    [self setValue:myBar forKey:@"tabBar"];
    
    

    
    DashboardController * dashboard = [[DashboardController alloc] init];
    NavDashboardController * navDashboard = [[NavDashboardController alloc] initWithRootViewController:dashboard];
    dashboard.tabBarItem.title = @"Dashboard";
    dashboard.navigationItem.title = @"Dashboard";
    dashboard.tabBarItem.image = [[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dashboard.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    LikesController * likes = [[LikesController alloc] init];
    NavLikesController * navLikes = [[NavLikesController alloc] initWithRootViewController:likes];
    likes.tabBarItem.title = @"Likes";
    likes.navigationItem.title = @"Likes";
    likes.tabBarItem.image = [[UIImage imageNamed:@"tabbar_likes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    likes.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_likes_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [likes loadData];

    
    DiscoverController * discover = [[DiscoverController alloc] init];
    NavDiscoverController * navDiscover = [[NavDiscoverController alloc] initWithRootViewController:discover];
    discover.tabBarItem.title = @"Discover";
 
    
    discover.tabBarItem.image = [[UIImage imageNamed:@"tabbar_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discover.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    ProfileController * profile = [[ProfileController alloc] init];
    NavProfileController * navProfile = [[NavProfileController alloc] initWithRootViewController:profile];
    profile.tabBarItem.title = @"Profile";
    profile.navigationItem.title = @"Profile";
    profile.tabBarItem.image = [[UIImage imageNamed:@"tabbar_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profile.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];


    
    self.viewControllers = @[navDashboard, navLikes, navDiscover, navProfile];



}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}


@end
