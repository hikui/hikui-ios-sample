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

@synthesize text,source,messageType,timestamp,headUrl,location,pictureUrl,nick,name,statusType,cellHeight,textHeight,subTextHeight;

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
    [StatusCell updateMyTextHeightAndSubTextHeightAndCellHeight:self];
    return cellHeight;
}

-(id)initWithJSONDict:(NSDictionary *)data
{
    self = [super init];
    if(self){
        self.text = [data objectForKey:@"text"];
        if([data objectForKey:@"source"]!=[NSNull null] && [data objectForKey:@"source"]!=nil){
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

#pragma mark - 持久化
- (void)encodeWithCoder:(NSCoder *)coder
{
    //NSLog(@"encodewithcoder");
    [coder encodeObject:text forKey:@"text"];
    [coder encodeObject:source forKey:@"source"];
    [coder encodeObject:timestamp forKey:@"timestamp"];
    [coder encodeInt:messageType forKey:@"messagetype"];
    [coder encodeObject:headUrl forKey:@"headurl"];
    [coder encodeObject:location forKey:@"location"];
    [coder encodeObject:pictureUrl forKey:@"pictureurl"];
    [coder encodeObject:nick forKey:@"nick"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeInt:statusType forKey:@"statustype"];
    [coder encodeFloat:cellHeight forKey:@"cellheight"];
    [coder encodeFloat:textHeight forKey:@"textheight"];
    [coder encodeFloat:subTextHeight forKey:@"subtextheight"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if(self=[super init]){
        //NSLog(@"init with coder");
        text = [[coder decodeObjectForKey:@"text"]retain];
        source = [[coder decodeObjectForKey:@"source"]retain];
        timestamp = [[coder decodeObjectForKey:@"timestamp"]retain];
        messageType = [coder decodeIntForKey:@"messagetype"];
        headUrl = [[coder decodeObjectForKey:@"headurl"]retain];
        location = [[coder decodeObjectForKey:@"location"]retain];
        pictureUrl = [[coder decodeObjectForKey:@"pictureurl"]retain];
        nick = [[coder decodeObjectForKey:@"nick"]retain];
        name = [[coder decodeObjectForKey:@"name"]retain];
        statusType = [coder decodeIntForKey:@"statustype"];
        cellHeight = [coder decodeFloatForKey:@"cellheight"];
        textHeight = [coder decodeFloatForKey:@"textheight"];
        subTextHeight = [coder decodeFloatForKey:@"subtextheight"];
    }
    return self;
}



@end
