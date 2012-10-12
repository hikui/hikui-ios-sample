//
//  ViewController.m
//  UIViewTransformTest
//
//  Created by 缪 和光 on 12-10-12.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

- (void)deviceRotateToDeviceOrientation:(NSNotification *)notification;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceRotateToDeviceOrientation:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)deviceRotateToDeviceOrientation:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.5f];
    if (orientation != UIDeviceOrientationPortrait && orientation != UIDeviceOrientationUnknown) {
        self.btnTransform.transform = CGAffineTransformMakeTranslation(0, 300);
    }else{
        self.btnTransform.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    [UIView commitAnimations];
    
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.5f];
        self.toTranseform.transform = CGAffineTransformMakeRotation(M_PI/2);
        [UIView commitAnimations];

    }else if (orientation == UIDeviceOrientationLandscapeRight) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.5f];
        self.toTranseform.transform = CGAffineTransformMakeRotation(-M_PI/2);
        [UIView commitAnimations];
        
    }else if (orientation == UIDeviceOrientationPortrait) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.5f];
        self.toTranseform.transform = CGAffineTransformMakeRotation(0);
        [UIView commitAnimations];
        
    }
}

-(IBAction)transform:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.5f];
    self.toTranseform.transform = CGAffineTransformMake(1, 2, 3, 4, 5, 6);
    [UIView commitAnimations]; 
}

-(IBAction)printFrame:(id)sender
{
    NSLog(@"%@",sender);
}

@end
