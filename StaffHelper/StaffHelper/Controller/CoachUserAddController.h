//
//  CoachUserAddController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSellerFilterBaseVC.h"

@class UserChooseView;
@class MOTableView;

@interface CoachUserAddController : YFSellerFilterBaseVC

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)UserChooseView *chooseView;
@property(nonatomic,strong)MOTableView *tableView;
@property(nonatomic,strong)NSMutableArray *chooseArray;

@property(nonatomic,strong)Gym *gym;

-(void)checkFunc;

@end
