//
//  YFBackOfLeaveVC.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBackOfLeaveVC.h"

#import "YFTBSwitchCardPayModel.h"

#import "YFGrayCellModel.h"

#import "YFTBSectionsDataSource.h"

#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFBackOfLeaveCModel.h"

#import "YFDateService.h"

#import "YFHttpService+Extension.h"

@interface YFBackOfLeaveVC ()

@property(nonatomic, strong)YFTBSwitchCardPayModel *validModel;

@end

@implementation YFBackOfLeaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提前销假";
    self.rightTitle = @"确定";
    [self requestData];
}




- (void)requestData
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    
    YFTBSectionsModel *secionomodel1 = [[YFTBSectionsModel alloc] init];
    
    YFBackOfLeaveCModel *leaveModel = [YFBackOfLeaveCModel defaultWithYYModelDic:nil];
    
    leaveModel.leaveDays = [NSString stringWithFormat:@"%ld",(long)[YFDateService calcDaysCurrentToDateString:self.cardRest.start]];

    leaveModel.checkValid = self.card.cardKind.type == CardKindTypeTime?YES:self.card.checkValid;
    if (leaveModel.checkValid) {
        
        NSString *start = [self.card getStartTimeYF];
        NSString *end = [self.card getEndTimeYF];
        
        NSDate *endDate  = [YFDateService getDateFromDateString:end formatString:nil];
        
        NSString *modifyEnd = [YFDateService getDateFromdate:endDate Days:leaveModel.leaveDays.integerValue formating:nil];
        
        leaveModel.originValidDateString = [NSString stringWithFormat:@"%@至%@",start,end];
        leaveModel.backOfLeaveDateString = [NSString stringWithFormat:@"%@至%@",start,modifyEnd];
    }else
    {
        
    }
  
    
    [secionomodel1.dataArray addObject:leaveModel];

    [secionomodel1.dataArray addObject:[YFGrayCellModel defaultWithCellHeght:12]];
    
    YFTBSwitchCardPayModel *validModel = [[YFTBSwitchCardPayModel alloc] init];
    
    validModel.switModel.des = @"是否退费";
    
    self.validModel = validModel;
    
    weakTypesYF
    [validModel.inputModel setChangeValueTYF:^(NSString *moneyStr){
        [weakS checkDataWithMoneyStr:moneyStr];
    }];

    
    [self.view addSubview:validModel.cardView];
    
    validModel.weakTableView = self.baseTableView;
    
    
    
    [dataArray addObject:secionomodel1];
    [dataArray addObject:validModel];
    self.baseDataArray = dataArray;
    [self.baseTableView reloadData];
    
    self.baseTableView.scrollEnabled = NO;
    self.baseTableView.backgroundColor = RGB_YF(246, 246, 246);
    self.view.backgroundColor = self.baseTableView.backgroundColor;
    
    [self checkDataWithMoneyStr:validModel.inputModel.valueStringFY];
}

- (void)checkDataWithMoneyStr:(NSString *)moneyStr
{
    
    if ((moneyStr.length && self.validModel.payWay) || (self.validModel.switModel.on == NO))
    {
        self.navi.rightButton.enabled = YES;
        self.navi.rightButton.alpha = 1.0;
    }
    else
    {
        self.navi.rightButton.enabled = NO;
        self.navi.rightButton.alpha = 0.4;
    }
}


- (void)naviRightClick
{
    Parameters *para = [Parameters instanceYFWithGym:self.gym];
    
    [para setParameter:@"early_stop" forKey:@"method"];
    
    if (self.validModel.switModel.on)
    {
        [para setParameter:@(self.validModel.inputModel.valueStringFY.integerValue) forKey:@"price"];
        [para setParameter:[NSString stringWithFormat:@"%ld",(unsigned long)self.validModel.payWay] forKey:@"charge_type"];
    }
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:@"/api/staffs/%ld/leaves/%ld/",StaffId,(long)self.cardRest.restId]];
    
    weakTypesYF
    [YFHttpService putSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:self.view success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        [weakS showHint:@"修改成功"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostUpdateCardValidTimeSuccessYF object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakS popViewControllerAndReloadData];
        });
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    

}

#pragma mark  代理Model 的设置
-(YFTBBaseDatasource *)dataSourceTBYF
{
    weakTypesYF
    return [YFTBSectionsDataSource tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
    } currentVC:self];
}

-(YFTBSectionsDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionsLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}


@end
