//
//  YFStudentOutVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentOutVC.h"

#import "YFStudentOutTrendDesModel.h"

#import "YFStudentOutDataModel.h"

#import "YFStudentOutChartCModel.h"

#import "YFDateService.h"

#import "YFStudentOutDownModel.h"

#import "YFGrayCellModel.h"

#import "YFConditionLatestTimePopView.h"

#import "YFAbsenceStatisticVC.h"

#import "YFStudentOutRankVC.h"



@interface YFStudentOutVC ()

@property(nonatomic, strong)YFStudentOutDataModel *dataModel;

@property(nonatomic, strong)YFStudentOutDownModel *absenceModel;

@property(nonatomic, strong)YFStudentOutDownModel *outModel;

@property(nonatomic, strong)YFStudentOutTrendDesModel *studentOutTrendDesModel;


@end

@implementation YFStudentOutVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.classsArray = @[[YFConditionLatestTimePopView class]];
        self.popViewFrame = CGRectMake(0, 110, MSW, MSH - 100);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员出勤";
    self.canGetMore = NO;
    self.showPopView = self.popViewsArray.firstObject;
    self.baseTableView.backgroundColor = YFGrayViewColor;
//    self.baseTableView.bounces = NO;
//    [self refreshTableListDataNoPull];
    [self setRefreshHeadViewYF];
}



- (void)requestData
{
    NSArray *dateArray = [self.allParam objectForKey:@"DateArray"];

    if (dateArray) {
        if (dateArray.count == 7) {
            [self.studentOutTrendDesModel setDesStrToButton:@"最近7天"];
        }else
        {
            [self.studentOutTrendDesModel setDesStrToButton:@"最近30天"];
        }
    }
    
    weakTypesYF
    self.dataModel.gym = self.gym;
    [self.dataModel getResponseDatashowLoadingOn:nil conditonParam:self.allParam successBlock:^{
        
        weakTypesYF
        [weakS.dataModel.dataArray insertObject:self.studentOutTrendDesModel atIndex:0];
        
        [weakS.dataModel.dataArray addObject:self.absenceModel];
        [weakS.dataModel.dataArray addObject:self.outModel];
        
        [weakS requestSuccessArray:weakS.dataModel.dataArray];
    } failBlock:^{
        [weakS failRequest:nil];
    }];
}

- (YFStudentOutDataModel *)dataModel
{
    if (_dataModel == nil) {
        _dataModel = [YFStudentOutDataModel dataModel];
    }
    return _dataModel;
}

- (YFStudentOutTrendDesModel *)studentOutTrendDesModel
{
    if (_studentOutTrendDesModel == nil) {
        weakTypesYF
        YFStudentOutTrendDesModel *model = [YFStudentOutTrendDesModel defaultWithYYModelDic:nil selectBlock:^(id model) {
            
            [weakS.showPopView showOrHide];
        }];
        _studentOutTrendDesModel = model;

    }
    return _studentOutTrendDesModel;
}

- (YFStudentOutDownModel *)absenceModel
{
    if (_absenceModel == nil) {
        weakTypesYF
        YFStudentOutDownModel *downModel1 = [YFStudentOutDownModel defaultWithYYModelDic:nil selectBlock:^(YFStudentOutDownModel *model) {
            
            YFAbsenceStatisticVC *absenVC = [[YFAbsenceStatisticVC alloc] init];
            absenVC.gym = weakS.gym;
            [weakS.navigationController pushViewController:absenVC animated:YES];
            
        }];
        downModel1.status = @"1";
        _absenceModel = downModel1;
    }
    return _absenceModel;
}

- (YFStudentOutDownModel *)outModel
{
    if (_outModel == nil) {
        weakTypesYF
        YFStudentOutDownModel *downModel2 = [YFStudentOutDownModel defaultWithYYModelDic:nil selectBlock:^(YFStudentOutDownModel *model){
            YFStudentOutRankVC *absenVC = [[YFStudentOutRankVC alloc] init];
            absenVC.gym = weakS.gym;
            [weakS.navigationController pushViewController:absenVC animated:YES];
        }];
        downModel2.status = @"2";
        _outModel = downModel2;
    }
    return _outModel;
}

@end
