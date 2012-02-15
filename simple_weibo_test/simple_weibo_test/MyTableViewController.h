//
//  MyTableViewController.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboUIDelegate.h"


@interface MyTableViewController : UIViewController <WeiboUIDelegate>
{
    BOOL isLoading;
    BOOL isDragging;
    BOOL isPullRefresh;

}
@property (nonatomic, retain) NSArray *statusList;
@property (nonatomic, retain) NSMutableArray *avatarList;
//@property (nonatomic, retain) MyWeibo *myWeibo;
@property (nonatomic, retain) IBOutlet UITableView *table;
-(IBAction)itemPressed:(id)sender;

#pragma mark - pull to refresh
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;

- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;

@end
