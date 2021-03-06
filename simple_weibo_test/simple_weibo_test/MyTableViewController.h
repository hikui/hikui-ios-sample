//
//  MyTableViewController.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboUIDelegate.h"
#import "PullRefreshTableViewController.h"


@interface MyTableViewController : PullRefreshTableViewController <WeiboUIDelegate>
//@property (nonatomic, retain) NSArray *statusList;
@property (nonatomic, copy) NSMutableArray *tcMessagesList;
@property (nonatomic, retain) NSMutableArray *avatarList;
@property (nonatomic, retain) NSMutableDictionary *picturesDict;
-(IBAction)refreshItemButtonPressed:(id)sender;

@end
