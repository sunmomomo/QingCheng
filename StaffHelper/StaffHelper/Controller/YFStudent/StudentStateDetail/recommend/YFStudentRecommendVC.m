//
//  YFStudentRecommendVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentRecommendVC.h"
#import "YFStudentRightDataModel.h"
#import "YFStudentFilterRePeoModel.h"

@interface YFStudentRecommendVC ()

@property(nonatomic,strong)YFStudentRightDataModel *dataModel;


@end

@implementation YFStudentRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.canGetMore = NO;
    [self.navi removeFromSuperview];
    
    [self refreshTableListDataNoPull];
    [self setRefreshHeadViewYF];
}

- (void)requestData
{
    weakTypesYF
    [self.dataModel getResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
        
        YFStudentFilterRePeoModel *model = [YFStudentFilterRePeoModel defaultWithDic:nil];
        model.isAll = YES;
        if (!weakS.selectModel) {
        model.isSelected = YES;
        _selectModel = model;
        }else
        {
            for (YFStudentFilterRePeoModel *model in weakS.dataModel.reArray) {
                if (model.r_id.integerValueYF == weakS.selectModel.r_id.integerValueYF) {
                    _selectModel = model;
                    model.isSelected = YES;
                }
            }
        }
        
        [weakS.dataModel.reArray insertObject:model atIndex:0];
        
        [weakS requestSuccessArray:weakS.dataModel.reArray];
    } failBlock:^{
        [weakS failRequest:nil];
    }];

}

- (YFStudentRightDataModel *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [[YFStudentRightDataModel alloc] init];
        _dataModel.isFilter = YES;
    }
    return _dataModel;
}

-(void)emptyDataReminderAction
{
    
}


-(void)setSelectModel:(YFStudentFilterRePeoModel *)selectModel
{
    if (_selectModel && [_selectModel isEqual:selectModel] == NO) {
        _selectModel.isSelected = NO;
    }
    _selectModel = selectModel;
    [self.baseTableView reloadData];
    
    if (self.selectBlock) {
        self.selectBlock();
    }
}


@end
