//
//  WeiboClientProtocol.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeiboClientProtocol <NSObject>
-(void)onReceiveData:(NSData *)data;
@end
