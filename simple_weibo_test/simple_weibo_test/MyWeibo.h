//
//  MyWeibo.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboUIDelegate.h"
#import "WeiboClientProtocol.h"

#define Type_TimelineArray 0
#define Type_Avatar 1
#define Type_ContentImg 2

@interface MyWeibo : NSObject<WeiboClientProtocol>
{
    NSMutableData *receivedData;
}

@property (nonatomic,retain) id<WeiboUIDelegate> receiver;

-(id)initWithReceiver:(id<WeiboUIDelegate>)receiver;
-(void)getTimeline;
-(void)getAvatar;

@end
