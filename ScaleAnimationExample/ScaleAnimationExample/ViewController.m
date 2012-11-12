//
//  ViewController.m
//  ScaleAnimationExample
//
//  Created by 缪 和光 on 12-11-12.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - table view things
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"flag.jpg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imgView = cell.imageView;
    CGRect frame = imgView.frame;
    NSLog(@"original frame:%@",[NSValue valueWithCGRect:frame]);
    CGRect rectInParentView = [imgView convertRect:frame toView:self.view];
    NSLog(@"rect in parent view:%@",[NSValue valueWithCGRect:rectInParentView]);
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.originalRect = rectInParentView;
    detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:detailVC animated:YES];
}

@end
