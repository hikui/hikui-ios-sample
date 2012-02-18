//
//  PictureDownloader.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-18.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "PictureDownloader.h"

@implementation PictureDownloader

@synthesize indexPath;
@synthesize url;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithIndexPath:(NSIndexPath *)aIntexPath AndURLString:(NSString *)aUrl AndReceiver:(id<WeiboUIDelegate>)aReceiver
{
    self = [super init];
    if (self) {
        self.indexPath = aIntexPath;
        self.url = aUrl;
        self.receiver = aReceiver;
    }
    
    return self;
}

-(void)loadImg
{
    if(indexPath != nil && url != nil){
        [self GETWithURLString:url];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *img = [[UIImage alloc]initWithData:receivedData];
    [self.receiver updatePicture:img AtIndex:(NSIndexPath *)indexPath];
    [img release];
    [connection release];
}

- (void)dealloc {
    [indexPath release];
    [url release];
    [super dealloc];
}

@end
