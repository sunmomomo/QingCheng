//
//  Message.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/18.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

@interface Message : NSObject

@property(nonatomic,assign)NSInteger msgId;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *place;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)BOOL readed;

@end
