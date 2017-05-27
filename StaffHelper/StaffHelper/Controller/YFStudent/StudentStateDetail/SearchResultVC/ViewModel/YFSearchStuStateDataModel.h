//
//  YFSearchStuStateDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"
#import "Gym.h"
#import "YFRespoDataArrayModel.h"
#import "YFRespoStudentFollowDataModel.h"


@interface YFSearchStuStateDataModel : YFDataBaseModel

@property(nonatomic,assign)BOOL isToday;


@property(nonatomic,strong)YFRespoDataArrayModel *dataMOdel;

@property(nonatomic,strong)YFRespoStudentFollowDataModel *transPerdataModel;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)NSMutableArray *showDataArray;

@property(nonatomic, copy)NSString *searchStr;

@property(nonatomic,copy)NSString *status;

@property(nonatomic, copy)NSString *allMemNum;


- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
