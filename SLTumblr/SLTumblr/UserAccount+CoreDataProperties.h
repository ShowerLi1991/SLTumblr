//
//  UserAccount+CoreDataProperties.h
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/9/21.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserAccount (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *oauth_token;
@property (nullable, nonatomic, retain) NSString *oauth_token_secret;
@property (nullable, nonatomic, retain) NSString *user_blogname;

@end

NS_ASSUME_NONNULL_END
