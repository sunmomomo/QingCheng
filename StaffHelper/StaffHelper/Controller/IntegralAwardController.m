//
//  IntegralAwardController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/3.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "IntegralAwardController.h"

#import "QCSwitchCell.h"

#import "QCTextFieldCell.h"

#import "QCKeyboardView.h"

#import "IntegralSettingInfo.h"

#import "KeyboardManager.h"

static NSString *switchIdentifier = @"Switch";

static NSString *textfieldIdentifier = @"TextField";

@interface IntegralAwardController ()<UITableViewDelegate,UITableViewDataSource,QCKeyboardViewDelegate,MOSwitchCellDelegate,QCTextFieldCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@end

@implementation IntegralAwardController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)dealloc
{
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

-(void)createData
{
    
    if (self.setting.start) {
        
        self.startTF.text = self.setting.start;
        
    }
    
    if (self.setting.end) {
        
        self.endTF.text = self.setting.end;
        
    }
    
    if (!self.setting.settingId) {
        
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"积分";
    
    self.rightTitle = @"确定";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[QCSwitchCell class] forCellReuseIdentifier:switchIdentifier];
    
    [self.tableView registerClass:[QCTextFieldCell class] forCellReuseIdentifier:textfieldIdentifier];
    
    [self.view addSubview:self.tableView];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(154))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(100), Height320(40))];
    
    firstLabel.text = @"有效日期";
    
    firstLabel.textColor = UIColorFromRGB(0x999999);
    
    firstLabel.font = AllFont(12);
    
    [tableHeader addSubview:firstLabel];
    
    UIView *tfView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(40), MSW, Height320(40)*2)];
    
    tfView.backgroundColor = UIColorFromRGB(0xffffff);
    
    tfView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    tfView.layer.borderWidth = OnePX;
    
    [tableHeader addSubview:tfView];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.startTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.startTF.placeholder = @"开始日期";
    
    self.startTF.type = QCTextFieldTypeCell;
    
    self.startTF.mustInput = YES;
    
    [tfView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.tag = 101;
    
    startKV.delegate = self;
    
    self.startTF.inputView = startKV;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    startKV.keyboard = self.startDP;
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.startTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.endTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.endTF.placeholder = @"结束日期";

    self.endTF.type = QCTextFieldTypeCell;
    
    self.endTF.mustInput = YES;
    
    self.endTF.noLine = YES;
    
    [tfView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.tag = 102;
    
    endKV.delegate = self;
    
    self.endTF.inputView = endKV;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    endKV.keyboard = self.endDP;
    
    UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), tfView.bottom, Width320(120), Height320(34))];
    
    secLabel.text = @"积分倍数";
    
    secLabel.textColor = UIColorFromRGB(0x999999);
    
    secLabel.font = AllFont(12);
    
    [tableHeader addSubview:secLabel];
    
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    deleteButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    deleteButton.layer.borderWidth = OnePX;
    
    [deleteButton setTitle:@"删除奖励" forState:UIControlStateNormal];
    
    [deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    deleteButton.titleLabel.font = AllFont(14);
    
    [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = deleteButton;
    
}

-(void)deleteClick
{
    
    [[[UIAlertView alloc]initWithTitle:@"删除积分奖励不会影响已发放的积分，确定删除积分奖励？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        [self.view addSubview:hud];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        
        [hud showAnimated:YES];
        
        IntegralSettingInfo *info = [[IntegralSettingInfo alloc]init];
        
        [info deleteAward:self.setting result:^(BOOL success, NSString *error) {
            
            hud.mode = MBProgressHUDModeText;
            
            if (success) {
                
                hud.label.text = @"删除成功";
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return Height320(12);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    return footer;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            
            return self.setting.groupItem.used?2:1;
            
            break;
        case 1:
            
            return self.setting.privateItem.used?2:1;
            
            break;
        case 2:
            
            return self.setting.checkinItem.used?2:1;
            
            break;
        case 3:
            
            return self.setting.chargeItem.used?2:1;
            
            break;
        case 4:
            
            return self.setting.rechargeItem.used?2:1;
            
            break;
            
        default:
            
            return 0;
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        QCSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchIdentifier];
        
        IntegralAwardItem *item;
        
        switch (indexPath.section) {
            case 0:
                
                item = self.setting.groupItem;
                
                cell.aswitch.titleLabel.text = @"团课预约积分奖励";
                
                break;
            case 1:
                
                item = self.setting.privateItem;
                
                cell.aswitch.titleLabel.text = @"私教预约积分奖励";
                
                break;
            case 2:
                
                item = self.setting.checkinItem;
                
                cell.aswitch.titleLabel.text = @"签到积分奖励";
                
                break;
            case 3:
                
                item = self.setting.chargeItem;
                
                cell.aswitch.titleLabel.text = @"新购会员卡";
                
                break;
            case 4:
                
                item = self.setting.rechargeItem;
                
                cell.aswitch.titleLabel.text = @"会员卡续费";
                
                break;
                
            default:
                break;
        }
        
        cell.aswitch.titleLabel.textColor = UIColorFromRGB(0x333333);
        
        cell.aswitch.titleLabel.font = AllFont(14);
        
        cell.aswitch.on = item.used;
        
        cell.aswitch.tag = indexPath.section;
        
        cell.aswitch.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        QCTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textfieldIdentifier];
        
        IntegralAwardItem *item;
        
        switch (indexPath.section) {
            case 0:
                
                item = self.setting.groupItem;
                
                break;
            case 1:
                
                item = self.setting.privateItem;
                
                break;
            case 2:
                
                item = self.setting.checkinItem;
                
                break;
            case 3:
                
                item = self.setting.chargeItem;
                
                break;
            case 4:
                
                item = self.setting.rechargeItem;
                
                break;
                
            default:
                break;
        }
        
        cell.textField.placeholder = @"所得积分=基础积分X";
        
        cell.textField.textColor = UIColorFromRGB(0x999999);
        
        cell.textField.placeholderColor = UIColorFromRGB(0x333333);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(25), Height320(40))];
        
        label.text = @"倍";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = AllFont(14);
        
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        
        cell.textField.rightView = label;
        
        cell.textField.rightViewMode = UITextFieldViewModeAlways;
        
        cell.textField.text = item.times?[NSString formatStringWithFloat:item.times]:@"";
        
        cell.textField.font = AllFont(14);
        
        cell.tag = indexPath.section;
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    IntegralAwardItem *item;
    
    switch (cell.tag) {
        case 0:
            
            item = self.setting.groupItem;
            
            break;
        case 1:
            
            item = self.setting.privateItem;
            
            break;
        case 2:
            
            item = self.setting.checkinItem;
            
            break;
        case 3:
            
            item = self.setting.chargeItem;
            
            break;
        case 4:
            
            item = self.setting.rechargeItem;
            
            break;
            
        default:
            break;
    }
    
    item.used = cell.on;
    
    [self.tableView reloadData];
    
}

-(void)cell:(QCTextFieldCell *)cell textFieldDidChanged:(NSString *)string
{
    
    IntegralAwardItem *item;
    
    switch (cell.tag) {
        case 0:
            
            item = self.setting.groupItem;
            
            break;
        case 1:
            
            item = self.setting.privateItem;
            
            break;
        case 2:
            
            item = self.setting.checkinItem;
            
            break;
        case 3:
            
            item = self.setting.chargeItem;
            
            break;
        case 4:
            
            item = self.setting.rechargeItem;
            
            break;
            
        default:
            break;
    }
    
    item.times = [cell.textField.text floatValue];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    if (keyboardView.tag == 101) {
        
        if (self.endTF.text.length) {
            
            if ([[df dateFromString:[df stringFromDate:self.startDP.date]] timeIntervalSinceDate:[df dateFromString:self.endTF.text]]>0) {
                
                [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        [self.view endEditing:YES];
        
        self.startTF.text = [df stringFromDate:self.startDP.date];
        
    }else{
        
        if (self.startTF.text.length) {
            
            if ([[df dateFromString:[df stringFromDate:self.endDP.date]] timeIntervalSinceDate:[df dateFromString:self.startTF.text]]<0) {
                
                [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        [self.view endEditing:YES];
        
        self.endTF.text = [df stringFromDate:self.endDP.date];
        
    }
    
}

-(void)naviRightClick
{
    
    if (!self.startTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.endTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.setting.groupItem.used && !self.setting.privateItem.used && !self.setting.checkinItem.used && !self.setting.chargeItem.used && !self.setting.rechargeItem.used) {
        
        [[[UIAlertView alloc]initWithTitle:@"请至少选择一项奖励规则" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    NSMutableArray *astricts = [NSMutableArray array];
    
    for (IntegralAwardSetting *setting in self.allSetting.normalAwards) {
        
        if (setting.settingId != self.setting.settingId) {
            
            NSDate *startDate = [df dateFromString:setting.start];
            
            NSDate *endDate = [df dateFromString:setting.end];
            
            if ([[df dateFromString:self.startTF.text] timeIntervalSinceDate:endDate]<=0 && [[df dateFromString:self.endTF.text] timeIntervalSinceDate:startDate]>=0) {
                
                [astricts addObject:[NSString stringWithFormat:@"奖励规则%ld",(long)setting.settingId]];
                
                break;
                
            }else if ([[df dateFromString:self.endTF.text]timeIntervalSinceDate:startDate]>=0 && [[df dateFromString:self.startTF.text] timeIntervalSinceDate:endDate]<=0){
                
                [astricts addObject:[NSString stringWithFormat:@"奖励规则%ld",(long)setting.settingId]];
                
                break;
                
            }
            
        }
        
    }
    
    if (astricts.count) {
        
        NSString *alertStr = [astricts componentsJoinedByString:@"、"];
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"与%@时间冲突，请检查后再提交",alertStr] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.rightButtonEnable = NO;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [hud showAnimated:YES];
    
    self.setting.start = self.startTF.text;
    
    self.setting.end = self.endTF.text;
    
    IntegralSettingInfo *info = [[IntegralSettingInfo alloc]init];
    
    [info uploadAward:self.setting result:^(BOOL success, NSString *error) {
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            hud.label.text = self.setting.settingId?@"修改成功":@"添加成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewControllerAndReloadData];
                
            });
            
        }else{
            
            self.rightButtonEnable = YES;
            
            hud.label.text = error;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

@end
