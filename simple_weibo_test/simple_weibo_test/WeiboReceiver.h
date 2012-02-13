//
//  WeiboReceiver.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeiboReceiver <NSObject>

@required
-(void)onReceiveStringData:(NSString *)data;
-(void)updateTimeline:(NSArray *)data;
-(void)updateAvatarWithImage:(UIImage *)img AtIndex:(NSIndexPath *)indexPath;
@end
