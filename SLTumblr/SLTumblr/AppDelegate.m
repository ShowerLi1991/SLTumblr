//
//  AppDelegate.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/9/14.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "AppDelegate.h"
#import "SLTumblrAuthenticator.h"
#import "SLTumblrSDK.h"
#import "UserAccount.h"
#import "TabBarController.h"
#import "RootViewController.h"
#import "SLTumblrTools.h"




@interface AppDelegate ()

@property (strong, nonatomic) UIImageView * maskView;

@property (strong, nonatomic) UIManagedDocument * document;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[RootViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    self.maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SLTumblr"]];
    self.maskView.frame = self.window.frame;
    [self.window addSubview:self.maskView];
    
    
    [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerKey = @"gg6d85qxU4RDbrfejaCCcnijDusAuBdk1xDpiItzZtcxj8V39W";
    [SLTumblrSDK sharedSLTumblrSDK].OAuthConsumerSecret = @"tgaxrUpXflN2My6rb9LbBVEIbQreEbSnXMZe5gawiV7nPdaG9N";

    [self authenticator];
    return YES;
}

- (void)authenticator {
#pragma mark - load 3参数
    [self existCoreDataFile:^(BOOL success) {
        if (success) {
            NSLog(@"打开或新建database成功");
            [self loadAccountParemeter];
            
            if ([SLTumblrSDK sharedSLTumblrSDK].blogName != nil) {
                [[SLTumblrSDK sharedSLTumblrSDK] userInfo:^(id result, NSError *error) {
                    if ([[SLTumblrSDK sharedSLTumblrSDK].blogName isEqualToString:result[@"user"][@"name"]]) {
                        [self goToTabBarController];
                    } else {
                        [SLTumblrAuthenticator loginAuthenticatorWithURL:nil success:nil];
                    }
                }];
            } else {
                [SLTumblrAuthenticator loginAuthenticatorWithURL:nil success:nil];
            }
        }
    }];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    [SLTumblrAuthenticator loginAuthenticatorWithURL:url success:^{
        // 验证成功
#pragma mark - save 3参数
        [self existCoreDataFile:^(BOOL success) {
            if (success) {
                [self saveAccountParemeters];
            }
        }];
        
        // 跳转界面
        [self goToTabBarController];
    }];
    
    return true;
}

- (void)goToTabBarController {
    TabBarController * tabBarController = [[TabBarController alloc] init];
    tabBarController.view.alpha = 0;
    self.window.rootViewController = tabBarController;
    [self.window bringSubviewToFront:self.maskView];
    
    [UIView animateWithDuration:3.0 delay:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.maskView.alpha = 0;
        tabBarController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
}


- (UIManagedDocument *)document {
    if (_document == nil) {
        NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
        NSString * path = [NSString stringWithFormat:@"file://%@", [docPath stringByAppendingPathComponent:@"UserAccount"]];
        NSURL * url = [NSURL URLWithString:path];
        _document = [[UIManagedDocument alloc] initWithFileURL:url];
    }
    return _document;
}

- (void)existCoreDataFile:(void(^)(BOOL success))completionHandler {
    BOOL existFile = [[NSFileManager defaultManager] fileExistsAtPath:self.document.fileURL.path];
    if (existFile) {
        [self.document openWithCompletionHandler:completionHandler];
    } else {
        [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:completionHandler];
    }
}

- (void)saveAccountParemeters {
    NSManagedObjectContext * context = self.document.managedObjectContext;
    UserAccount * account = [NSEntityDescription insertNewObjectForEntityForName:@"UserAccount" inManagedObjectContext:context];
    account.oauth_token = [SLTumblrSDK sharedSLTumblrSDK].OAuthToken;
    account.oauth_token_secret = [SLTumblrSDK sharedSLTumblrSDK].OAuthTokenSecret;
    account.user_blogname = [SLTumblrSDK sharedSLTumblrSDK].blogName;
}

- (void)loadAccountParemeter {
    NSManagedObjectContext * context = self.document.managedObjectContext;
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserAccount"];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"%@", error);
        return;
    }
    
    UserAccount * lastOne = [fetchedObjects lastObject];
    [SLTumblrSDK sharedSLTumblrSDK].OAuthToken = lastOne.oauth_token;
    [SLTumblrSDK sharedSLTumblrSDK].OAuthTokenSecret = lastOne.oauth_token_secret;
    [SLTumblrSDK sharedSLTumblrSDK].blogName = lastOne.user_blogname;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"失去活跃");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"进入后台");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}












#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.52772577.SLTumblr" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SLTumblr" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SLTumblr.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
