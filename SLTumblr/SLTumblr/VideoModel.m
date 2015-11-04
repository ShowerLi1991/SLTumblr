//
//  VideoModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "VideoModel.h"
#import "GeometricParameters.h"

@interface VideoModel () <NSXMLParserDelegate>
@end

@implementation VideoModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        self.caption = dict[@"caption"];
        self.video_type = dict[@"video_type"];
        self.video_url = dict[@"video_url"];
        
        if ( self.video_url.length > 0 ) {
            self.thumbnail_url = dict[@"thumbnail_url"];
            self.thumbnail_height = @((NSInteger)([dict[@"thumbnail_height"] integerValue] * k_cell_width / [dict[@"thumbnail_width"] integerValue]));
        }
        else {
            [self parserWithEmbedArray:dict[@"player"]];
        }

    }
    return self;
}

- (Embed *)embed {
    if (_embed == nil) {
        _embed = [[Embed alloc] init];
    }
    return _embed;
}

- (void)parserWithEmbedArray:(NSArray *)player {
    NSData * embedStringData = [[player lastObject][@"embed_code"] dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser * parser = [[NSXMLParser alloc] initWithData:embedStringData];
    parser.delegate = self;
    [parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if (attributeDict != nil) {

        if ([attributeDict[@"src"] isKindOfClass:[NSString class]]) {
            self.embed.scr = attributeDict[@"src"];
        }
        if ([attributeDict[@"width"] isKindOfClass:[NSString class]]) {
            self.embed.width = @(k_sceen_width);
        }
        if ([attributeDict[@"height"] isKindOfClass:[NSString class]]) {
            self.embed.height = @([attributeDict[@"height"] doubleValue] * k_sceen_width / [attributeDict[@"width"] doubleValue]);
        }
    }
}


@end


