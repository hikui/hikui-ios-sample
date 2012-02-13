//
//  MyHttpClient.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboReceiver.h"

@interface MyHttpClient : NSObject
{
    NSMutableData *receivedData;
}

@property (nonatomic,retain) id<WeiboReceiver> receiver;

-(id)initWithReceiver:(id<WeiboReceiver>)aReceiver;
-(void)GETWithURLString:(NSString *)urlString;
@end
