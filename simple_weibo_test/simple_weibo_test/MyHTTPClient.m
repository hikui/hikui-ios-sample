//
//  MyHTTPClient.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "MyHTTPClient.h"

@implementation MyHTTPClient
@synthesize weiboClient;
@synthesize requestURL;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithClient:(NSObject<WeiboClientProtocol> *)client
{
    if(self=[super init]){
        self.weiboClient = client;
    }
    return self;
}


-(id)initWithClient:(NSObject<WeiboClientProtocol> *)client AndURL:(NSString *)URL
{
    if(self=[super init]){
        self.requestURL = URL;
        self.weiboClient = client;
    }
    return self;
}

-(void)sendRequest
{
    if (requestURL != nil) {
        //
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL
                                                               URLWithString:requestURL]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:60.0];
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
    else{
        NSLog(@"Fatal Error: didn't init requestURL");
    }
}

-(void)sendRequestWithURLString:(NSString *)URLString
{
    //not implement yet
}
-(void)sendRequestWithURLRequest:(NSURLRequest *)URLRequest
{
    //not implement yet
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
    [weiboClient onReceiveData:receivedData];
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
