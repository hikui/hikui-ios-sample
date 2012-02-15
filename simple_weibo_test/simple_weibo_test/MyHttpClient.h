//
//  MyHttpClient.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboUIDelegate.h"

@interface MyHttpClient : NSObject
{
    NSMutableData *receivedData;
}

@property (nonatomic,retain) id<WeiboUIDelegate> receiver;

-(id)initWithReceiver:(id<WeiboUIDelegate>)aReceiver;
-(void)GETWithURLString:(NSString *)urlString;
@end
