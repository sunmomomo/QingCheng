//
//  MeasureEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Measure.h"

#import "MeasureDetailInfo.h"

@interface MeasureEditController : MOViewController

@property(nonatomic,strong)Student *stu;

@property(nonatomic,strong)MeasureDetailInfo *info;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,strong)Gym *gym;

@end
