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
    UILabel *label = (UILabel *)[self.view viewWithTag:1];
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    if (UIDeviceOrientationIsLandscape(orientation)) {
//        label.text = @"landscape";
//    }else{
//        label.text = @"portrait";
//    }
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        label.text = @"landscape";
    }else{
        label.text = @"portrait";
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UILabel *label = (UILabel *)[self.view viewWithTag:1];
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        label.text = @"landscape";
    }else{
        label.text = @"portrait";
    }
}

@end
