//
//  YFOutRankDaysVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFOutRankDaysVC.h"

#import "YFOutRandDaysCModel.h"

#import "YFTBSectionLineEdgeDelegate.h"

@interface YFOutRankDaysVC ()

@end

@implementation YFOutRankDaysVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navi removeFromSuperview];
    [self requestData];
}

- (void)requestData
{
    NSArray *titles= @[@"出勤天数",@"签到次数",@"团课节数",@"私教节数"];
    
    NSArray *order_byKey= @[@"days",@"checkin",@"group",@"private"];
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i ++) {
        
        NSString *strKey = order_byKey[i];
        NSString *str = titles[i];
        YFOutRandDaysCModel *model = [YFOutRandDaysCModel defaultWithYYModelDic:nil selectBlock:^(id model) {
            
        }];
       
        model.valueStr = str;
        model.keyStr = strKey;
        [dataArray addObject:model];
    }
    
    
    YFOutRandDaysCModel *model = dataArray.lastObject;
    model.edgeInsets = UIEdgeInsetsZero;
    
    YFOutRandDaysCModel *firstModel = dataArray.firstObject;
    firstModel.isSelected = YES;
    _selelctModel = firstModel;
    self.baseDataArray = dataArray;
    [self.baseTableView reloadData];
    
}

- (void)setSelelctModel:(YFOutRandDaysCModel *)selelctModel
{
    if (_selelctModel && [_selelctModel isEqual:selelctModel] == NO) {
        _selelctModel.isSelected = NO;
    }
    _selelctModel = selelctModel;
    [self.baseTableView reloadData];
    self.param = _selelctModel.param;
    self.title = _selelctModel.valueStr;
    if (self.selectBlock) {
        self.selectBlock(nil);
    }
    
}


-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}

- (NSDictionary *)param
{
    return self.selelctModel.param;
}

@end
