//
//  CoursePlanWayController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanWayController.h"

#import "MOSwitchCell.h"

#import "QCKeyboardView.h"

#import "QCTextField.h"

#import "QCTextFieldCell.h"

#import "MONumberPickerView.h"

#import "CardKindListInfo.h"

#import "OnlinePay.h"

#import "GymProHintView.h"

#import "MOCell.h"

#import "CoursePlanPayCardController.h"

#import "CoursePlanPayOnlineController.h"

#define GroupMaxCapacity 300

#define PrivateMaxCapacity 10

static NSString *identifier = @"Cell";

@interface CoursePlanWayController ()<QCKeyboardViewDelegate,UITextFieldDelegate,MOSwitchCellDelegate,UIAlertViewDelegate,GymProHintViewDelegate>

@property(nonatomic,strong)UIView *payView;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)MOSwitchCell *needPayCell;

@property(nonatomic,strong)UILabel *freeHintLabel;

@property(nonatomic,strong)MONumberPickerView *capacityPickerView;

@property(nonatomic,strong)MOCell *onlineCell;

@property(nonatomic,strong)MOCell *cardKindsCell;

@end

@implementation CoursePlanWayController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)reloadData
{
    
    [self reloadPayView];
    
}

-(void)createData
{
    
    if (self.plan) {
        
        self.needPayCell.on = !self.plan.isFree;
        
        if (!self.plan.isFree) {
            
            if (!self.batch.course.capacity) {
                
                self.batch.course.capacity = 1;
                
                self.capacityTF.text = @"1";
                
            }
            
        }
        
    }else{
        
        self.needPayCell.on = !self.batch.isFree;
        
        if (!self.batch.isFree) {
            
            if (!self.batch.course.capacity) {
                
                self.batch.course.capacity = 1;
                
                self.capacityTF.text = @"1";
                
            }
            
        }
        
        OnlinePay *pay = [self.batch.onlinePays firstObject];
        
        self.onlineCell.subtitle = pay.isUsed?@"已开启":@"已关闭";
        
        self.cardKindsCell.subtitle = self.batch.cardKinds.count?[NSString stringWithFormat:@"可用%ld种卡结算",(unsigned long)self.batch.cardKinds.count]:@"未设置可结算会员卡";
        
    }
    
    [self reloadPayView];
    
}

-(void)createUI
{
    
    self.title = @"设置结算方式";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width(16), 0, MSW-Width(32), Height(40))];
    
    self.capacityTF.placeholder = @"单节课可约人数";
    
    self.capacityTF.delegate = self;
    
    self.capacityTF.noLine = YES;
    
    [topView addSubview:self.capacityTF];
    
    if (self.plan) {
        
        if (self.plan.course.capacity) {
            
            self.capacityTF.text = [NSString stringWithFormat:@"%ld",(long)self.plan.course.capacity];
            
            self.capacityTF.rightViewMode = UITextFieldViewModeNever;
            
        }
        
    }else{
        
        if (self.batch.course.capacity) {
            
            self.capacityTF.text = [NSString stringWithFormat:@"%ld",(long)self.batch.course.capacity];
            
            self.capacityTF.rightViewMode = UITextFieldViewModeNever;
            
        }
        
    }
    
    QCKeyboardView *keyboardView = [QCKeyboardView defaultKeboardView];
    
    keyboardView.tag = 0;
    
    keyboardView.delegate = self;
    
    self.capacityTF.inputView = keyboardView;
    
    self.capacityPickerView = [[MONumberPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.capacityPickerView.minNumber = 1;
    
    if (self.plan) {
        
        self.capacityPickerView.maxNumber = self.plan.course.type == CourseTypeGroup?GroupMaxCapacity:PrivateMaxCapacity;
        
    }else{
        
        self.capacityPickerView.maxNumber = self.batch.course.type == CourseTypeGroup?GroupMaxCapacity:PrivateMaxCapacity;
        
    }
    
    keyboardView.keyboard = self.capacityPickerView;
    
    self.payView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height(12), MSW, Height(40))];
    
    self.payView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.payView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.payView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:self.payView];
    
    self.needPayCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width(16), 0, MSW-Width(32), Height(40))];
    
    self.needPayCell.titleLabel.text = @"需要结算";
    
    self.needPayCell.delegate = self;
    
    self.needPayCell.tag = 0;
    
    if (!AppGym.pro) {
        
        self.needPayCell.pro = YES;
        
    }
    
    [self.payView addSubview:self.needPayCell];
    
    self.onlineCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(16), self.needPayCell.bottom, MSW-Width(32), Height(40))];
    
    self.onlineCell.titleLabel.text = @"在线支付";
    
    self.onlineCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.onlineCell.subtitleColor = UIColorFromRGB(0x999999);
    
    self.onlineCell.tag = 0;
    
    self.onlineCell.hidden = YES;
    
    [self.onlineCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.payView addSubview:self.onlineCell];
    
    self.cardKindsCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(16), self.onlineCell.bottom, MSW-Width(32), Height(40))];
    
    self.cardKindsCell.titleLabel.text = @"会员卡支付";
    
    self.cardKindsCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.cardKindsCell.subtitleColor = UIColorFromRGB(0x999999);
    
    self.cardKindsCell.tag = 1;
    
    self.cardKindsCell.noLine = YES;
    
    self.cardKindsCell.hidden = YES;
    
    [self.cardKindsCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.payView addSubview:self.cardKindsCell];
    
    if (!AppGym.pro) {
        
        self.freeHintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(16), self.payView.bottom+Height(4), MSW-Width(32), Height(14))];
        
        self.freeHintLabel.text = @"使用高级版，解锁全部功能";
        
        self.freeHintLabel.textColor = UIColorFromRGB(0x999999);
        
        self.freeHintLabel.font = AllFont(11);
        
        [self.view addSubview:self.freeHintLabel];
        
    }
    
}

-(void)naviRightClick
{
    
    if (!self.capacityTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请设置课程可约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    OnlinePay *pay;
    
    NSArray *cardKinds;
    
    BOOL needPay;
    
    if (self.plan) {
        
        self.plan.course.capacity = [self.capacityTF.text integerValue];
        
        pay = [self.plan.onlinePays firstObject];
        
        cardKinds = self.plan.cardKinds;
        
        needPay = !self.plan.isFree;
        
    }else{
        
        self.batch.course.capacity = [self.capacityTF.text integerValue];
        
        pay = [self.batch.onlinePays firstObject];
        
        cardKinds = self.batch.cardKinds;
        
        needPay = !self.batch.isFree;
        
    }
    
    BOOL cardUsed = NO;
    
    for (CardKind *cardKind in cardKinds) {
        
        if (cardKind.isUsed) {
            
            cardUsed = YES;
            
            break;
            
        }
        
    }
    
    if (needPay && !pay.isUsed && !cardUsed) {
        
        
        
    }
    
    if (self.setFinish) {
        
        self.setFinish(self.batch);
        
    }
    
    if (self.setPlanFinish) {
        
        self.setPlanFinish(self.plan);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.view endEditing:YES];
    
    if (keyboardView.tag == 0) {
        
        self.capacityTF.text = [NSString stringWithFormat:@"%ld",(long)self.capacityPickerView.currentNumber];
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if (cell.on == YES && !AppGym.pro) {
        
        cell.on = NO;
        
        GymProHintView *hintView = [GymProHintView defaultView];
        
        hintView.title = @"课程需要结算";
        
        hintView.delegate = self;
        
        hintView.canTry = !AppGym.haveTried;
        
        [hintView showInView:self.view];
        
        return;
        
    }
    
    if (self.plan) {
        
        if (self.plan.hasOrder) {
            
            [[[UIAlertView alloc]initWithTitle:@"该结算方式已约课，无法切换。如需切换结算方式，请先取消预约。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
            
            return;
            
        }else{
            
            self.plan.isFree = !cell.on;
            
        }
        
    }else{
        
        if (self.batch.hasOrder) {
            
            [[[UIAlertView alloc]initWithTitle:@"该结算方式已约课，无法切换。如需切换结算方式，请先取消预约。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
            
            return;
            
        }else{
            
            self.batch.isFree = !cell.on;
            
        }
        
    }
    
    [self reloadPayView];
    
}

-(void)reloadPayView
{
    
    NSArray *onlinePays = self.plan?self.plan.onlinePays:self.batch.onlinePays;
    
    NSArray *cardKinds = self.plan?self.plan.cardKinds:self.batch.cardKinds;
    
    OnlinePay *pay = [onlinePays firstObject];
    
    self.onlineCell.subtitle = pay.isUsed?@"已开启":@"已关闭";
    
    self.cardKindsCell.subtitle = cardKinds.count?[NSString stringWithFormat:@"可用%ld种卡结算",(unsigned long)cardKinds.count]:@"未设置可结算会员卡";
    
    self.needPayCell.on = self.plan?!self.plan.isFree:!self.batch.isFree;
    
    [self.payView changeHeight:self.needPayCell.on?Height(40)*3:Height(40)];
    
    self.onlineCell.hidden = !self.needPayCell.on;
    
    self.cardKindsCell.hidden = !self.needPayCell.on;
    
}

-(void)cellClick:(MOCell *)cell
{
    
    weakTypesYF
    if (cell.tag == 0) {
        
        CoursePlanPayOnlineController *svc = [[CoursePlanPayOnlineController alloc]init];
        
        if (self.batch) {
            
            svc.batch = [self.batch copy];
            
            svc.setFinish = ^(CoursePlanBatch*batch){
                
                weakS.batch = batch;
                
            };
            
        }
        
        if (self.plan) {
            
            svc.plan = [self.plan copy];
            
            svc.setPlanFinish = ^(CoursePlan*plan){
                
                weakS.plan = plan;
                
            };
            
        }
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        CoursePlanPayCardController *svc = [[CoursePlanPayCardController alloc]init];
        
        if (self.batch) {
            
            svc.batch = [self.batch copy];
            
            svc.setFinish = ^(CoursePlanBatch*batch){
                
                weakS.batch = batch;
                
            };
            
        }
        
        if (self.plan) {
            
            svc.plan = [self.plan copy];
            
            svc.setPlanFinish = ^(CoursePlan*plan){
                
                weakS.plan = plan;
                
            };
            
        }
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)naviLeftClick
{
    
    [[[UIAlertView alloc]initWithTitle:@"是否保存结算方式" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self naviRightClick];
        
    }
    
}

-(void)trySuccessAlertStart
{
    
    self.needPayCell.pro = NO;
    
    self.freeHintLabel.hidden = YES;
    
}

@end
