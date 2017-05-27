//
//  ChestAreaEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestAreaEditController.h"

#import "QCTextField.h"

#import "ChestAreaListInfo.h"

@interface ChestAreaEditController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)QCTextField *nameTF;

@end

@implementation ChestAreaEditController

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
    
    if (self.isAdd) {
        
        self.area = [[ChestArea alloc]init];
        
    }
    
}

-(void)createUI
{
    self.title = self.isAdd?@"添加新区域":@"编辑区域";
    
    self.rightTitle = self.isAdd?@"确定":@"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"区域名称";
    
    self.nameTF.noLine = YES;
    
    self.nameTF.delegate = self;
    
    if (self.area) {
        
        self.nameTF.text = self.area.areaName;
        
    }
    
    [topView addSubview:self.nameTF];
    
    if (!self.isAdd) {
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(40))];
        
        deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        deleteButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        deleteButton.layer.borderWidth = OnePX;
        
        [deleteButton setTitle:@"删除该区域" forState:UIControlStateNormal];
        
        [deleteButton setTitleColor:UIColorFromRGB(0xEA6161) forState:UIControlStateNormal];
        
        deleteButton.titleLabel.font = AllFont(14);
        
        [self.view addSubview:deleteButton];
        
        [deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    return YES;
    
}

-(void)delete:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].gym.permissions.lockerPermission.deleteState) {
        
        [[[UIAlertView alloc]initWithTitle:@"确定删除该区域？" message:@"注意：删除更衣柜区域以后，区域下的所有更衣柜都将被删除。如果想修改更衣柜区域名称请使用编辑功能。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (self.isAdd||(!self.isAdd&&[PermissionInfo sharedInfo].gym.permissions.lockerPermission.editState)) {
        
        return YES;
        
    }else{
        
        [self showNoPermissionAlert];
        
        return NO;
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        ChestAreaListInfo *info = [[ChestAreaListInfo alloc]init];
        
        [info deleteArea:self.area result:^(BOOL success, NSString *error) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"删除成功";
                
                [hud showAnimated:YES];
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"ChestAreaListController"] || [NSStringFromClass([vc class])isEqualToString:@"ChestChooseAreaController"] || [NSStringFromClass([vc class]) isEqualToString:@"ChestListController"]) {
                        
                        [vc reloadData];
                        
                        break;
                        
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
        
    }
    
}

-(void)naviRightClick
{
    
    if (!self.nameTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写区域名称" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.area.areaName = self.nameTF.text;
    
    self.rightButtonEnable = NO;
    
    if (self.isAdd) {
        
        ChestAreaListInfo *info = [[ChestAreaListInfo alloc]init];
        
        [info createArea:self.area result:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"创建成功";
                
                [hud showAnimated:YES];
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"ChestAreaListController"] || [NSStringFromClass([vc class])isEqualToString:@"ChestChooseAreaController"] || [NSStringFromClass([vc class]) isEqualToString:@"ChestListController"]) {
                        
                        [vc reloadData];
                        
                        break;
                        
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
        
    }else{
        
        ChestAreaListInfo *info = [[ChestAreaListInfo alloc]init];
        
        [info editArea:self.area result:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"修改成功";
                
                [hud showAnimated:YES];
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"ChestAreaListController"] || [NSStringFromClass([vc class])isEqualToString:@"ChestChooseAreaController"] || [NSStringFromClass([vc class]) isEqualToString:@"ChestListController"]) {
                        
                        [vc reloadData];
                        
                        break;
                        
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
        
    }
    
}

@end
