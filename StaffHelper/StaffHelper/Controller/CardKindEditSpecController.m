//
//  CardKindEditSpecController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindEditSpecController.h"

#import "QCTextField.h"

#import "MOCell.h"

#import "MOSwitchCell.h"

#import "SummaryController.h"

#import "SpecListInfo.h"

@interface CardKindEditSpecController ()<UITextFieldDelegate,MOSwitchCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)QCTextField *payTF;

@property(nonatomic,strong)QCTextField *receiveTF;

@property(nonatomic,strong)QCTextField *validTF;

@property(nonatomic,strong)MOSwitchCell *setValidCell;

@property(nonatomic,strong)MOSwitchCell *createCell;

@property(nonatomic,strong)MOSwitchCell *rechargeCell;

@property(nonatomic,strong)MOSwitchCell *staffCell;

@property(nonatomic,strong)MOCell *summaryCell;

@property(nonatomic,strong)UILabel *hintLabel;

@property(nonatomic,strong)UIView *secondView;

@property(nonatomic,strong)UIView *thirdView;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,strong)SpecListInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CardKindEditSpecController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [[SpecListInfo alloc]init];
    
}

-(void)createUI
{
    
    self.title = self.isAdd?@"添加规格":@"规格详情";
    
    self.rightTitle = self.isAdd?@"":@"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*2)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    self.payTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.payTF.placeholder = [@"充值" stringByAppendingString:self.spec.cardKind.type == CardKindTypePrepaid?@"（元）":self.spec.cardKind.type == CardKindTypeTime?@"（天）":@"（次）"];
    
    self.payTF.mustInput = YES;
    
    self.payTF.delegate = self;
    
    self.payTF.text = self.spec.charge;
    
    [topView addSubview:self.payTF];
    
    self.receiveTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.payTF.left, self.payTF.bottom, self.payTF.width, self.payTF.height)];
    
    self.receiveTF.placeholder = @"实收（元）";
    
    self.receiveTF.mustInput = YES;
    
    self.receiveTF.noLine = YES;
    
    self.receiveTF.delegate = self;
    
    self.receiveTF.text = self.spec.price;
    
    [topView addSubview:self.receiveTF];
    
    if (self.spec.cardKind.type != CardKindTypeTime) {
        
        self.secondView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, self.spec.checkValid?Height320(80):Height320(40))];
        
        self.secondView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.secondView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.secondView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [self.view addSubview:self.secondView];
        
        self.setValidCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.setValidCell.titleLabel.text = @"设置有效期";
        
        self.setValidCell.noLine = !self.spec.checkValid;
        
        self.setValidCell.delegate = self;
        
        self.setValidCell.on = self.spec.checkValid;
        
        [self.secondView addSubview:self.setValidCell];
        
        self.validTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.setValidCell.bottom, MSW-Width320(32), Height320(40))];
        
        self.validTF.placeholder = @"有效期天数（天）";
        
        self.validTF.noLine = YES;
        
        self.validTF.delegate = self;
        
        self.validTF.hidden = !self.spec.checkValid;
        
        self.validTF.text = [NSString stringWithInteger:self.spec.validTime];
        
        [self.secondView addSubview:self.validTF];
        
    }
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, self.spec.cardKind.type != CardKindTypeTime?self.secondView.bottom+Height320(12):topView.bottom+Height320(12), MSW, Height320(40)*4)];
    
    self.thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.thirdView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:self.thirdView];
    
    self.createCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.createCell.titleLabel.text = @"用于新购卡";
    
    self.createCell.on = self.spec.canCreate;
    
    self.createCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    if (self.isAdd) {
        
        self.createCell.on = YES;
        
    }
    
    [self.thirdView addSubview:self.createCell];
    
    self.rechargeCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(self.createCell.left, self.createCell.bottom, self.createCell.width, self.createCell.height)];
    
    self.rechargeCell.titleLabel.text = @"用于充值";
    
    self.rechargeCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.rechargeCell.on = self.spec.canRecharge;
    
    if (self.isAdd) {
        
        self.rechargeCell.on = YES;
        
    }
    
    [self.thirdView addSubview:self.rechargeCell];
    
    self.staffCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(self.rechargeCell.left, self.rechargeCell.bottom, self.rechargeCell.width, self.rechargeCell.height)];
    
    self.staffCell.titleLabel.text = @"仅工作人员可见";
    
    self.staffCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.staffCell.on = self.spec.onlyStaffCanSee;
    
    [self.thirdView addSubview:self.staffCell];
    
    self.summaryCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), self.staffCell.bottom, self.createCell.width, self.createCell.height)];
    
    self.summaryCell.titleLabel.text = @"说明";
    
    self.summaryCell.placeholder = @"选填";
    
    self.summaryCell.noLine = YES;
    
    self.summaryCell.subtitle = self.spec.summary;
    
    [self.summaryCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.thirdView addSubview:self.summaryCell];
    
    if (self.isAdd) {
        
        self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.thirdView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
        
        self.confirmButton.backgroundColor = kMainColor;
        
        self.confirmButton.layer.cornerRadius = 2;
        
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        self.confirmButton.titleLabel.font = AllFont(14);
        
        [self.view addSubview:self.confirmButton];
        
        [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
    }else
    {
        
        if (AppGym && self.spec.cardKind.gyms.count>1 && !AppOneGym) {
            
            self.hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), self.thirdView.bottom+Height320(5), MSW-Width320(24), Height320(100))];
            
            self.hintLabel.textColor = UIColorFromRGB(0x999999);
            
            self.hintLabel.font = AllFont(12);
            
            self.hintLabel.numberOfLines = 0;
            
            self.hintLabel.autoSizeText = @"*该会员卡种类适用于多个场馆，请到连锁运营中进行修改。";
            
            [self.view addSubview:self.hintLabel];
            
        }else if(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.spec.cardKind.gyms andPermission:[PermissionInfo sharedInfo].permissions.cardKindPermission andType:PermissionTypeEdit]!= PermissionStateAll){
            
            self.hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), self.thirdView.bottom+Height320(5), MSW-Width320(24), Height320(100))];
            
            self.hintLabel.textColor = UIColorFromRGB(0x999999);
            
            self.hintLabel.font = AllFont(14);
            
            self.hintLabel.numberOfLines = 0;
            
            self.hintLabel.autoSizeText = @"*此会员卡种类适用于多个场馆，仅在所有适用场馆下都具有编辑会员卡种类权限的用户才能进行编辑。";
            
            [self.view addSubview:self.hintLabel];
            
        }
        
        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.hintLabel?self.hintLabel.bottom+Height320(10):self.thirdView.bottom+Height320(12), MSW, Height320(40))];
        
        self.deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.deleteButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.deleteButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [self.deleteButton setTitle:@"删除该会员卡规格" forState:UIControlStateNormal];
        
        [self.deleteButton setTitleColor:UIColorFromRGB(0xEA6161) forState:UIControlStateNormal];
        
        self.deleteButton.titleLabel.font = AllFont(14);
        
        [self.view addSubview:self.deleteButton];
        
        [self.deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (!self.isAdd && ((AppGym && self.spec.cardKind.gyms.count>1)||(!AppGym &&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.spec.cardKind.gyms andPermission:[PermissionInfo sharedInfo].permissions.cardKindPermission andType:PermissionTypeEdit]!= PermissionStateAll))) {
        
        self.payTF.userInteractionEnabled = self.receiveTF.userInteractionEnabled = self.validTF.userInteractionEnabled = self.setValidCell.userInteractionEnabled = self.createCell.userInteractionEnabled = self.rechargeCell.userInteractionEnabled = self.summaryCell.userInteractionEnabled = NO;

    }
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    self.hud.mode = MBProgressHUDModeText;
    
}

-(void)confirm
{
    
    if (!self.payTF.text.length || !self.receiveTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"信息填写不完全" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.spec.charge = self.payTF.text;
    
    self.spec.price = self.receiveTF.text;
    
    if (self.spec.cardKind.type != CardKindTypeTime) {
        
        self.spec.checkValid = self.setValidCell.on;
        
        self.spec.validTime = [self.validTF.text integerValue];
        
    }
    
    self.spec.canCreate = self.createCell.on;
    
    self.spec.canRecharge = self.rechargeCell.on;
    
    self.spec.onlyStaffCanSee = self.staffCell.on;
    
    self.spec.summary = self.summaryCell.subtitle;
    
    if (self.isAdd) {
        
        [self.info createSpec:self.spec result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.label.text = @"添加成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (self.editFinish) {
                        
                        self.editFinish();
                        
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }
            
        }];
        
    }else
    {
        
        [self.info changeSpec:self.spec result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.label.text = @"修改成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (self.editFinish) {
                        
                        self.editFinish();
                        
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }
            
        }];
        
    }
    
}

-(void)delete
{
    
    Permission *permission = [PermissionInfo sharedInfo].permissions.cardKindPermission;
    
    UIAlertView *alert;
    
    if ((!AppGym&&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.spec.cardKind.gyms andPermission:permission andType:PermissionTypeEdit] != PermissionStateAll)||(AppGym&&!permission.editState)) {
        
        alert = [[UIAlertView alloc]initWithTitle:@"无删除权限" message:@"此会员卡种类适用于多个场馆，仅在所有适用场馆下都具有编辑会员卡种类权限的用户才能进行编辑。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        
    }else{
        
        alert = [[UIAlertView alloc]initWithTitle:@"确定删除该会员卡规格？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        
    }
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [self.info deleteSpec:self.spec result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.label.text = @"删除成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (self.editFinish) {
                        
                        self.editFinish();
                        
                    }
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }
            
        }];
        
    }
    
}


-(void)cellClick:(MOCell *)cell{

    if (cell == self.summaryCell) {
        
        SummaryController *svc = [[SummaryController alloc]init];
        
        svc.placeholder = @"填写会员卡规格的说明信息";
        
        svc.text = self.spec.summary;
        
        __weak typeof(self)weakS = self;
        
        svc.summaryFinish = ^(NSString *summary){
        
            weakS.summaryCell.subtitle = summary;
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    [self.secondView changeHeight:cell.on?Height320(80):Height320(40)];
    
    self.validTF.hidden = !cell.on;
    
    self.setValidCell.noLine = !cell.on;
    
    [self.thirdView changeTop:self.secondView.bottom+Height320(12)];
 
    [self.isAdd?self.confirmButton:self.deleteButton changeTop:self.thirdView.bottom+Height320(12)];
    
}

-(void)naviRightClick
{
    
    [self confirm];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    return YES;
    
}


@end
