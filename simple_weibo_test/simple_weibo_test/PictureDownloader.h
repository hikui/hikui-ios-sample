//
//  PictureDownloader.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-18.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "MyHttpClient.h"

@interface PictureDownloader : MyHttpClient
@property (nonatomic,retain) NSIndexPath *indexPath;
@property (nonatomic,copy) NSString *url;
-(id)initWithIndexPath:(NSIndexPath *)aIntexPath AndURLString:(NSString *)aUrl AndReceiver:(id<WeiboUIDelegate>) aReceiver;
-(void)loadImg;
@end
