//
//  YardEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YardEditController.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "MOPickerView.h"

@interface YardEditController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)QCTextField *typeTF;

@property(nonatomic,strong)NSArray *typeArray;

@property(nonatomic,strong)MOPickerView *typePV;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)YardListInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation YardEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.typeArray = @[@"私教课",@"团课",@"不限"];
        
        self.yard = [[Yard alloc]init];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [[YardListInfo alloc]init];
    
}

-(void)createUI
{
    
    self.title = self.isAdd?@"添加场地":@"场地详情";
    
    if (!self.isAdd) {
        
        self.rightTitle = @"保存";
        
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*3)];
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"名称";
    
    self.nameTF.delegate = self;
    
    self.nameTF.text = self.yard.name;
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.nameTF];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.capacityTF.placeholder = @"可容纳人数";
    
    self.capacityTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.capacityTF.delegate = self;
    
    self.capacityTF.text = self.yard.capacity?[NSString stringWithInteger:self.yard.capacity]:@"";
    
    [self.capacityTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.capacityTF];
    
    self.typeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.capacityTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.typeTF.delegate = self;
    
    self.typeTF.placeholder = @"类型";
    
    self.typeTF.text = self.typeArray[self.yard.type];
    
    [topView addSubview:self.typeTF];
    
    QCKeyboardView *keyboard = [QCKeyboardView defaultKeboardView];
    
    keyboard.delegate = self;
    
    self.typeTF.inputView = keyboard;
    
    self.typePV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 37, MSW, 177)];
    
    self.typePV.titleArray = self.typeArray;
    
    keyboard.keyboard = self.typePV;
    
    if (self.isAdd) {
        
        self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
        
        self.confirmButton.backgroundColor = kMainColor;
        
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        self.confirmButton.titleLabel.font = AllFont(14);
        
        [self.view addSubview:self.confirmButton];
        
    }else
    {
        
        self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(40))];
        
        self.confirmButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.confirmButton setTitle:@"删除该场地" forState:UIControlStateNormal];
        
        [self.confirmButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
        
        self.confirmButton.titleLabel.font = AllFont(14);
        
        [self.view addSubview:self.confirmButton];
        
    }
    
    [self.confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    self.hud.mode = MBProgressHUDModeText;

}

-(void)naviRightClick
{
    
    if (![PermissionInfo sharedInfo].gym.permissions.studioPermission.editState) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self changeYard];
        
        [self.info changeYard:self.yard result:^(BOOL success, NSString *error) {
            
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

-(void)changeYard
{
    
    self.yard.name = self.nameTF.text;
    
    self.yard.capacity = [self.capacityTF.text integerValue];
    
    self.yard.type = [self.typePV.titleArray indexOfObject:self.typeTF.text];
    
    self.yard.gym = self.gym;
    
}

-(void)confirmClick:(UIButton*)button
{
    
    if (![PermissionInfo sharedInfo].gym.permissions.studioPermission.deleteState && !self.isAdd) {
        
        [self showNoPermissionAlert];
        
        return;
        
    }
    
    [self changeYard];
    
    __weak typeof(self)weakS = self;
    
    if (self.isAdd) {
        
        [self.info addYard:self.yard result:^(BOOL success,NSString *error) {
            
            if (success) {
                
                weakS.hud.label.text = @"创建成功";
                
                [weakS.hud showAnimated:YES];
                
                [weakS.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (weakS.editFinish) {
                        weakS.editFinish();
                    }
                    
                    [weakS.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }
            
        }];
        
    }else
    {
        
        [[[UIAlertView alloc]initWithTitle:@"是否确认删除场地？" message:@"安排在该场地的课程将无法正常预约。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (![PermissionInfo sharedInfo].gym.permissions.studioPermission.editState) {
        
        [self showNoPermissionAlert];
        
        return NO;
        
    }else{
        
        return YES;
        
    }
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [self.info deleteYard:self.yard result:^(BOOL success,NSString *error) {
            
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

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    self.typeTF.text = self.typeArray[self.typePV.currentRow];
    
    self.yard.type = [self.typeArray indexOfObject:self.typeTF.text];;
    
    [self.typeTF resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    self.yard.name = self.nameTF.text;
    
    self.yard.capacity = [self.capacityTF.text integerValue];
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == self.nameTF) {
        
        self.yard.name = self.nameTF.text;
        
    }
    
    if (textField == self.capacityTF) {
        
        self.yard.capacity = [self.capacityTF.text integerValue];
        
    }
    
}

@end
