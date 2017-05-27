//
//  YFSearchResultStudentStateVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultStudentVC.h"

@interface YFSearchResultStudentStateVC : YFSearchResultStudentVC

@property(nonatomic,weak)UIViewController *parentVCYF;

//#warning 没有了
@property(nonatomic,assign)BOOL isToday;
@property(nonatomic,copy)NSString *status;

@property(nonatomic, strong)NSMutableArray *dataArrayFromFilterData;

@end
