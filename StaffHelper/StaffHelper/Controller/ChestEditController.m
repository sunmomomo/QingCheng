//
//  ChestEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestEditController.h"

#import "QCTextField.h"

#import "ChestChooseAreaController.h"

#import "ChestListInfo.h"

#import "ChestBorrowController.h"

#import "ChestLongBorrowController.h"

@interface ChestEditController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)QCTextField *numberTF;

@property(nonatomic,strong)QCTextField *areaTF;

@property(nonatomic,strong)UIButton *confirmButton;

@end

@implementation ChestEditController

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
    
    if (!self.chest) {
        
        self.chest = [[Chest alloc]init];
        
    }
    
}

-(void)createUI
{
    
    self.title = self.isAdd?@"添加更衣柜":@"编辑更衣柜";
    
    if (!self.isAdd) {
        
        self.rightTitle = @"保存";
        
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*2)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.numberTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.numberTF.placeholder = @"更衣柜号";
    
    self.numberTF.mustInput = YES;
    
    self.numberTF.textPlaceholder = @"必填";
    
    self.numberTF.delegate = self;
    
    if (self.chest.name) {
        
        self.numberTF.text = self.chest.name;
        
    }
    
    if (self.isAdd) {
        
        [self.numberTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    [topView addSubview:self.numberTF];
    
    self.areaTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.numberTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.areaTF.placeholder = @"更衣柜区域";
    
    self.areaTF.mustInput = YES;
    
    self.areaTF.textPlaceholder = @"必选";
    
    self.areaTF.delegate = self;
    
    self.areaTF.noLine = YES;
    
    if (self.chest.area.areaName) {
        
        self.areaTF.text = self.chest.area.areaName;
        
    }
    
    self.areaTF.type = QCTextFieldTypeCell;
    
    [topView addSubview:self.areaTF];
    
    if (self.isAdd) {
        
        self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
        
        self.confirmButton.backgroundColor = kMainColor;
        
        self.confirmButton.layer.cornerRadius = Width320(2);
        
        [self.confirmButton setTitle:@"完成" forState:UIControlStateNormal];
        
        [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        self.confirmButton.titleLabel.font = AllFont(14);
        
        [self.view addSubview:self.confirmButton];
        
        [self.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.numberTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [self check];
        
    }else{
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(40))];
        
        deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        deleteButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        deleteButton.layer.borderWidth = OnePX;
        
        [deleteButton setTitle:@"删除该更衣柜" forState:UIControlStateNormal];
        
        [deleteButton setTitleColor:UIColorFromRGB(0xEA6161) forState:UIControlStateNormal];
        
        deleteButton.titleLabel.font = AllFont(14);
        
        [self.view addSubview:deleteButton];
        
        [deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    [self check];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (self.isAdd || (!self.isAdd&&[PermissionInfo sharedInfo].gym.permissions.lockerPermission.editState)) {
        
        if (textField == self.areaTF) {
            
            ChestChooseAreaController *svc = [[ChestChooseAreaController alloc]init];
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(ChestArea*area){
                
                weakS.chest.area = area;
                
                weakS.areaTF.text = area.areaName;
                
                [weakS check];
                
            };
            
            if (self.chest.area.areaId) {
                
                svc.area = self.chest.area;
                
            }
            
            [self.navigationController pushViewController:svc animated:YES];
            
            return NO;
            
        }else{
            
            return YES;
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
        return NO;
        
    }
    
}

-(void)confirm:(UIButton*)button
{
    
    if (self.numberTF.text.length && self.chest.area.areaId) {
        
        button.userInteractionEnabled = NO;
        
        self.chest.name = self.numberTF.text;
        
        ChestListInfo *info = [[ChestListInfo alloc]init];
        
        [info createChest:self.chest result:^(BOOL success, NSString *error) {
            
            button.userInteractionEnabled = YES;
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"创建成功";
                
                [hud showAnimated:YES];
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"ChestListController"]) {
                        
                        [vc reloadData];
                        
                    }
                    
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }else if (!self.numberTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请填写更衣柜号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请选择更衣柜区域" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)delete:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].gym.permissions.lockerPermission.deleteState) {
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定删除更衣柜%@",self.chest.name] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        ChestListInfo *info = [[ChestListInfo alloc]init];
        
        [info deleteChest:self.chest result:^(BOOL success, NSString *error) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"删除成功";
                
                [hud showAnimated:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popToViewControllerName:@"ChestListController" isReloadData:YES];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)naviRightClick
{
    
    if (self.numberTF.text.length && self.chest.area.areaId) {
        
        self.rightButtonEnable = NO;
        
        self.chest.name = self.numberTF.text;
        
        ChestListInfo *info = [[ChestListInfo alloc]init];
        
        [info editChest:self.chest result:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"修改成功";
                
                [hud showAnimated:YES];
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"ChestListController"]) {
                        
                        [vc reloadData];
                        
                    }else if ([vc isKindOfClass:[ChestBorrowController class]]){
                        
                        Chest *chest = ((ChestBorrowController*)vc).chest;
                        
                        chest.chestId = self.chest.chestId;
                        
                        chest.name = self.chest.name;
                        
                        chest.area = self.chest.area;
                        
                    }else if ([vc isKindOfClass:[ChestLongBorrowController class]]){
                        
                        Chest *chest = ((ChestLongBorrowController*)vc).chest;
                        
                        chest.chestId = self.chest.chestId;
                        
                        chest.name = self.chest.name;
                        
                        chest.area = self.chest.area;
                        
                    }
                    
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }else if (!self.numberTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请填写更衣柜号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请选择更衣柜区域" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)check
{
    
    if (self.numberTF.text.length && self.areaTF.text.length) {
        
        self.confirmButton.alpha = 1;
        
    }else{
        
        self.confirmButton.alpha = 0.4;
        
    }
    
}

@end
