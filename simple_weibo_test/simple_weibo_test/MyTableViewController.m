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

@implementation MyTableViewController
@synthesize statusList;
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
    [[self navigationItem]setTitle:@"Timeline"];
    UIBarButtonItem *navBarButton = [[[UIBarButtonItem alloc] 
									initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
									target:self 
									action:@selector(refreshItemButtonPressed:)] autorelease];
    self.navigationItem.leftBarButtonItem = navBarButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //myWeibo = [[MyWeibo alloc]initWithReceiver:self];
    [self setupNav];
    picturesDict = [[NSMutableDictionary alloc]init];
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
    //[myWeibo release];
    [statusList release];
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
-(void)updateTableView:(NSArray *)data
{
    self.tcMessagesList = data;
    //init avatarList
    [avatarList release];
    avatarList = [[NSMutableArray alloc]init];
    for (int i= 0; i<data.count; i++) {
        [self.avatarList addObject:[NSNull null]];
    }
    //NSLog(@"statusList retainCount: %d",statusList.retainCount);
    [self stopLoading];
    [self.tableView reloadData];
}
-(void)updateAvatarWithImage:(UIImage *)img AtIndex:(NSIndexPath *)indexPath
{
    [img retain];
    [indexPath retain];
    
    [self.avatarList replaceObjectAtIndex:indexPath.row withObject:img];
//    CustomCell *cell = (CustomCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//    [cell.avatarView setImage:img];
//    //[cell setNeedsDisplay];
//    [img release];
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
        [cell.headImage setImage:[UIImage imageNamed:@"anonymous.png"]];
        NSMutableString *headURL = [[NSMutableString alloc]initWithString:currMessage.headUrl];
        if (![headURL isEqualToString:@""]) {
            [headURL appendString:@"/100"];
            AvatarLoader *loader = [[[AvatarLoader alloc]initWithIndexPath:indexPath AndURLString:headURL AndReceiver:self]autorelease];
            [loader loadImg];
        }
        [headURL release];
    }
    
    //load picture
    if((NSNull *)currMessage.pictureUrl != [NSNull null]){
        UIImage * picture = [picturesDict objectForKey:indexPath];
        if(picture == nil){
            picture = [UIImage imageNamed:@"defaultImg.png"];
            NSMutableString *picUrl = [[NSMutableString alloc]initWithString:currMessage.pictureUrl];
            if(![picUrl isEqualToString:@""]){
                [picUrl appendString:@"/160"];
                PictureDownloader *picDownloader = [[[PictureDownloader alloc]initWithIndexPath:indexPath AndURLString:picUrl AndReceiver:self]autorelease];
                [picDownloader loadImg];
            }
            [picUrl release];
        }
        [cell.picture setImage:picture];
    }
        
    [cell updateFrames];
    return cell;
}


#pragma mark - pull to refresh
- (void)refresh {
    //IMPORTANT! must call stopLoading after finish refresh.
    //see updateTableView
    TimelineGetter *getter = [[[TimelineGetter alloc]initWithReceiver:self]autorelease];
    [getter GETWithURLString:@"http://open.t.qq.com/api/statuses/public_timeline?format=json"];
}



@end
