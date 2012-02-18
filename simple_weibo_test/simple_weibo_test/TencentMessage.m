//
//  TencentStatus.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-17.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "TencentMessage.h"
#import "StatusCell.h"

@implementation TencentMessage

@synthesize text,source,messageType,timestamp,headUrl,location,pictureUrl,nick,name,statusType,cellHeight;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(CGFloat)updateCellHeight
{
    BOOL hasImg;
    if(pictureUrl != [NSNull null]){
        hasImg = YES;
    }
    else{
        hasImg = NO;
    }
    cellHeight = [StatusCell calculateCellHeightWithText:text Source:source HasImage:hasImg];
    return cellHeight;
}

-(id)initWithJSONDict:(NSDictionary *)data
{
    self = [super init];
    if(self){
        self.text = [data objectForKey:@"text"];
        if([data objectForKey:@"source"]!=[NSNull null]){
            self.source = [[[TencentMessage alloc]initWithJSONDict:(NSDictionary *)[data objectForKey:@"source"]]autorelease];
        }
        else{
            source = [NSNull null];
        }
        self.headUrl = [data objectForKey:@"head"];
        self.location = [data objectForKey:@"location"];
        NSArray *pictures = [data objectForKey:@"image"];
        if((NSNull *)pictures != [NSNull null]){
            self.pictureUrl = [pictures objectAtIndex:0];//need one picture while server gives an array.
        }
        else{
            self.pictureUrl = [NSNull null];
        }
        self.nick = [data objectForKey:@"nick"];
        self.name = [data objectForKey:@"name"];
        NSNumber *_messageType = [data objectForKey:@"type"];
        self.messageType = [_messageType intValue];
        [self updateCellHeight];
    }
    return self;
}


- (void)dealloc {
    [text release];
    [source release];
    [timestamp release];
    [headUrl release];
    [location release];
    [pictureUrl release];
    [nick release];
    [name release];
    [super dealloc];
}

@end
