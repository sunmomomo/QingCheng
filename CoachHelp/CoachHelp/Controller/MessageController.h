//
//  MessageController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/18.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "MessageInfo.h"

@interface MessageController : MOViewController

@property(nonatomic,assign)MessageInfoType type;

@property(nonatomic,copy)void(^messageRefresh)();

@end
