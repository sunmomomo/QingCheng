//
//  ReplyReceivedInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Press : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSURL *URL;

@property(nonatomic,assign)NSInteger pressId;

@end

@interface ReplyReceived : NSObject

@property(nonatomic,copy)NSString *username;

@property(nonatomic,copy)NSString *replyForName;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *reply;

@property(nonatomic,strong)Press *press;

@property(nonatomic,assign)NSInteger replyId;

@property(nonatomic,assign)NSInteger cellHeight;

@property(nonatomic,strong)NSString *time;

@end

@interface ReplyReceivedInfo : NSObject

@property(nonatomic,strong)NSMutableArray *comments;

@property(nonatomic,strong)RequestCallBack callBack;

-(void)requestResult:(RequestCallBack)result;

@end
