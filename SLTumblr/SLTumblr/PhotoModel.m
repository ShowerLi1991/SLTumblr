//
//  PhotoModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "PhotoModel.h"
#import "GeometricParameters.h"


@implementation PhotoModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        self.caption = dict[@"caption"];
        self.photos = dict[@"photos"];  
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos {
    _photos = [self photosDidSelectedWithPhotos:photos];
}

- (NSArray *)photosDidSelectedWithPhotos:(NSArray *)photos {
    
    NSMutableArray * photosSelected = [NSMutableArray arrayWithCapacity:photos.count];
    
    for (NSInteger i = 0; i < photos.count; i++) {
        NSDictionary * photo = photos[i];
        
        Photos * photo_info = [[Photos alloc] init];
        
        NSDictionary * firstInfo = photo[@"alt_sizes"][0];
        if ([firstInfo[@"width"] integerValue] < k_cell_width * 2 + 1) {
            photo_info.url = firstInfo[@"url"];
            photo_info.height = @((NSInteger)([firstInfo[@"height"] integerValue] * k_cell_width / [firstInfo[@"width"] integerValue]));
            
        } else {
            NSDictionary * secondInfo = photo[@"alt_sizes"][1];
            photo_info.url = secondInfo[@"url"];
            photo_info.height = @((NSInteger)([secondInfo[@"height"] integerValue] * k_cell_width / [secondInfo[@"width"] integerValue]));
        }
        
        photo_info.minimun_url = [photo[@"alt_sizes"] lastObject][@"url"];
        photo_info.original_url = photo[@"original_size"][@"url"];
        
        [photosSelected addObject:photo_info];
    }
    
    return photosSelected.copy;
}

@end

@implementation Photos
@end



