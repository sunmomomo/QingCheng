//
//  ChatModel.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChatHeader.h"

@interface ChatModel : NSObject

@property(nonatomic,strong)User *user;

@property(nonatomic,assign)ChatType type;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,copy)NSURL *imageThumbURL;

@property(nonatomic,assign)NSInteger imageHeight;

@property(nonatomic,assign)NSInteger voiceLength;

@property(nonatomic,copy)NSString *voicePath;

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,assign)BOOL isMine;

@property(nonatomic,assign)float cellHeight;

@property(nonatomic,assign)BOOL unRead;

@property(nonatomic,assign)NSInteger tag;

@end
