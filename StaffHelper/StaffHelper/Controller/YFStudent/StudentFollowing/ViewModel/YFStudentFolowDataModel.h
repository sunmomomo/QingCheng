//
//  YFStudentFolowDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

#import "Gym.h"

#import "YFRespoStudentFollowDataModel.h"


@interface YFStudentFolowDataModel : YFDataBaseModel

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)NSMutableArray *arrayToday;

@property(nonatomic,strong)NSMutableArray *arrayTransPersent;;


@property(nonatomic,strong)YFRespoStudentFollowDataModel *allDataModel;
@property(nonatomic,strong)YFRespoStudentFollowDataModel *chartSevenDataModel;
@property(nonatomic,strong)YFRespoStudentFollowDataModel *transPerdataModel;


-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getResponseStaticsDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getResponseTransPersentsDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
