//
//  ViewController2.m
//  OrientationExample
//
//  Created by 缪 和光 on 12-8-31.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"vc2------------------");
    NSLog(@"shouldAutorotate, toInterfaceOrientation:%d",interfaceOrientation);
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"vc2------------------");
    NSLog(@"willAnimate, toInterfaceOrientation:%d",toInterfaceOrientation);
}

@end
