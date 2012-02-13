//
//  MyTableViewController.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboUIDelegate.h"
#import "MyWeibo.h"

@interface MyTableViewController : UIViewController <WeiboUIDelegate>
@property (nonatomic, retain) NSArray *statusList;
@property (nonatomic, retain) MyWeibo *myWeibo;
@property (nonatomic, retain) IBOutlet UITableViewCell *tvCell;
@property (nonatomic, retain) IBOutlet UITableView *table;
-(IBAction)itemPressed:(id)sender;
@end
