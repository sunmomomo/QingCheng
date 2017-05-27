//
//  YFStudentChooseLatestTimeVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSliderPopViewVC.h"
#import "YFLastestTimeModel.h"

@interface YFStudentChooseLatestTimeVC : YFSliderPopViewVC

/**
 * 包括非 请求的 条件
 */
@property(nonatomic, strong)NSDictionary *conditionsParam;



@property(nonatomic, assign)NSInteger maxCusTimeGapCount;

@property(nonatomic, copy)void(^selectBlock)();

@property(nonatomic, strong)YFLastestTimeModel *selectModel;

@property(nonatomic, strong)NSDictionary *param;

@property(nonatomic, assign)BOOL isHaveToday;
@property(nonatomic, assign)BOOL isHaveCustom;

// 外界传进来
@property(nonatomic, assign)YFIsRegisterTimeType timeType;

@property(nonatomic, copy)NSString *start;
@property(nonatomic, copy)NSString *end;

@end
