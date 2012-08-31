//
//  ViewController.m
//  OrientationExample
//
//  Created by 缪 和光 on 12-8-31.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "ViewController.h"

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
    NSLog(@"vc1------------------");
    NSLog(@"shouldAutorotate, toInterfaceOrientation:%d",interfaceOrientation);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    NSLog(@"vc1------------------");
    NSLog(@"willAnimate, toInterfaceOrientation:%d",toInterfaceOrientation);
}

@end
