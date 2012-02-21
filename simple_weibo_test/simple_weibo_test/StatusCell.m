//
//  StatusCell.m
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-18.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import "StatusCell.h"
#import "TencentMessage.h"


@implementation StatusCell

@synthesize subNameLabel,msgTextLabel,subPicture,subMsgTextLabel,headImage,nameLabel,picture,message,subView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        msgTextLabel = [[UILabel alloc]init];
        msgTextLabel.font = [UIFont systemFontOfSize:14];
        msgTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        msgTextLabel.numberOfLines = 0;
        picture = [[UIImageView alloc]init];
        headImage = [[UIImageView alloc]init];
        subPicture = [[UIImageView alloc]init];
        subNameLabel = [[UILabel alloc]init];
        subNameLabel.font = [UIFont systemFontOfSize:14];
        subMsgTextLabel = [[UILabel alloc]init];
        subMsgTextLabel = [[UILabel alloc]init];
        subMsgTextLabel.font = [UIFont systemFontOfSize:14];
        subMsgTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        subMsgTextLabel.numberOfLines = 0;
        subView = [[UIView alloc]init];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)updateMessage:(TencentMessage *)aMessage
{
    self.message = aMessage;
    nameLabel.text = message.nick;
    msgTextLabel.text = message.text;
    msgTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    msgTextLabel.font = [UIFont systemFontOfSize:14];
    if((NSNull *)message.source != [NSNull null]){
        subNameLabel.text = message.source.nick;
        subMsgTextLabel.text = message.source.text;
    }
}

-(void)updateFrames
{
    CGPoint tempPoint;
    headImage.frame = CGRectMake(8, 20, 40, 40);
    nameLabel.frame = CGRectMake(56, 27, 255, 14);
    msgTextLabel.frame = CGRectMake(56, 49, 255, message.textHeight);
    tempPoint.x = 56;
    tempPoint.y = 49+message.textHeight;
    if ((NSNull *)message.pictureUrl != [NSNull null]) {
        picture.frame = CGRectMake(tempPoint.x, tempPoint.y +=8, 200, 150);
        tempPoint.y += 150;
    }else{
        picture.image = nil;
    }
    if ((NSNull *)message.source != [NSNull null]) {
        tempPoint.y += 15;//用来绘制subView
        CGPoint tempPoint2;
        subNameLabel.frame = CGRectMake(tempPoint2.x = 6, tempPoint2.y = 5, 242, 18);
        tempPoint2.y+=20;
        subMsgTextLabel.frame = CGRectMake(tempPoint2.x, tempPoint2.y, 242, message.subTextHeight);
        tempPoint2.y += message.subTextHeight;
        if((NSNull *)message.source.pictureUrl != [NSNull null]){
            subPicture.frame = CGRectMake(tempPoint2.x, tempPoint2.y += 8, 200, 150);
            tempPoint2.y += 150;
        }
        subView.frame = CGRectMake(tempPoint.x, tempPoint.y, 255, tempPoint2.y+5);
        [subView addSubview:subNameLabel];
        [subView addSubview:subMsgTextLabel];
        [subView addSubview:subPicture];
        [self addSubview:subView];
    }
    [self addSubview:headImage];
    [self addSubview:nameLabel];
    [self addSubview:msgTextLabel];
    [self addSubview:picture];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, message.cellHeight);
    return;
}

+(void)updateMyTextHeightAndSubTextHeightAndCellHeight:(TencentMessage *)aMessage
{
    CGSize msgTextSize = [aMessage.text sizeWithFont:[UIFont systemFontOfSize:14]constrainedToSize:CGSizeMake(255, 2000) lineBreakMode:UILineBreakModeWordWrap];
    aMessage.textHeight = msgTextSize.height;
    CGFloat height = 14+msgTextSize.height+55;
    if((NSNull *)aMessage.pictureUrl != [NSNull null]){
        height += (150+20);//高度+margin_top
    }
    if((NSNull *)aMessage.source != [NSNull null]){
        //计算子微博的高度
        height += 15; // 子视图的margin_top
        msgTextSize = [aMessage.source.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(242, 2000) lineBreakMode:UILineBreakModeWordWrap];
        aMessage.subTextHeight = msgTextSize.height;
        height += msgTextSize.height;
        if((NSNull *)aMessage.source.pictureUrl != [NSNull null]){
            height += (150+20);
        }
    }
    aMessage.cellHeight = height;
}

//+(CGFloat)calculateCellHeightWithText:(NSString *)text Source:(TencentMessage *)source HasImage:(BOOL)hasImage
//{
//    //namelabel.height+msgtextlabel.height+picture.height+空白部分综合
//    CGSize msgTextSize = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(255, 2000) lineBreakMode:UILineBreakModeWordWrap];
//    CGFloat height = 14+msgTextSize.height+55;
//    if(hasImage){
//        height += (150+20);//高度+margin_top
//    }
//    
//    if((NSNull *)source != [NSNull null]){
//        //计算子微博的高度
//        height += 15; // 子视图的margin_top
//        msgTextSize = [source.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(242, 2000) lineBreakMode:UILineBreakModeWordWrap];
//        height += msgTextSize.height;
//        if((NSNull *)source.pictureUrl != [NSNull null]){
//            height += (150+20);
//        }
//    }
//    
//    return height;
//    
//}

- (void)dealloc {
    [subView release];
    [subNameLabel release];
    [msgTextLabel release];
    [subPicture release];
    [subMsgTextLabel release];
    [headImage release];
    [nameLabel release];
    [picture release];
    [message release];
    [super dealloc];
}

@end
