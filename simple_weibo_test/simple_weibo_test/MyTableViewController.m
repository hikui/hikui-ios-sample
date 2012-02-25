//
//  MyTableViewController.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "MyTableViewController.h"
#import "StatusCell.h"
#import "TimelineGetter.h"
#import "AvatarLoader.h"
#import "TencentMessage.h"
#import "PictureDownloader.h"
#import "TencentMessage.h"

#define CACHE_PATH @"/Documents"

@implementation MyTableViewController
//@synthesize statusList;
@synthesize tcMessagesList;
@synthesize avatarList,picturesDict;


//consts to help calculate the height

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

-(void)setupNav
{
    [[self navigationItem]setTitle:@"随便看看"];
    UIBarButtonItem *navBarButton = [[[UIBarButtonItem alloc] 
									initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
									target:self 
									action:@selector(refreshItemButtonPressed:)] autorelease];
    self.navigationItem.leftBarButtonItem = navBarButton;
}

-(void)setupTimeline
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:CACHE_PATH];
    //[[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *archivePath = [path stringByAppendingString:@"/timeline.archive"];
    NSArray *archivedTimeline = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    tcMessagesList = [[NSMutableArray alloc]initWithArray:archivedTimeline];
    if(tcMessagesList == nil){
        tcMessagesList = [[NSMutableArray alloc]init];
    }
    avatarList = [[NSMutableArray alloc]init];
    //NSLog(@"saved tcmessages count:%d",tcMessagesList.count);
    for (int i= 0; i<tcMessagesList.count; i++) {
        [avatarList addObject:[NSNull null]];
    }
    
    
//	[[NSFileManager defaultManager] createDirectoryAtPath:path attributes:nil];
}

-(void)saveTimeline
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:CACHE_PATH];
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *archivePath = [path stringByAppendingString:@"/timeline.archive"];
    BOOL result = [NSKeyedArchiver archiveRootObject:tcMessagesList
                                              toFile:archivePath];
    if (result) {
        NSLog(@"save timeline succeed");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //myWeibo = [[MyWeibo alloc]initWithReceiver:self];
    [self setupNav];
    [self setupTimeline];
    picturesDict = [[NSMutableDictionary alloc]init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    avatarList = nil;
    tcMessagesList = nil;
    picturesDict = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    //[myWeibo release];
//    [statusList release];
    [avatarList release];
    [tcMessagesList release];
    [picturesDict release];
    [super dealloc];
}


#pragma mark - Event listeners

-(IBAction)refreshItemButtonPressed:(id)sender
{
    [self startLoading];
}

#pragma mark - WeiboUIDelegate

-(void)onReceiveStringData:(NSString *)data
{
    [data retain];
    NSLog(@"%@",data);
    [data release];
}

-(void)insertIntoTimeline:(NSArray *)data
{
    if(tcMessagesList != nil){
        int i = 0;
        for(TencentMessage *aMessage in data){
            [tcMessagesList insertObject:aMessage atIndex:i++];
        }
    }
}

-(void)updateTableView:(NSArray *)data
{
    [self insertIntoTimeline:data];
    [avatarList release];
    avatarList = [[NSMutableArray alloc]init];
    for (int i= 0; i<tcMessagesList.count; i++) {
        [self.avatarList addObject:[NSNull null]];
    }
    [self stopLoading];
    [self saveTimeline];
    [self.tableView reloadData];
}
-(void)updateAvatarWithImage:(UIImage *)img AtIndex:(NSIndexPath *)indexPath
{
    [img retain];
    [indexPath retain];
    //NSLog(@"%@",avatarList);
    [self.avatarList replaceObjectAtIndex:indexPath.row withObject:img];
    StatusCell *cell = (StatusCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell.headImage setImage:img];
    [img release];
    [cell setNeedsDisplay];
    [indexPath release];
}

-(void)updatePicture:(UIImage *)img AtIndex:(NSIndexPath *)indexPath
{
    [img retain];
    [indexPath retain];
    [picturesDict setObject:img forKey:indexPath];
    StatusCell *cell = (StatusCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell.picture setImage:img];
    [cell setNeedsDisplay];
    [img release];
    [indexPath release];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return tcMessagesList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TencentMessage *aMsg = [tcMessagesList objectAtIndex:indexPath.row];
    return aMsg.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    static NSString *CustomCellIdentifier = @"StatusCell ";
    StatusCell *cell = (StatusCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if(cell == nil){
        cell = [[[StatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier]autorelease];
    }
    TencentMessage * currMessage = [tcMessagesList objectAtIndex:indexPath.row];
    [cell updateMessage:currMessage];
    
    //load avatar:
    NSNull *null = (NSNull *)[self.avatarList objectAtIndex:indexPath.row];
    if(![null isKindOfClass:[NSNull class]]){
        [cell.headImage setImage:[avatarList objectAtIndex:indexPath.row]];   
    }
    else{
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO){
            [cell.headImage setImage:[UIImage imageNamed:@"anonymous.png"]];
            NSMutableString *headURL = [[NSMutableString alloc]initWithString:currMessage.headUrl];
            if (![headURL isEqualToString:@""]) {
                [headURL appendString:@"/100"];
                AvatarLoader *loader = [[[AvatarLoader alloc]initWithIndexPath:indexPath AndURLString:headURL AndReceiver:self]autorelease];
                [loader loadImg];
            }
            [headURL release]; 
        }
        
    }
    
    //load picture
    if((NSNull *)currMessage.pictureUrl != [NSNull null]){
        UIImage * picture = [picturesDict objectForKey:indexPath];
        if(picture == nil){
            picture = [UIImage imageNamed:@"defaultImg.png"];
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO){
                NSMutableString *picUrl = [[NSMutableString alloc]initWithString:currMessage.pictureUrl];
                if(![picUrl isEqualToString:@""]){
                    [picUrl appendString:@"/160"];
                    PictureDownloader *picDownloader = [[[PictureDownloader alloc]initWithIndexPath:indexPath AndURLString:picUrl AndReceiver:self]autorelease];
                    [picDownloader loadImg];
                }
                [picUrl release];
            }
        }
        [cell.picture setImage:picture];
    }
        
    [cell updateFrames];
    return cell;
}

-(void)downloadImgs
{
    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visiblePaths)
    {
        TencentMessage * currMessage = [tcMessagesList objectAtIndex:indexPath.row];
        NSMutableString *headURL = [[NSMutableString alloc]initWithString:currMessage.headUrl];
        if (![headURL isEqualToString:@""]) {
            [headURL appendString:@"/100"];
            AvatarLoader *loader = [[[AvatarLoader alloc]initWithIndexPath:indexPath AndURLString:headURL AndReceiver:self]autorelease];
            [loader loadImg];
        }
        [headURL release]; 
        NSMutableString *picURL = [[NSMutableString alloc]initWithString:currMessage.headUrl];
        if (![headURL isEqualToString:@""]) {
            [headURL appendString:@"/100"];
            AvatarLoader *loader = [[[AvatarLoader alloc]initWithIndexPath:indexPath AndURLString:picURL AndReceiver:self]autorelease];
            [loader loadImg];
        }
        [picURL release];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self downloadImgs];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self downloadImgs];
}


#pragma mark - pull to refresh
- (void)refresh {
    //IMPORTANT! must call stopLoading after finish refresh.
    //see updateTableView
    TimelineGetter *getter = [[[TimelineGetter alloc]initWithReceiver:self]autorelease];
    [getter GETWithURLString:@"http://open.t.qq.com/api/statuses/public_timeline?format=json"];
}



@end
