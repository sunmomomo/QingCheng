
//
//  YFModifyCardValidTimeVC.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFModifyCardValidTimeVC.h"

#import "YFChooseTimeModel.h"

#import "YFGrayCellModel.h"

#import "YFDesSwitchCModel.h"

#import "YFDesSwitchCell.h"

#import "YFTBSectionsModel.h"

#import "YFTBSwitchCardPayModel.h"

#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFTBSectionsDataSource.h"

#import "YFTBSwitchCardPayModel.h"

#import "YFDateService.h"

#import "YFPayStyleModel.h"

#import "YFTBSwitchValidTimeModel.h"

#import "YFDateService.h"

#import "Parameters.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFHttpService+Extension.h"

#import "UIView+YFLoadAniView.h"

#import "Parameters+YFExtension.h"

@interface YFModifyCardValidTimeVC ()

@property(nonatomic, strong)YFChooseTimeModel *startTimeModel;
@property(nonatomic, strong)YFChooseTimeModel *endTimeModel;

@property(nonatomic, strong)YFTBSwitchCardPayModel *validModel;


@property(nonatomic, strong)YFTBSwitchValidTimeModel *validTimeModel;

@end

@implementation YFModifyCardValidTimeVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isCanTurnOffDateSwitch = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
   self.rightTitle = @"确定";
   self.title = @"修改会员卡有效期";
    
    [self requestData];
    
    [self checkDataWithMoneyStr:@""];
}


- (void)requestData
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    YFTBSwitchValidTimeModel *secionomodel1 = [[YFTBSwitchValidTimeModel alloc] init];
    self.validTimeModel = secionomodel1;
    
    secionomodel1.weakTableView = self.baseTableView;
    secionomodel1.switModel.des = @"有效期";

    secionomodel1.switModel.isCanTurnOffDateSwitch = self.isCanTurnOffDateSwitch;
    
    secionomodel1.switModel.on   = self.isValidtTime;
//    if (secionomodel1.switModel.on == NO)
//    {
//        secionomodel1.switModel.edgeInsets  = UIEdgeInsetsMake(0,0, 0, 0);
//    }
//    else
//    {
//        secionomodel1.switModel.edgeInsets  = UIEdgeInsetsMake(0,15, 0, 15);
//    }

    
    
//    [secionomodel1.dataArray addObject:[YFGrayCellModel defaultWithCellHeght:40 title:@"有效期"]];
    if (self.isValidtTime)
    {
        self.startTimeModel.timeStr = self.start;
        self.endTimeModel.timeStr = self.end;
    }
    [secionomodel1.dataArray addObject:self.startTimeModel];
    [secionomodel1.dataArray addObject:self.endTimeModel];

    [secionomodel1.dataArray addObject:[YFGrayCellModel defaultWithCellHeght:12]];

    YFTBSwitchCardPayModel *validModel = [[YFTBSwitchCardPayModel alloc] init];
    
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


- (YFChooseTimeModel *)startTimeModel
{
    if (!_startTimeModel)
    {
        _startTimeModel = [YFChooseTimeModel defaultWithDic:nil];
        
        _startTimeModel.timeDesStr = @"开始日期";
        
        [_startTimeModel setScaleHeight];

        _startTimeModel.timeStr = [YFDateService getTodayDate:@"yyyy-MM-dd"];
        
        _startTimeModel.desColor = RGB_YF(153, 153, 153);
        
        _startTimeModel.edgeInsets  = UIEdgeInsetsMake(0,15, 0, 15);

    }
    return _startTimeModel;
}

- (YFChooseTimeModel *)endTimeModel
{
    if (!_endTimeModel)
    {
        _endTimeModel = [YFChooseTimeModel defaultWithYYModelDic:nil];
        
        [_endTimeModel setScaleHeight];
        
        _endTimeModel.timeDesStr = @"结束日期";
        
        _endTimeModel.timeStr = [YFDateService getTodayDate:@"yyyy-MM-dd"];
        
        _endTimeModel.desColor = RGB_YF(153, 153, 153);
    }
    return _endTimeModel;
}
- (void)setSwitchOfNotification:(YFDesSwitchCModel *)model
{
//    YFDesSwitchCell *cell = (YFDesSwitchCell *)model.weakCell;
//    
//#warning !!!!!
//    cell.switchOfCell.enabled = NO;
//    
//    cell.switchOfCell.enabled = YES;
//    NSString *value;
//    if (model.on)
//    {
//        value = @"1";
//    }
//    else
//    {
//        value = @"0";
//    }
//    
//    DebugLogYF(@"%@",value);
}


-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    NSDateFormatter *df = [YFDateService dateformatter];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    YFStudentChooseTimeCell *startCell = (YFStudentChooseTimeCell *)self.startTimeModel.weakCell;
    
    YFStudentChooseTimeCell *endCell = (YFStudentChooseTimeCell *)self.endTimeModel.weakCell;
    
    if ([keyboadeView isEqual:startCell.startKV]){
        
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:startCell.startDP.date]] timeIntervalSinceDate:[df dateFromString:endCell.startTimeTF.text]];
        
        if (timeInterval>0 && endCell.startTimeTF.text.length > 0) {
            
            [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        else
        {
            startCell.startTimeTF.text = [df stringFromDate:startCell.startDP.date];
            self.startTimeModel.timeStr = startCell.startTimeTF.text;
            [self.view endEditing:YES];
        }
        
    }else if([keyboadeView isEqual:endCell.startKV])
    {
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:endCell.startDP.date]] timeIntervalSinceDate:[df dateFromString:startCell.startTimeTF.text]];
        
        if (timeInterval<0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            endCell.startTimeTF.text = [df stringFromDate:endCell.startDP.date];
            self.endTimeModel.timeStr = endCell.startTimeTF.text;
            
            [self.view endEditing:YES];
            
        }
        
    }
    
}

- (void)naviRightClick
{
    Parameters *para = [Parameters instanceYFWithGym:self.gym];
    
    
    if (self.validTimeModel.switModel.on)
    {
        [para setParameter:@"1" forKey:@"check_valid"];
        [para setParameter:self.startTimeModel.timeStr forKey:@"valid_from"];
        [para setParameter:self.endTimeModel.timeStr forKey:@"valid_to"];
    }else
    {
    [para setParameter:@"0" forKey:@"check_valid"];
    }
    
    if (self.validModel.switModel.on)
    {
        [para setParameter:self.validModel.inputModel.valueStringFY forKey:@"price"];
        [para setParameter:[NSString stringWithFormat:@"%ld",(unsigned long)self.validModel.payWay] forKey:@"charge_type"];
    }
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:@"/api/staffs/%ld/cards/%ld/change-date/",StaffId,self.cardId]];
    
    self.view.loadViewYF.frame = CGRectMake(0, 64, MSW, MSH - 64.0);
    weakTypesYF
    [YFHttpService putSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:self.view success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        [weakS showHint:@"修改成功"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostUpdateCardValidTimeSuccessYF object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakS.navigationController popViewControllerAnimated:YES];
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
