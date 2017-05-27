//
//  YFCardDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

@interface YFCardDataModel : YFDataBaseModel

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)NSMutableArray *prepaidMoArray;
@property(nonatomic, strong)NSMutableArray *countArray;
@property(nonatomic, strong)NSMutableArray *timeMoArray;

@property(nonatomic, strong)NSMutableArray *bindCardStuArray;

// 是否是余额不足 页面
@property(nonatomic ,assign)BOOL isNotSuffient;

- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)getBindCardStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym card_id:(NSString *)card_id successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;



@end
