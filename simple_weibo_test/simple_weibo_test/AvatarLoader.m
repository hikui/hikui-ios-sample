//
//  AvatarLoader.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-13.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "AvatarLoader.h"

@implementation AvatarLoader
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *img = [[UIImage alloc]initWithData:receivedData];
    [self.receiver updateAvatarWithImage:img AtIndex:(NSIndexPath *)self.indexPath];
    [img release];
    [connection release];
}

- (void)dealloc {
    [super dealloc];
}
@end
