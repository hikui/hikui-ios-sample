//
//  StatusCell.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-18.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TencentMessage;

@interface StatusCell : UITableViewCell
{
    UIImageView *headImage;
    UIImageView *picture;
    UILabel *nameLabel;
    UILabel *msgTextLabel;
    UILabel *subNameLabel;
    UILabel *subMsgTextLabel;
    UIImageView *subPicture;
    TencentMessage *message;
}


@property (nonatomic, retain) UIImageView *headImage, *picture, *subPicture;
@property (nonatomic, retain) UILabel *msgTextLabel, *nameLabel, *subNameLabel, *subMsgTextLabel;
@property (readwrite, retain) TencentMessage *message;
+(CGFloat)calculateCellHeightWithText:(NSString *)text Source:(TencentMessage *)message HasImage:(BOOL)hasImage;

-(void)updateMessage:(TencentMessage *)aMessage;
-(void)updateFrames;

@end
