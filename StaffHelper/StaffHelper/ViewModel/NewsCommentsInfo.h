//
//  NewsCommentsInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ReplyReceivedInfo.h"

#import "User.h"

@interface NewsComment : NSObject

@property(nonatomic,strong)User *user;

@property(nonatomic,strong)User *replyUser;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)NSInteger commentId;

@property(nonatomic,copy)NSString *replyContent;

@property(nonatomic,assign)NSInteger cellHeight;

@end

@interface NewsCommentsInfo : NSObject

@property(nonatomic,assign)NSInteger totalCount;

@property(nonatomic,strong)NSMutableArray *comments;

@property(nonatomic,strong)RequestCallBack callBack;

-(void)requestWithPress:(Press*)press result:(RequestCallBack)result;

-(void)replyPress:(Press*)press withText:(NSString *)text withComment:(NewsComment*)comment result:(RequestCallBack)result;

@end
