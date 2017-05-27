//
//  RootController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOTabBarController.h"

@interface RootController : MOTabBarController

@property(nonatomic,assign)BOOL haveNew;

@property(nonatomic,strong)void(^callBack)();

/**
 * 从赛事的 选择场馆页面 进去创建场馆流程，设为YES创建成功后
   会post一个创建成功的通知，不会 回到首页
 */
@property(nonatomic,assign)BOOL isChooseGymToCreatNewGym;

+(RootController*)sharedSliderController;

-(void)createDataResult:(void(^)())result;

-(void)pushGuide;

-(void)pushLogin;

-(void)firstIn;

-(void)reloadPrivilege;

-(void)reloadNoPush;

-(void)reloadMessageData;

-(void)pushWithMessage:(Message*)message;

@end
