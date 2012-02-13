//
//  MyWeibo.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "MyWeibo.h"
#import "JSONKit.h"

@implementation MyWeibo
@synthesize receiver;

static NSString * PUBLIC_TIMELINE_URL = @"http://open.t.qq.com/api/statuses/public_timeline?format=json";

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithReceiver:(id<WeiboReceiver>)receiver
{
    self = [super init];
    if(self)
    {
        self.receiver = receiver;
    }
    return self;
}

-(void)dealloc
{
    [PUBLIC_TIMELINE_URL release];
    [receiver release];
    [receivedData release];
    [super dealloc];
}

#pragma mark - network

-(void)getTimeline
{
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL
                                                           URLWithString:PUBLIC_TIMELINE_URL]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest
                                                                   delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [[NSMutableData data] retain];
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response 
{
    NSLog(@"get the whole response");
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"get some data");
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    NSDictionary *timelineDict = [receivedData objectFromJSONData];
    NSArray *statusesArray = [[timelineDict objectForKey:@"data"]objectForKey:@"info"];
    [self.receiver onReceiveArrayData:statusesArray];
    [connection release];
    
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [connection release];
    
    NSLog(@"Connection failed! Error - %@ %@",   
          [error localizedDescription],    
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}


@end
