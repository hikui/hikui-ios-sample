//
//  ViewController.m
//  GestureRecognizerTest
//
//  Created by 缪 和光 on 12-9-20.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (UIDeviceOrientationUnknown == [UIDevice currentDevice].orientation) {
        NSLog(@"aaaa");
    }
    NSLog(@"%d",[UIDevice currentDevice].orientation);
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

- (IBAction)handlePanGesture:(UIGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchPoint = [panGestureRecognizer locationInView:self.view];
    NSLog(@"touch at %f,%f",touchPoint.x,touchPoint.y);
}

- (IBAction)handleBoardTapGesture:(UIGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchPoint = [panGestureRecognizer locationInView:panGestureRecognizer.view];
    NSLog(@"tap at board %f,%f",touchPoint.x,touchPoint.y);
    self.innerTap.enabled = NO;
}
- (IBAction)handleSubviewTapGesture:(UIGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchPoint = [panGestureRecognizer locationInView:self.view];
    NSLog(@"tap at subview %f,%f",touchPoint.x,touchPoint.y);
}

@end
