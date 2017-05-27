//
//  YFModifAutomicRemindVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFModifAutomicRemindVC.h"

#import "YFTBSectionsDataSource.h"

#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFDesSwitchCModel.h"

#import "YFDesSwitchCell.h"

#import "YFGrayCellModel.h"

#import "YFTBSwitchValueSectionsModel.h"

#import "YFInputValueCModel.h"

#import "NSMutableDictionary+YFExtension.h"

#import "UIView+YFLoadAniView.h"

#import "YFAppService.h"

#import "YFInputValueCell.h"

/*
 请填写储值卡余额少于多少元时提醒会员
 请填写次卡余额少于多少次时提醒会员
 请填写会员卡有效期少于多少天时提醒会员
 
 如果有多条未填写，仅提醒一条
 */

@interface YFModifAutomicRemindVC ()

@end

@implementation YFModifAutomicRemindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改自动提醒设置";
    
    [self refreshTableListDataNoPull];
    self.baseTableView.backgroundColor = YFGrayViewColor;
    self.canGetMore = NO;
    
    self.rightTitle = @"保存";
    self.rightColor = YFSelectedButtonColor;
}

- (void)naviRightClick
{
    if (self.baseDataArray.count < 3) {
        return;
    }
    YFTBSwitchValueSectionsModel *secionomodel1 = self.baseDataArray[0];
    YFTBSwitchValueSectionsModel *secionomodel2 = self.baseDataArray[1];
    YFTBSwitchValueSectionsModel *secionomodel3 = self.baseDataArray[2];
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    NSMutableArray *paramArray = [NSMutableArray array];

    [paraDic setObject:paramArray forKey:@"configs"];
    
    // 打开时 不能填空
    if ([self setObjec:secionomodel1 toParam:paramArray idModel:self.automicRemindShopDataModel.remindPayModel] == NO) {
        [YFAppService showAlertMessage:@"请填写储值卡余额少于多少元时提醒会员" onlySureBlock:^{
            [((YFInputValueCell *)secionomodel1.inputModel.weakCell).valueTF becomeFirstResponder];
        }];
        return;
    }
    if ([self setObjec:secionomodel2 toParam:paramArray idModel:self.automicRemindShopDataModel.timesModel] == NO) {
        [YFAppService showAlertMessage:@"请填写次卡余额少于多少次时提醒会员" onlySureBlock:^{
            [((YFInputValueCell *)secionomodel2.inputModel.weakCell).valueTF becomeFirstResponder];
        }];
        return;
    }
    
    if ([self setObjec:secionomodel3 toParam:paramArray idModel:self.automicRemindShopDataModel.timeModel] == NO) {
        [YFAppService showAlertMessage:@"请填写会员卡有效期少于多少天时提醒会员" onlySureBlock:^{
            [((YFInputValueCell *)secionomodel3.inputModel.weakCell).valueTF becomeFirstResponder];
        }];
        return;
    }
    
    
    
    
    
    weakTypesYF
    [self.automicRemindShopDataModel putSuffientShopsSettingStudentshowLoadingOn:self.view gym:self.gym param:paraDic successBlock:^{
        
        [weakS putSuccess];
        
    } failBlock:^{
        [weakS showHint:@"网络不给力"];
    }];
    
}

- (void)putSuccess
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    YFTBSwitchValueSectionsModel *secionomodel1 = self.baseDataArray[0];
//    YFTBSwitchValueSectionsModel *secionomodel2 = self.baseDataArray[1];
//    YFTBSwitchValueSectionsModel *secionomodel3 = self.baseDataArray[2];
//    
//    
//    [self setObjec:secionomodel1 toBeforecVCModel:self.automicRemindShopDataModel.remindPayModel];
//    [self setObjec:secionomodel2 toBeforecVCModel:self.automicRemindShopDataModel.timesModel];
//    [self setObjec:secionomodel3 toBeforecVCModel:self.automicRemindShopDataModel.timeModel];
//    
//    [self.automicRemindShopDataModel reloaData];
}

- (void)setObjec:(YFTBSwitchValueSectionsModel *)model toBeforecVCModel:(YFAutomicRemindCModel *)remindModel
{
    if (model.switModel.on)
    {
        remindModel.value = model.inputModel.valueStringFY;
    }
    remindModel.value = model.inputModel.valueStringFY;
}

- (BOOL)setObjec:(YFTBSwitchValueSectionsModel *)model toParam:(NSMutableArray *)paramArray idModel:(YFAutomicRemindCModel *)idModel
{
    NSString *valueString;
    if (model.switModel.on)
    {
        if (model.inputModel.valueStringFY.length <= 0)
        {
            return NO;
        }
        valueString = model.inputModel.valueStringFY;
    }else
    {
        valueString = @"";
    }
    NSMutableDictionary *subDicInput = [NSMutableDictionary dictionary];
    
    [subDicInput setObje_FY:idModel.re_id toKey:@"id"];
   
    [subDicInput setObject:valueString forKey:@"value"];
        
    [paramArray addObject:subDicInput];
        
    

    
    NSMutableDictionary *subDic = [NSMutableDictionary dictionary];

    [subDic setObje_FY:idModel.valueSwitchId toKey:@"id"];
    
    if (model.switModel.on) {
        [subDic setObje_FY:@"1" toKey:@"value"];

    }else
    {
        [subDic setObje_FY:@"0" toKey:@"value"];
    }

    
    [paramArray addObject:subDic];
    
    return YES;
}

- (void)requestData
{
    NSMutableArray *allSectionA = [NSMutableArray array];
    
    
    YFTBSwitchValueSectionsModel *secionomodel1 = [[YFTBSwitchValueSectionsModel alloc] init];
    secionomodel1.weakTableView = self.baseTableView;
    YFTBSwitchValueSectionsModel *secionomodel2 = [[YFTBSwitchValueSectionsModel alloc] init];
    secionomodel2.weakTableView = self.baseTableView;
    YFTBSwitchValueSectionsModel *secionomodel3 = [[YFTBSwitchValueSectionsModel alloc] init];
    secionomodel3.weakTableView = self.baseTableView;
    
    YFGrayCellModel *cellModel = [YFGrayCellModel defaultWithCellHeght:12.0];
    
    secionomodel1.switModel.on = self.automicRemindShopDataModel.remindPayModel.isOpen;
    
    secionomodel1.inputModel.conditionName = @"储值卡余额少于（元）";
    secionomodel1.inputModel.valueStringFY = self.automicRemindShopDataModel.remindPayModel.value;
    secionomodel1.switModel.des = @"储值卡余额不足时提醒会员";
    
    [secionomodel1.dataArray insertObject:cellModel atIndex:0];
   

    

    secionomodel2.switModel.on = self.automicRemindShopDataModel.timesModel.isOpen;
    secionomodel2.switModel.des = @"次卡余额不足时提醒会员";
    secionomodel2.inputModel.conditionName = @"次卡余额少于（次）";
    secionomodel2.inputModel.valueStringFY = self.automicRemindShopDataModel.timesModel.value;
    
    [secionomodel2.dataArray insertObject:cellModel atIndex:0];
   
    secionomodel3.switModel.des = @"会员卡有效期到期前提醒会员";
    secionomodel3.switModel.on = self.automicRemindShopDataModel.timeModel.isOpen;

    secionomodel3.inputModel.conditionName = @"会员卡有效期少于（天）";
    secionomodel3.inputModel.valueStringFY = self.automicRemindShopDataModel.timeModel.value;

    [secionomodel3.dataArray insertObject:cellModel atIndex:0];
    
    [allSectionA addObject:secionomodel1];
    [allSectionA addObject:secionomodel2];
    [allSectionA addObject:secionomodel3];
    
    [self requestSuccessArray:allSectionA];
}





//#pragma mark  代理Model 的设置
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
