//
//  TencentStatus.h
//  simple_weibo_test
//
//  Created by 和光 缪 on 12-2-17.
//  Copyright 2012年 Shanghai University. All rights reserved.
//

#import <Foundation/Foundation.h>

enum TCMessageType{
    TC_ORIGINAL = 1,    //原创
    TC_REPRODUCED = 2,  //转发
    TC_DM = 3,          //私信
    TC_REPLY = 4,       //回复
    TC_KONGHUI = 5,     //WHAT'S THE HELL
    TC_MENTION = 6,     //提及
    TC_COMMENT = 7      //评论
};

enum TCMsgStatusType{
    //status:微博状态，0-正常，1-系统删除，2-审核中，3-用户删除，4-根删除
    TC_STATUS_NORMAL = 0,
    TC_STATUS_SYSTEMDEL = 1,
    TC_STATUS_INVESTIGATE = 2,
    TC_STATUS_USERDEL = 3,
    TC_STATUS_ROOTDEL = 4
};

@interface TencentMessage : NSObject
{
    NSString *text;
    NSString *name;     //用户名
    NSString *nick;     //屏显名
    NSString *pictureUrl;
    NSString *headUrl;  //头像地址
    NSString *location;
    NSDate *timestamp;
    TencentMessage *source; //原微博
    enum TCMessageType messageType;
    enum TCMsgStatusType statysType;
    CGFloat cellHeight;//tableView的cell可能的高度
    CGFloat textHeight;
    CGFloat subTextHeight;
}
@property(readwrite, copy) NSString *text, *name, *nick, *pictureUrl, *headUrl, *location;
@property(readwrite, retain)NSDate *timestamp;
@property(readwrite, retain)TencentMessage *source;
@property(readwrite)enum TCMessageType messageType;
@property(readwrite)enum TCMsgStatusType statusType;
@property(readwrite)CGFloat cellHeight,textHeight,subTextHeight;

-(id)initWithJSONDict:(NSDictionary *)data;
//修改text或者source之后必须调用
-(CGFloat)updateCellHeight;

@end
