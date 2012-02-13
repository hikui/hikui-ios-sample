//
//  MyWeibo.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboReceiver.h"


@interface MyWeibo : NSObject
{
    NSMutableData *receivedData;
}

@property (nonatomic,retain) id<WeiboReceiver> receiver;

-(id)initWithReceiver:(id<WeiboReceiver>)receiver;
-(void)getTimeline;

@end
