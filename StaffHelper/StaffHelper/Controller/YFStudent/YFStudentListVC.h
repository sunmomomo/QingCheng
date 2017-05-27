//
//  YFStudentListVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "Gym.h"
#import "YFSliderViewController.h"
#import "YFStudentListRightVC.h"


@interface YFStudentListVC : YFBaseRefreshTBExtensionVC

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,weak)YFSliderViewController *sliderVC;
@property(nonatomic,weak)YFStudentListRightVC *rightVC;



@property(nonatomic, strong)NSArray *dataArray;

@property(nonatomic, copy)void(^headerActionBlock)(NSUInteger);

@property(nonatomic,copy)void(^sureBlock)();


@end


