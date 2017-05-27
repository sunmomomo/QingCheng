//
//  YFMesNotiSettingVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFMesNotiSettingVC.h"

#import "YFDesSwitchCModel.h"

#import "YFSelectArrowCModel.h"

#import "YFGrayCellModel.h"

#import "YFAutomicRemindVC.h"

#import "CheckinNotificationController.h"

#import "YFTBSectionLineEdgeDelegate.h"

#import "YFMesNotiSettingDataModel.h"

#import "YFGrayTitleExCModel.h"

#import "YFDesSwitchCell.h"

@interface YFMesNotiSettingVC ()

@property(nonatomic, strong)YFMesNotiSettingDataModel *dataModel;

@property(nonatomic ,strong)YFDesSwitchCModel *switModel;

@property(nonatomic,strong)CheckinNotificationInfo *info;

@property(nonatomic,strong)YFSelectArrowCModel *notificationModel;

@end

@implementation YFMesNotiSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息推送设置";
    [self refreshTableListDataNoPull];
    self.baseTableView.bounces = NO;
    self.baseTableView.backgroundColor =  YFGrayViewColor;
}


- (void)requestData
{
    
    weakTypesYF
    [self.dataModel getSuffientShopsNotiSettingshowLoadingOn:nil gym:nil successBlock:^{
        
        [weakS showData];
        
    } failBlock:^{
        [weakS failRequest:nil];
    }];
  
    
   
}

- (void)showData
{
    weakTypesYF
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    YFGrayCellModel *grayModel = [YFGrayCellModel defaultWithCellHeght:Height320(12)];
    
    
    YFDesSwitchCModel *switModel = [YFDesSwitchCModel defaultWithYYModelDic:nil selectBlock:^(id model){
        [weakS setSwitchOfNotification:model];
    }];
    self.switModel = switModel;
    switModel.des = @"会员卡余额不足通知";
    
    switModel.on = self.dataModel.model.value.boolValue;
    
    
//    YFSelectArrowCModel *arrowModel = [YFSelectArrowCModel defaultWithYYModelDic:nil selectBlock:^{
//        YFAutomicRemindVC *automicReVC = [[YFAutomicRemindVC alloc] init];
//        
//        [weakS.navigationController pushViewController:automicReVC animated:YES];
//    }];
//    
//    arrowModel.desColor = RGB_YF(153, 153, 153);
//    arrowModel.des = @"查看当前自动提醒设置";
    
    
   YFGrayTitleExCModel *titleGrayModel =  [YFGrayTitleExCModel defaultWithCellHeght:53 title:@"您的名下会员收到提醒短信后，APP将同时发送系统通知给您"];
    
    
    YFSelectArrowCModel *arrowModel2 = self.notificationModel;
    
    
    [dataArray addObject:grayModel];
    [dataArray addObject:switModel];
    [dataArray addObject:titleGrayModel];
    [dataArray addObject:arrowModel2];
    
    [self requestSuccessArray:dataArray];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CheckinNotificationInfo *info = [[CheckinNotificationInfo alloc]init];
    weakTypesYF
    [info requsetDataResult:^(BOOL success, NSString *error) {
        weakS.info = info;
        weakS.notificationModel.desValue = [NSString stringWithFormat:@"%@家场馆通知",@(weakS.info.recieveNotifiCount)];
        [weakS.baseTableView reloadData];
    }];
}



- (YFSelectArrowCModel *)notificationModel
{
    if (!_notificationModel)
    {
        weakTypesYF
        _notificationModel = [YFSelectArrowCModel defaultWithYYModelDic:nil selectBlock:^(id model){
            
            CheckinNotificationController *svc = [[CheckinNotificationController alloc]init];
            svc.info = weakS.info;
            [weakS.navigationController pushViewController:svc animated:YES];
            
        }];
        
        _notificationModel.des = @"签到/签出通知";
    }
    return _notificationModel;
}

- (void)setSwitchOfNotification:(YFDesSwitchCModel *)model
{
    
    YFDesSwitchCell *cell = (YFDesSwitchCell *)self.switModel.weakCell;

    cell.switchOfCell.enabled = NO;
    
    NSString *value;
    if (self.switModel.on)
    {
        value = @"1";
    }else
    {
        value = @"0";
    }
    
    weakTypesYF
    [self.dataModel putSuffientShopsNotiSettingshowLoadingOn:nil gym:nil value:value successBlock:^{
        cell.switchOfCell.enabled = YES;
    } failBlock:^{
        cell.switchOfCell.enabled = YES;
        if ([value isEqualToString:@"1"]) {
            model.on = NO;
        }else
        {
            model.on = YES;
        }
        [weakS.baseTableView reloadData];
    }];
}

- (YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}

- (YFMesNotiSettingDataModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [YFMesNotiSettingDataModel dataModel];
    }
    return _dataModel;
}


@end
