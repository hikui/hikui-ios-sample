//
//  DecoratorImgView.h
//  ImgApp
//
//  Created by 缪 和光 on 12-9-18.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DecoratorImgView : UIView

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, unsafe_unretained) CGSize originalSize;

- (id)initWithImage:(UIImage *)img withCenter:(CGPoint)center;
- (id)initWithImage:(UIImage *)img withStartPoint:(CGPoint)startPoint;

@end
