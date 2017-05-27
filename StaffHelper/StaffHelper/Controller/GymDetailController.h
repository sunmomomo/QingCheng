//
//  GymDetailController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/3.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

#import "Message.h"

@interface GymDetailController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)BOOL firstIn;

-(void)reloadProSuccessData;

-(void)pushWithMessage:(Message*)message;

@end
