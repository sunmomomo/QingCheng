//
//  YFModifyGymDetailController.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/6.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface YFModifyGymDetailController : MOViewController

// Copy 的gym,用来修改操作
@property(nonatomic, strong)Gym *gym;
// 修改成功后 ，把修改的值 赋值给 origingym
@property(nonatomic, strong)Gym *origingym;

@property(nonatomic, strong)void(^modifySuccess)(id);

@end
