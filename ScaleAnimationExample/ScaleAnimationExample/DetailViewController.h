//
//  DetailViewController.h
//  ScaleAnimationExample
//
//  Created by 缪 和光 on 12-11-12.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, unsafe_unretained) CGRect originalRect;
@property (nonatomic, unsafe_unretained) CGRect targetRect;

@end
