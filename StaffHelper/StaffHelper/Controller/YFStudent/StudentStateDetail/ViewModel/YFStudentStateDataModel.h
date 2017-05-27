//
//  YFStudentStateDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

#import "Gym.h"

#import "YFRespoDataArrayModel.h"

#import "YFRespoStudentFollowDataModel.h"

#import "YFTransPersentModel.h"

#import "YFFolloSubUpCModel.h"

@interface YFStudentStateDataModel : YFDataBaseModel

@property(nonatomic, strong)NSMutableDictionary *allConditionParam;

@property(nonatomic, strong)NSMutableDictionary *allConditionParamForStatic;


@property(nonatomic, assign)NSUInteger page;

@property(nonatomic, copy)NSString *allMemNum;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)YFRespoDataArrayModel *dataMOdel;

@property(nonatomic,strong)YFRespoDataArrayModel *transPerdataModel;


@property(nonatomic,strong)NSMutableArray *showDataArray;

@property(nonatomic,strong)NSMutableArray *showStudentDataForTransArray;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,assign)BOOL isToday;
@property(nonatomic,assign)BOOL isSattics;

@property(nonatomic, strong)YFFolloSubUpCModel *subUpCModel;

// 会员转化
@property(nonatomic, strong)YFTransPersentModel *tranSperModel;



-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;
- (void)getResponseDataStaticshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getResponseTransPersentsDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
