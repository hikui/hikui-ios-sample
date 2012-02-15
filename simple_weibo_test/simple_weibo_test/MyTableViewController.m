//
//  MyTableViewController.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "MyTableViewController.h"
#import "CustomCell.h"
#import "TimelineGetter.h"
#import "AvatarLoader.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyTableViewController
@synthesize statusList;
//@synthesize myWeibo;
@synthesize table;
@synthesize avatarList;
@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;


//consts to help calculate the height
static const float CONTENT_LABEL_WIDTH = 204.0f;
static const float ORI_CONTENT_LABEL_HEIGHT = 39.0F;
static const float ORI_TABLECELL_HEIGHT = 113.0f;
static NSString *FONT = @"Helvetica";
static const float FONT_SIZE = 17.0f;
#define REFRESH_HEADER_HEIGHT 52.0f

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"initwithnibname:%@",nibNameOrNil);
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //myWeibo = [[MyWeibo alloc]initWithReceiver:self];
    [self setupStrings];
    [self addPullToRefreshHeader];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    [FONT release];
    //[myWeibo release];
    [statusList release];
    [avatarList release];
    [refreshHeaderView release];
    [refreshLabel release];
    [refreshArrow release];
    [refreshSpinner release];
    [textPull release];
    [textRelease release];
    [textLoading release];
    
    [super dealloc];
}


#pragma mark - WeiboUIDelegate
-(IBAction)itemPressed:(id)sender{
    [self refresh];
    //[myWeibo getTimeline];
        
}

-(void)onReceiveStringData:(NSString *)data
{
    [data retain];
    NSLog(@"%@",data);
    [data release];
}
-(void)updateTableView:(NSArray *)data
{
    self.statusList = data;
    //init avatarList
    if(avatarList != nil){
        [avatarList release];
    }
    avatarList = [[NSMutableArray alloc]init];
    for (int i= 0; i<data.count; i++) {
        [self.avatarList addObject:[NSNull null]];
    }
    //NSLog(@"statusList retainCount: %d",statusList.retainCount);
    [self stopLoading];
    [table reloadData];
}
-(void)updateAvatarWithImage:(UIImage *)img AtIndex:(NSIndexPath *)indexPath
{
    [img retain];
    [indexPath retain];
    
    [self.avatarList replaceObjectAtIndex:indexPath.row withObject:img];
    CustomCell *cell = (CustomCell *)[self.table cellForRowAtIndexPath:indexPath];
    [cell.avatarView setImage:img];
    //[cell setNeedsDisplay];
    [img release];
    [indexPath release];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return statusList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *contentText = [[statusList objectAtIndex:indexPath.row]objectForKey:@"text"];
    UIFont *font = [UIFont fontWithName:FONT size:FONT_SIZE];
    CGSize contentLabelSize = [contentText sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_LABEL_WIDTH, 2000.0f) lineBreakMode:UILineBreakModeWordWrap];
    return ORI_TABLECELL_HEIGHT+(contentLabelSize.height-ORI_CONTENT_LABEL_HEIGHT);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier ";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        if(nib.count>0){
            cell=(CustomCell *)[nib objectAtIndex:0];
        }else{
            NSLog(@"faild to load customcell nib file");
        }
    }
    NSNull *null = (NSNull *)[self.avatarList objectAtIndex:indexPath.row];
    if(![null isKindOfClass:[NSNull class]]){
        [cell.avatarView setImage:[avatarList objectAtIndex:indexPath.row]];   
    }
    else{
        [cell.avatarView setImage:[UIImage imageNamed:@"anonymous.png"]];
        NSLog(@"head=%@",[[self.statusList objectAtIndex:indexPath.row]objectForKey:@"head"]);
        NSMutableString *headURL = [[NSMutableString alloc]initWithString:[[self.statusList objectAtIndex:indexPath.row]objectForKey:@"head"]];
        if (![headURL isEqualToString:@""]) {
            [headURL appendString:@"/100"];
            AvatarLoader *loader = [[[AvatarLoader alloc]initWithIndexPath:indexPath AndURLString:headURL AndReceiver:self]autorelease];
            [loader loadImg];
        }
        else{
            //load default img
        }
        [headURL release];
    }
    cell.nameLabel.text = [[statusList objectAtIndex:indexPath.row]objectForKey:@"name"];
    cell.contentLabel.text = [[statusList objectAtIndex:indexPath.row]objectForKey:@"text"];
    CGSize contentLabelSize = [cell.contentLabel.text sizeWithFont:cell.contentLabel.font constrainedToSize:CGSizeMake(cell.contentLabel.frame.size.width, 2000.0f) lineBreakMode:UILineBreakModeWordWrap];
    cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, contentLabelSize.height);
    return cell;
}

#pragma mark - pull to refresh
- (void)setupStrings{
    textPull = [[NSString alloc] initWithString:@"下拉可以刷新..."];
    textRelease = [[NSString alloc] initWithString:@"松开可以刷新..."];
    textLoading = [[NSString alloc] initWithString:@"刷新..."];
}

- (void)addPullToRefreshHeader {
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = UITextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    //    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
    //                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
    //                                    27, 44);
    refreshArrow.frame = CGRectMake(30,(REFRESH_HEADER_HEIGHT-44)/2, 27, 44);
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.frame = CGRectMake(30, (REFRESH_HEADER_HEIGHT-20)/2, 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [self.table addSubview:refreshHeaderView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView { //drag过程中产生
    NSLog(@"scrollViewDidScroll");
    NSLog(@"scrollView.contentOffset.y=%f",scrollView.contentOffset.y);
    if (isLoading) {
        //        // Update the content inset, good for section headers
        //        if (scrollView.contentOffset.y > 0){}
        ////            self.tableView.contentInset = UIEdgeInsetsZero;
        //        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT){}
        ////            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        return;
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            refreshLabel.text = self.textRelease;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            refreshLabel.text = self.textPull;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.table.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    refreshLabel.text = self.textLoading;
    refreshArrow.hidden = YES;
    [refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.table.contentInset = UIEdgeInsetsZero;
    UIEdgeInsets tableContentInset = self.table.contentInset;
    tableContentInset.top = 0.0;
    self.table.contentInset = tableContentInset;
    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

- (void)refresh {
    //IMPORTANT! must call stopLoading after finish refresh.
    //see updateTableView
    NSLog(@"itempressed");
    TimelineGetter *getter = [[[TimelineGetter alloc]initWithReceiver:self]autorelease];
    [getter GETWithURLString:@"http://open.t.qq.com/api/statuses/public_timeline?format=json"];
}



@end
