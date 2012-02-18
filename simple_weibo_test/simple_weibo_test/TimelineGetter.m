//
//  TimelineGetter.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "TimelineGetter.h"
#import "JSONKit.h"
#import "TencentMessage.h"

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
    NSMutableArray *tcMessagesArray = [[NSMutableArray alloc]init];
    for(NSDictionary *aStatus in statusesArray){
        TencentMessage *aTcMessage = [[TencentMessage alloc]initWithJSONDict:aStatus];
        [tcMessagesArray addObject:aTcMessage];
        [aTcMessage release];
    }
    [self.receiver updateTableView:tcMessagesArray];
    [tcMessagesArray release];
    [connection release];

}

@end
