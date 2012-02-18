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

@synthesize subNameLabel,msgTextLabel,subPicture,subMsgTextLabel,headImage,nameLabel,picture,message;


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
        subMsgTextLabel = [[UILabel alloc]init];
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
    if(message.source != [NSNull null]){
        subNameLabel.text = message.source.nick;
        subMsgTextLabel.text = message.source.text;
    }
}

-(void)updateFrames
{
    CGPoint tempPoint;
    headImage.frame = CGRectMake(8, 20, 40, 40);
    nameLabel.frame = CGRectMake(56, 27, 255, 14);
    CGSize msgTextSize = [msgTextLabel.text sizeWithFont:msgTextLabel.font constrainedToSize:CGSizeMake(255, 2000) lineBreakMode:UILineBreakModeWordWrap];
    msgTextLabel.frame = CGRectMake(56, 49, msgTextSize.width, msgTextSize.height);
    tempPoint.x = 56;
    tempPoint.y = 49+msgTextSize.height;
    if ((NSNull *)message.pictureUrl != [NSNull null]) {
        picture.frame = CGRectMake(tempPoint.x, tempPoint.y +=8, 200, 150);
        tempPoint.y += 150;
    }else
    {
        picture.image = nil;
    }
    //还没做sub tweet初始化
    [self addSubview:headImage];
    [self addSubview:nameLabel];
    [self addSubview:msgTextLabel];
    [self addSubview:picture];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, message.cellHeight);
    return;
}

+(CGFloat)calculateCellHeightWithText:(NSString *)text Source:(TencentMessage *)message HasImage:(BOOL)hasImage
{
    //namelabel.height+msgtextlabel.height+picture.height+total_blank
    CGSize msgTextSize = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(255, 2000) lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = 14+msgTextSize.height+55;
    if(hasImage){
        height += (150+20);
    }
    return height;
    
    //还没做sub tweet部分计算
}

- (void)dealloc {
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
