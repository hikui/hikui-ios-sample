//
//  TimelineGetter.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "TimelineGetter.h"
#import "JSONKit.h"

@implementation TimelineGetter

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *timelineDict = [receivedData objectFromJSONData];
    NSArray *statusesArray = [[timelineDict objectForKey:@"data"]objectForKey:@"info"];
    [self.receiver updateTableView:statusesArray];
    [connection release];

}

@end
