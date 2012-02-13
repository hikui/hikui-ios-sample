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

@implementation MyTableViewController
@synthesize statusList;
//@synthesize myWeibo;
@synthesize table;
@synthesize avatarList;

//consts to help calculate the height
static const float CONTENT_LABEL_WIDTH = 204.0f;
static const float ORI_CONTENT_LABEL_HEIGHT = 39.0F;
static const float ORI_TABLECELL_HEIGHT = 113.0f;
static NSString *FONT = @"Helvetica";
static const float FONT_SIZE = 17.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - network
-(IBAction)itemPressed:(id)sender{
    NSLog(@"itempressed");
    TimelineGetter *getter = [[[TimelineGetter alloc]initWithReceiver:self]autorelease];
    [getter GETWithURLString:@"http://open.t.qq.com/api/statuses/public_timeline?format=json"];
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
-(void)dealloc
{
    [FONT release];
    //[myWeibo release];
    [statusList release];
    [avatarList release];
    [super dealloc];
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
        NSLog(@"head=%@",[[self.statusList objectAtIndex:indexPath.row]objectForKey:@"head"]);
        NSMutableString *headURL = [[NSMutableString alloc]initWithString:[[self.statusList objectAtIndex:indexPath.row]objectForKey:@"head"]];
        if (![headURL isEqualToString:@""]) {
            [headURL appendString:@"/100"];
            AvatarLoader *loader = [[[AvatarLoader alloc]initWithIndexPath:indexPath AndURLString:headURL AndReceiver:self]autorelease];
            [loader loadImg];
            [headURL release];
        }
        else{
            NSLog(@"headURL is empty");
        }
    }
    cell.nameLabel.text = [[statusList objectAtIndex:indexPath.row]objectForKey:@"name"];
    cell.contentLabel.text = [[statusList objectAtIndex:indexPath.row]objectForKey:@"text"];
    CGSize contentLabelSize = [cell.contentLabel.text sizeWithFont:cell.contentLabel.font constrainedToSize:CGSizeMake(cell.contentLabel.frame.size.width, 2000.0f) lineBreakMode:UILineBreakModeWordWrap];
    cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, contentLabelSize.height);
    return cell;
}

@end
