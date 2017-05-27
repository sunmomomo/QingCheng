//
//  RootController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//


#import "MOTabBarController.h"

#import "MessageInfo.h"

@interface RootController : MOTabBarController

@property(nonatomic,assign)BOOL haveNew;

@property(nonatomic,strong)void(^callBack)();

-(void)createDataResult:(void(^)())result;

+(RootController*)sharedSliderController;

-(void)pushGuide;

-(void)pushLogin;

-(void)reloadMessageData;

-(void)pushWithMessage:(Message*)message;

-(void)showGuide;

-(void)haveNew:(BOOL)haveNew AtIndex:(NSInteger)index;

@end
