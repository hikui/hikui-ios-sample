//
//  ViewController.h
//  UIViewTransformTest
//
//  Created by 缪 和光 on 12-10-12.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton *btnTransform;
@property (nonatomic,weak) IBOutlet UIButton *toTranseform;

-(IBAction)transform:(id)sender;

-(IBAction)printFrame:(id)sender;

@end
