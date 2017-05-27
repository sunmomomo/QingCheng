//
//  CourseGymController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface CourseGymController : MOViewController

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)void(^chooseFinish)();

@property(nonatomic,assign)BOOL isAdd;

@end
