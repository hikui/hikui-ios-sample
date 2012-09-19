//
//  DecoratorImgView.m
//  ImgApp
//
//  Created by 缪 和光 on 12-9-18.
//  Copyright (c) 2012年 缪 和光. All rights reserved.
//

#import "DecoratorImgView.h"
#define DragPointWidth 15

@interface DecoratorImgView()

@property (nonatomic, unsafe_unretained) BOOL shouldShowDragPoint;

@end

@implementation DecoratorImgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImage:(UIImage *)img withCenter:(CGPoint)theCenter
{
    CGSize imgSize = img.size;
    CGPoint startPoint = CGPointMake(theCenter.x - imgSize.width/2,
                                    theCenter.y - imgSize.height/2);
    CGRect frame = CGRectMake(startPoint.x, startPoint.y, imgSize.width+DragPointWidth, imgSize.height+DragPointWidth);
    self = [super initWithFrame:frame];
    if (self) {
        _originalSize = imgSize;
        _img = img;
        _shouldShowDragPoint = YES;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithImage:(UIImage *)img withStartPoint:(CGPoint)startPoint
{
    CGSize imgSize = img.size;
    CGRect frame = CGRectMake(startPoint.x, startPoint.y, imgSize.width+DragPointWidth, imgSize.height+DragPointWidth);
    self = [super initWithFrame:frame];
    if (self) {
        _originalSize = imgSize;
        _img = img;
        _shouldShowDragPoint = YES;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect imgRect = CGRectZero;
    imgRect.origin = CGPointMake(DragPointWidth/2, DragPointWidth/2);
    imgRect.size = CGSizeMake(self.frame.size.width-DragPointWidth, self.frame.size.height-DragPointWidth);
    [self.img drawInRect:imgRect];
    
    if (self.shouldShowDragPoint) {
        //draw outer line
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextStrokeRect(context, imgRect);
        
        //draw drag point
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGRect dragPointRect = CGRectZero;
        CGSize frameSize = self.frame.size;
        dragPointRect.size = CGSizeMake(DragPointWidth, DragPointWidth);
        CGContextFillEllipseInRect(context, dragPointRect);
        dragPointRect.origin = CGPointMake(frameSize.width/2-DragPointWidth/2, 0);
        CGContextFillEllipseInRect(context, dragPointRect);
        dragPointRect.origin = CGPointMake(frameSize.width-DragPointWidth, 0);
        CGContextFillEllipseInRect(context, dragPointRect);
        dragPointRect.origin = CGPointMake(frameSize.width-DragPointWidth, frameSize.height/2-DragPointWidth/2);
        CGContextFillEllipseInRect(context, dragPointRect);
        dragPointRect.origin = CGPointMake(frameSize.width-DragPointWidth, frameSize.height-DragPointWidth);
        CGContextFillEllipseInRect(context, dragPointRect);
        dragPointRect.origin = CGPointMake(frameSize.width/2-DragPointWidth/2, frameSize.height-DragPointWidth);
        CGContextFillEllipseInRect(context, dragPointRect);
        dragPointRect.origin = CGPointMake(0, frameSize.height-DragPointWidth);
        CGContextFillEllipseInRect(context, dragPointRect);
        dragPointRect.origin = CGPointMake(0, frameSize.height/2-DragPointWidth/2);
        CGContextFillEllipseInRect(context, dragPointRect);
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

static BOOL movedBeforeEnd = NO;
static BOOL shouldMove = NO;
static CGPoint tmpTouchPoint;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    movedBeforeEnd = NO;
    tmpTouchPoint = [[touches anyObject]locationInView:self];
    
    shouldMove = YES;
    
    CGRect dragPointTLRect,dragPointTMRect,dragPointTRRect,dragPointRMRect,dragPointBRRect,dragPointBMRect,dragPointBLRect,dragPointLMRect;
    dragPointTLRect = dragPointTMRect = dragPointTRRect = dragPointRMRect = dragPointBRRect = dragPointBMRect = dragPointBLRect = dragPointLMRect = CGRectZero;
    
    CGSize frameSize = self.frame.size;
    dragPointTLRect.size=dragPointTMRect.size=dragPointTRRect.size=dragPointRMRect.size=dragPointBRRect.size=dragPointBMRect.size=dragPointBLRect.size=dragPointLMRect.size=CGSizeMake(DragPointWidth, DragPointWidth);
    dragPointTMRect.origin = CGPointMake(frameSize.width/2-DragPointWidth/2, 0);
    dragPointTRRect.origin = CGPointMake(frameSize.width-DragPointWidth, 0);
    dragPointRMRect.origin = CGPointMake(frameSize.width-DragPointWidth, frameSize.height/2-DragPointWidth/2);
    dragPointBRRect.origin = CGPointMake(frameSize.width-DragPointWidth, frameSize.height-DragPointWidth);
    dragPointBMRect.origin = CGPointMake(frameSize.width/2-DragPointWidth/2, frameSize.height-DragPointWidth);
    dragPointBLRect.origin = CGPointMake(0, frameSize.height-DragPointWidth);
    dragPointLMRect.origin = CGPointMake(0, frameSize.height/2-DragPointWidth/2);
    
    UITouch *aTouch = [touches anyObject];
    CGPoint touchPoint = [aTouch locationInView:self];
    if (CGRectContainsPoint(dragPointTLRect, touchPoint) ||
        CGRectContainsPoint(dragPointTMRect, touchPoint) ||
        CGRectContainsPoint(dragPointTRRect, touchPoint) ||
        CGRectContainsPoint(dragPointRMRect, touchPoint) ||
        CGRectContainsPoint(dragPointBRRect, touchPoint) ||
        CGRectContainsPoint(dragPointBMRect, touchPoint) ||
        CGRectContainsPoint(dragPointBLRect, touchPoint) ||
        CGRectContainsPoint(dragPointLMRect, touchPoint)
        ) {
        shouldMove = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    self.shouldShowDragPoint = YES;
    movedBeforeEnd = YES;
    
    UITouch *aTouch = [touches anyObject];
    CGPoint touchPoint = [aTouch locationInView:self];
    CGFloat deltaX = touchPoint.x - tmpTouchPoint.x;
    CGFloat deltaY = touchPoint.y - tmpTouchPoint.y;
    if (shouldMove) {
        
        CGPoint center = self.center;
        center.x += deltaX;
        center.y += deltaY;
        self.center = center;
        return;
    }
    
    CGRect dragPointTLRect,dragPointTMRect,dragPointTRRect,dragPointRMRect,dragPointBRRect,dragPointBMRect,dragPointBLRect,dragPointLMRect;
    dragPointTLRect = dragPointTMRect = dragPointTRRect = dragPointRMRect = dragPointBRRect = dragPointBMRect = dragPointBLRect = dragPointLMRect = CGRectZero;
    
    CGSize frameSize = self.frame.size;
    dragPointTLRect.size=dragPointTMRect.size=dragPointTRRect.size=dragPointRMRect.size=dragPointBRRect.size=dragPointBMRect.size=dragPointBLRect.size=dragPointLMRect.size=CGSizeMake(DragPointWidth, DragPointWidth);
    dragPointTMRect.origin = CGPointMake(frameSize.width/2-DragPointWidth/2, 0);
    dragPointTRRect.origin = CGPointMake(frameSize.width-DragPointWidth, 0);
    dragPointRMRect.origin = CGPointMake(frameSize.width-DragPointWidth, frameSize.height/2-DragPointWidth/2);
    dragPointBRRect.origin = CGPointMake(frameSize.width-DragPointWidth, frameSize.height-DragPointWidth);
    dragPointBMRect.origin = CGPointMake(frameSize.width/2-DragPointWidth/2, frameSize.height-DragPointWidth);
    dragPointBLRect.origin = CGPointMake(0, frameSize.height-DragPointWidth);
    dragPointLMRect.origin = CGPointMake(0, frameSize.height/2-DragPointWidth/2);
    
    if (CGRectContainsPoint(dragPointTLRect, touchPoint)) {
        CGRect frame = self.frame;
        frame.size.height -= deltaY;
        frame.size.width -= deltaX;
        frame.origin.y += deltaY;
        frame.origin.x += deltaX;
        self.frame = frame;
        [self setNeedsDisplay];
    }else if (CGRectContainsPoint(dragPointTMRect, touchPoint)){
        CGRect frame = self.frame;
        frame.size.height -= deltaY;
        frame.origin.y += deltaY;
        self.frame = frame;
        [self setNeedsDisplay];
    }else if (CGRectContainsPoint(dragPointTRRect, touchPoint)){
        CGRect frame = self.frame;
        frame.size.height -= deltaY;
        frame.origin.y += deltaY;
        frame.size.width += deltaX;
        self.frame = frame;
        tmpTouchPoint = touchPoint;
        [self setNeedsDisplay];
    }else if (CGRectContainsPoint(dragPointRMRect, touchPoint)){
        CGRect frame = self.frame;
        frame.size.width += deltaX;
        self.frame = frame;
        tmpTouchPoint = touchPoint;
        [self setNeedsDisplay];
    }else if (CGRectContainsPoint(dragPointBRRect, touchPoint)){
        CGRect frame = self.frame;
        frame.size.height += deltaY;
        frame.size.width += deltaX;
        self.frame = frame;
        tmpTouchPoint = touchPoint;
        [self setNeedsDisplay];
    }else if (CGRectContainsPoint(dragPointBMRect, touchPoint)){
        CGRect frame = self.frame;
        frame.size.height += deltaY;
        self.frame = frame;
        tmpTouchPoint = touchPoint;
        [self setNeedsDisplay];
    }else if (CGRectContainsPoint(dragPointBLRect, touchPoint)){
        
    }else if (CGRectContainsPoint(dragPointLMRect, touchPoint)){
        
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (!movedBeforeEnd) {
        self.shouldShowDragPoint = !self.shouldShowDragPoint;
        [self setNeedsDisplay];
    }
}

@end
