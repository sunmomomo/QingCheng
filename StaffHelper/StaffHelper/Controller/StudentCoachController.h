//
//  StudentCoachController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/5/3.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface StudentCoachController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Student *student;

@property(nonatomic,assign)BOOL isEdit;

@property(nonatomic,copy)void(^chooseFinish)(NSArray *coaches);

@property(nonatomic,copy)void(^editFinish)();

@end
