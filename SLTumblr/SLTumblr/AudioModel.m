//
//  AudioModel.m
//  SLTumblr
//
//  Created by SL🐰鱼子酱 on 15/10/18.
//  Copyright © 2015年 SL🐰鱼子酱. All rights reserved.
//

#import "AudioModel.h"
#import "GeometricParameters.h"

@interface AudioModel () <NSXMLParserDelegate>
@end

@implementation AudioModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self != nil) {
        self.caption = dict[@"caption"];
        [self parserWithEmbedString:dict[@"embed"]];
        self.plays = dict[@"plays"];
        self.album_art = dict[@"album_art"];
        self.artist = dict[@"artist"];
        self.album = dict[@"album"];
        self.track_name = dict[@"track_name"];
        self.track_number = dict[@"track_number"];
        self.year = dict[@"year"];
    }
    return self;
}

- (Embed *)embed {
    if (_embed == nil) {
        _embed = [[Embed alloc] init];
    }
    return _embed;
}

- (void)parserWithEmbedString:(NSString *)embed {
    NSData * embedStringData = [embed dataUsingEncoding:NSUTF8StringEncoding];
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


