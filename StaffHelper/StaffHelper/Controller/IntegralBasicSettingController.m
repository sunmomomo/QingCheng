//
//  IntegralBasicSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralBasicSettingController.h"

#import "IntegralSettingInfo.h"

#import "QCSwitchCell.h"

#import "QCTextFieldCell.h"

#import "IntegralBasicSettingCell.h"

#import "IntegralSettingAddController.h"

static NSString *switchIdentifier = @"Switch";

static NSString *textIdentifier = @"Text";

static NSString *awardIdentifier = @"Award";

@interface IntegralBasicSettingController ()<UITableViewDelegate,UITableViewDataSource,MOSwitchCellDelegate,QCTextFieldCellDelegate,IntegralBasicSettingCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation IntegralBasicSettingController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    if (self.firstIn) {
        
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    }
    
}

-(void)createData
{
    
    
    
}

-(void)createUI
{
    
    self.title = @"基础积分";
    
    self.rightTitle = @"保存";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[QCSwitchCell class] forCellReuseIdentifier:switchIdentifier];
    
    [self.tableView registerClass:[QCTextFieldCell class] forCellReuseIdentifier:textIdentifier];
    
    [self.tableView registerClass:[IntegralBasicSettingCell class] forCellReuseIdentifier:awardIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return self.setting.groupSetting.used?2:1;
        
    }else if (section == 1){
        
        return self.setting.privateSetting.used?2:1;
        
    }else if (section == 2){
        
        return self.setting.checkinSetting.used?2:1;
        
    }else if (section == 3){
        
        return self.setting.chargeUsed?self.setting.chargeSettings.count+1:1;
        
    }else{
        
        return self.setting.rechargeUsed?self.setting.rechargeSettings.count+1:1;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return Height320(36);
        
    }else{
        
        return Height320(12);
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section >= 3) {
        
        if (section == 3 && !self.setting.chargeUsed) {
            
            return 0;
            
        }
        
        if (section == 4 && !self.setting.rechargeUsed) {
            
            return 0;
            
        }
        
        return Height320(40);
        
    }else{
        
        return 0;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        return Height320(40);
        
    }else if (indexPath.section<3){
        
        return Height320(40);
        
    }else{
        
        IntegralCardSetting *setting = indexPath.section == 3?self.setting.chargeSettings[indexPath.row-1]:self.setting.rechargeSettings[indexPath.row-1];
        
        NSString *str = [NSString stringWithFormat:@"实收金额%@至%@元\n每1元得%@积分",[NSString formatStringWithFloat:setting.fromPrice],[NSString formatStringWithFloat:setting.toPrice],[NSString formatStringWithFloat:setting.integral]];
        
        CGSize size = [str boundingRectWithSize:CGSizeMake(Width320(258), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
        
        return size.height+Height320(30);
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(36))];
        
        view.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), Height320(36))];
        
        label.text = @"基础积分设置";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(12);
        
        [view addSubview:label];
        
        return view;
        
    }else{
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
        
        view.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        return view;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section<3) {
        
        return nil;
        
    }else{
        
        if (section == 3 && !self.setting.chargeUsed) {
            
            return nil;
            
        }
        
        if (section == 4 && !self.setting.rechargeUsed) {
            
            return nil;
        
        }
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
        
        button.backgroundColor = UIColorFromRGB(0xffffff);
        
        button.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        button.layer.borderWidth = OnePX;
        
        button.titleLabel.font = AllFont(14);
        
        [button setTitle:@"+  添加规则" forState:UIControlStateNormal];
        
        [button setTitleColor:kMainColor forState:UIControlStateNormal];
        
        button.tag = section;
        
        [button addTarget:self action:@selector(addCardSetting:) forControlEvents:UIControlEventTouchUpInside];
        
        return button;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        QCSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchIdentifier];
        
        cell.aswitch.titleLabel.textColor = UIColorFromRGB(0x33333);
        
        switch (indexPath.section) {
                
            case 0:
                
                cell.aswitch.titleLabel.text = @"团课预约积分";
                
                cell.aswitch.on = self.setting.groupSetting.used;
                
                cell.aswitch.noLine = !self.setting.groupSetting.used;
                
                break;
                
            case 1:
                
                cell.aswitch.titleLabel.text = @"私教预约积分";
                
                cell.aswitch.on = self.setting.privateSetting.used;
                
                cell.aswitch.noLine = !self.setting.privateSetting.used;
                
                break;
                
            case 2:
                
                cell.aswitch.titleLabel.text = @"签到积分";
                
                cell.aswitch.on = self.setting.checkinSetting.used;
                
                cell.aswitch.noLine = !self.setting.checkinSetting.used;
                
                break;
                
            case 3:
                
                cell.aswitch.titleLabel.text = @"新购会员卡积分";
                
                cell.aswitch.on = self.setting.chargeUsed;
                
                break;
                
            case 4:
                
                cell.aswitch.titleLabel.text = @"会员卡续费积分";
                
                cell.aswitch.on = self.setting.rechargeUsed;
                
                break;
                
            default:
                break;
                
        }
    
        cell.aswitch.tag = indexPath.section;
        
        cell.aswitch.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.section <= 2){
        
        QCTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textIdentifier];
        
        cell.textField.placeholderColor = UIColorFromRGB(0x333333);
        
        switch (indexPath.section) {
            case 0:
                
                cell.textField.placeholder = @"每次预约团课积分";
                
                cell.textField.text = self.setting.groupSetting.integral?[NSString formatStringWithFloat:self.setting.groupSetting.integral]:@"";
                
                break;
            case 1:
                
                cell.textField.placeholder = @"每次预约私教积分";
                
                cell.textField.text = self.setting.privateSetting.integral?[NSString formatStringWithFloat:self.setting.privateSetting.integral]:@"";
                
                break;
            case 2:
                
                cell.textField.placeholder = @"每次签到积分";
                
                cell.textField.text = self.setting.checkinSetting.integral?[NSString formatStringWithFloat:self.setting.checkinSetting.integral]:@"";
                
                break;
                
            default:
                break;
        }
        
        cell.tag = indexPath.section;
        
        cell.delegate = self;
        
        cell.textField.noLine = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        IntegralBasicSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:awardIdentifier];
        
        IntegralCardSetting *setting = indexPath.section == 3?self.setting.chargeSettings[indexPath.row-1]:self.setting.rechargeSettings[indexPath.row-1];
        
        cell.title = [NSString stringWithFormat:@"实收金额%@至%@元\n每1元得%@积分",[NSString formatStringWithFloat:setting.fromPrice],[NSString formatStringWithFloat:setting.toPrice],[NSString formatStringWithFloat:setting.integral]];
        
        cell.delegate = self;
        
        cell.noLine = indexPath.section == 3?indexPath.row == self.setting.chargeSettings.count:indexPath.row == self.setting.rechargeSettings.count;
        
        cell.indexPath = indexPath;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
}

-(void)deleteCell:(IntegralBasicSettingCell *)cell
{
    
    if (cell.indexPath.section == 3) {
        
        [self.setting.chargeSettings removeObjectAtIndex:cell.indexPath.row-1];
        
        [self.tableView deleteRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }else{
        
        [self.setting.rechargeSettings removeObjectAtIndex:cell.indexPath.row-1];
        
        [self.tableView deleteRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if (cell.tag == 0) {
        
        self.setting.groupSetting.used = cell.on;
        
        if (!cell.on) {
            
            self.setting.groupSetting.integral = 0;
            
        }
        
    }else if (cell.tag == 1){
        
        self.setting.privateSetting.used = cell.on;
        
        if (!cell.on) {
            
            self.setting.privateSetting.integral = 0;
            
        }
        
    }else if(cell.tag == 2){
        
        self.setting.checkinSetting.used = cell.on;
        
        if (!cell.on) {
            
            self.setting.checkinSetting.integral = 0;
            
        }
        
    }else if (cell.tag == 3){
        
        self.setting.chargeUsed = cell.on;
        
        if (!cell.on) {
            
            [self.setting.chargeSettings removeAllObjects];
            
        }
        
    }else{
        
        self.setting.rechargeUsed = cell.on;
        
        if (!cell.on) {
            
            [self.setting.rechargeSettings removeAllObjects];
            
        }
        
    }
    
    [self.tableView reloadData];
    
}

-(void)addCardSetting:(UIButton*)button
{
    
    IntegralSettingAddController *svc = [[IntegralSettingAddController alloc]init];
    
    svc.isRecharge = button.tag != 3;
    
    svc.settings = button.tag == 3?self.setting.chargeSettings:self.setting.rechargeSettings;
    
    __weak typeof(self)weakS = self;
    
    svc.setFinish = ^(IntegralCardSetting*setting){
        
        if (button.tag == 3) {
            
            [weakS.setting.chargeSettings addObject:setting];
            
        }else{
            
            [weakS.setting.rechargeSettings addObject:setting];
            
        }
        
        [weakS.tableView reloadData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)cell:(QCTextFieldCell *)cell textFieldDidChanged:(NSString *)string
{
    
    IntegralCourseSetting *setting = cell.tag == 0?self.setting.groupSetting:cell.tag == 1?self.setting.privateSetting:self.setting.checkinSetting;
    
    setting.integral = [string floatValue];
    
}

-(void)naviRightClick
{
    
    if (self.setting.groupSetting.used || self.setting.privateSetting.used || self.setting.checkinSetting.used || self.setting.chargeUsed || self.setting.rechargeUsed) {
        
        if (self.setting.chargeUsed && !self.setting.chargeSettings.count) {
            
            [[[UIAlertView alloc]initWithTitle:@"请至少添加一个购卡积分" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }else if (self.setting.rechargeUsed && !self.setting.rechargeSettings.count){
            
            [[[UIAlertView alloc]initWithTitle:@"请至少添加一个续费积分" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        self.rightButtonEnable = NO;
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        [self.view addSubview:hud];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        
        [hud showAnimated:YES];
        
        IntegralSettingInfo *info = [[IntegralSettingInfo alloc]init];
        
        [info uploadBasicSetting:self.setting result:^(BOOL success, NSString *error) {
            
            hud.mode = MBProgressHUDModeText;
            
            if (success) {
                
                hud.label.text = @"修改成功";
                
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
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请至少设置一项基础积分" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        IntegralSettingInfo *info = [[IntegralSettingInfo alloc]init];
        
        [info changeUsed:NO result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [self popToViewControllerName:@"IntegralListController" isReloadData:YES];
                
            }
            
        }];
        
    }
    
}

-(void)naviLeftClick
{
    
    if (self.firstIn){
        
        [[[UIAlertView alloc]initWithTitle:@"是否放弃对基础积分的设置" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

@end
