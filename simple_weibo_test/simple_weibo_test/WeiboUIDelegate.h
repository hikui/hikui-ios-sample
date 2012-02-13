//
//  WeiboReceiver.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeiboUIDelegate <NSObject>

@required
-(void)onReceiveStringData:(NSString *)data;
-(void)onReceiveArrayData:(NSArray *)data;
-(void)onReceiveData:(NSObject *)data withDataType:(NSInteger)type;
-(void)refreshTimelineWithData:(NSArray *)statusArray;
-(void)

@end
