//
//  YFStudentOutDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

#import "YFRespoDataArrayModel.h"

@interface YFStudentOutDataModel : YFDataBaseModel

@property(nonatomic, assign)NSUInteger page;

@property(nonatomic, assign)YFRespoDataArrayModel *dataModel;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)Gym *gym;



-(void)getResponseDatashowLoadingOn:(UIView *)superView conditonParam:(NSDictionary *)conditonParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

// 缺勤统计
-(void)getAbsenceResponseDatashowLoadingOn:(UIView *)superView conditonParam:(NSDictionary *)conditonParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getOutRankResponseDatashowLoadingOn:(UIView *)superView conditonParam:(NSDictionary *)conditonParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


@end
