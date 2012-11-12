//
//  DetailViewController.m
//  ScaleAnimationExample
//
//  Created by 缪 和光 on 12-11-12.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (void)tapImage:(id)sender;

@end

@implementation DetailViewController

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
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.originalRect];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = [UIImage imageNamed:@"flag_big.jpg"];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    [imgView addGestureRecognizer:tapGesture];
    [self.view addSubview:imgView];
    self.imageView = imgView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.4 animations:^{
        self.imageView.frame = self.view.bounds;
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tapImage:(id)sender
{
    NSLog(@"tap image");
    [UIView animateWithDuration:0.4 animations:^{
        self.imageView.frame = self.originalRect;
    }];
    [self dismissModalViewControllerAnimated:YES];
}

@end
