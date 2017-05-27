//
//  LoginController.h
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/10.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController

@property(nonatomic,assign)BOOL pushGuide;

@property(nonatomic,assign)BOOL webLogin;

@property(nonatomic,copy)void(^webLoginSuccess)();

@property(nonatomic,assign)NSInteger loginOrRegister;//登录或注册,0为登录，1为注册

@end
