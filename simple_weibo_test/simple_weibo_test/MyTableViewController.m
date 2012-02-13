//
//  MyTableViewController.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-12.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyWeibo.h"

@implementation MyTableViewController
@synthesize statusList;
@synthesize myWeibo;
@synthesize tvCell;
@synthesize table;

//consts to help calculate the height
static const float CONTENT_LABEL_WIDTH = 280.0F;
static const float ORI_CONTENT_LABEL_HEIGHT = 21.0F;
static const float ORI_TABLECELL_HEIGHT = 90.0F;
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
    myWeibo = [[MyWeibo alloc]initWithReceiver:self];
    
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
    [myWeibo getTimeline];
        
}

-(void)onReceiveStringData:(NSString *)data
{
    [data retain];
    NSLog(@"%@",data);
    [data release];
}
-(void)onReceiveArrayData:(NSArray *)data
{
    self.statusList = data;
    NSLog(@"statusList retainCount: %d",statusList.retainCount);
    [table reloadData];
}
-(void)dealloc
{
    [FONT release];
    [myWeibo release];
    [statusList release];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        if(nib.count>0){
            cell=self.tvCell;
        }else{
            NSLog(@"faild to load customcell nib file");
        }
    }
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text=[[statusList objectAtIndex:indexPath.row]objectForKey:@"name"];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:2];
    contentLabel.text=[[statusList objectAtIndex:indexPath.row]objectForKey:@"text"];
    CGSize contentLabelSize = [contentLabel.text sizeWithFont:contentLabel.font constrainedToSize:CGSizeMake(contentLabel.frame.size.width, 2000.0f) lineBreakMode:UILineBreakModeWordWrap];
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, contentLabelSize.height);
    return cell;
}

@end
