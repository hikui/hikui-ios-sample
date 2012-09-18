//
//  ViewController.m
//  ImgApp
//
//  Created by 缪 和光 on 12-9-18.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "ViewController.h"
#import "DecoratorImgView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *img = [UIImage imageNamed:@"1.jpg"];
    DecoratorImgView *di = [[DecoratorImgView alloc]initWithImage:img withCenter:self.view.center];
    [self.view addSubview:di];
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

@end
