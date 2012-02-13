//
//  MyHTTPClient.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboClientProtocol.h"

@interface MyHTTPClient : NSObject
{
    NSMutableData *receivedData;
}
@property (nonatomic,copy) NSString *requestURL;
@property (nonatomic,retain) NSObject<WeiboClientProtocol> *weiboClient;
-(void)sendRequest;
-(void)sendRequestWithURLString:(NSString *)URLString;
-(void)sendRequestWithURLRequest:(NSURLRequest *)URLRequest;
@end
