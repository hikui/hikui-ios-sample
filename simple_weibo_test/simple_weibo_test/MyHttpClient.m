//
//  MyHttpClient.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "MyHttpClient.h"

@implementation MyHttpClient
@synthesize receiver;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(id)initWithReceiver:(id<WeiboUIDelegate>)aReceiver
{
    self = [super init];
    if(self)
    {
        self.receiver = aReceiver;
    }
    return self;
}

#pragma mark - network

-(void)GETWithURLString:(NSString *)urlString
{
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL
                                                           URLWithString:urlString]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest
                                                                   delegate:self];
    if (theConnection) {
        receivedData = [[NSMutableData data] retain];
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response 
{
    //NSLog(@"get the whole response");
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"get some data");
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    //implement with subclass
    [connection release];
    
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [connection release];
    
    NSLog(@"Connection failed! Error - %@ %@",   
          [error localizedDescription],    
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}

- (void)dealloc {
    [receivedData release];
    [receiver release];
    [super dealloc];
}

@end
