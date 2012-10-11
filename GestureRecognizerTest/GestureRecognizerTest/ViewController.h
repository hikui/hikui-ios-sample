//
//  ViewController.h
//  GestureRecognizerTest
//
//  Created by 缪 和光 on 12-9-20.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIGestureRecognizer *borderTap;
@property (nonatomic,weak) IBOutlet UIGestureRecognizer *innerTap;

- (IBAction)handlePanGesture:(UIGestureRecognizer *)panGestureRecognizer;
- (IBAction)handleBoardTapGesture:(UIGestureRecognizer *)panGestureRecognizer;
- (IBAction)handleSubviewTapGesture:(UIGestureRecognizer *)panGestureRecognizer;

@end
