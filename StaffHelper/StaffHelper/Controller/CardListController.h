//
//  CardListController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

@interface CardListController : MOViewController

@property(nonatomic ,strong)Gym *gym;

@property(nonatomic ,strong)NSArray *buttonTitlesArray;

@property(nonatomic ,strong)NSArray *classsArray;

// 是否是余额不足 页面
@property(nonatomic ,assign)BOOL isNotSuffient;

@end
