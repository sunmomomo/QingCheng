//
//  NotificationSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/19.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "NotificationSettingController.h"

#import "MOSwitchCell.h"

#import "QCTextField.h"

#import "KeyboardManager.h"

#import "CourseSettingInfo.h"

@interface NotificationSettingController ()<MOSwitchCellDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIView *groupView;

@property(nonatomic,strong)UIView *numberView;

@property(nonatomic,strong)UIView *thirdView;

@property(nonatomic,strong)MOSwitchCell *groupCell;

@property(nonatomic,strong)QCTextField *groupTF;

@property(nonatomic,strong)MOSwitchCell *numberCell;

@property(nonatomic,strong)QCTextField *numberTF;

@property(nonatomic,strong)MOSwitchCell *orderRemainCell;

@property(nonatomic,strong)MOSwitchCell *replaceOrderCell;

@property(nonatomic,strong)MOSwitchCell *cancelCell;

//@property(nonatomic,strong)MOSwitchCell *havePlaceCell;

@property(nonatomic,strong)CourseNotificationSetting *setting;

@end

@implementation NotificationSettingController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    CourseSettingInfo *info = [[CourseSettingInfo alloc]init];
    
    [info requestNotificationSettingWithCourseType:self.courseType result:^(BOOL success, NSString *error) {
        
        self.setting = info.notificationSetting;
        
        [self reloadUI];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"预约短信通知";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    [self.view addSubview:self.scrollView];
    
    self.groupView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(40)*2)];
    
    self.groupView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.groupView.layer.borderWidth = OnePX;
    
    self.groupView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.scrollView addSubview:self.groupView];
    
    self.groupCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.groupCell.titleLabel.text = self.courseType == CourseTypeGroup?@"团课开始前提醒会员":@"私教开始前提醒会员";
    
    self.groupCell.delegate = self;
    
    [self.groupView addSubview:self.groupCell];
    
    self.groupTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.groupCell.bottom, self.groupCell.width, self.groupCell.height)];
    
    self.groupTF.placeholder = @"课程开始前（分钟）";
    
    self.groupTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.groupTF.noLine = YES;
    
    self.groupTF.placeholderColor = UIColorFromRGB(0x333333);
    
    [self.groupView addSubview:self.groupTF];
    
    [self.groupTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    if (self.courseType == CourseTypeGroup) {
        
        self.numberView = [[UIView alloc]initWithFrame:CGRectMake(0, self.groupView.bottom+Height320(12), MSW, Height320(40)*2)];
        
        self.numberView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.numberView.layer.borderWidth = OnePX;
        
        self.numberView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        [self.scrollView addSubview:self.numberView];
        
        self.numberCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.numberCell.titleLabel.text = @"上课人数不足提醒教练";
        
        self.numberCell.delegate = self;
        
        [self.numberView addSubview:self.numberCell];
        
        self.numberTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.numberCell.left, self.numberCell.bottom, self.numberCell.width, self.numberCell.height)];
        
        self.numberTF.placeholder = @"课程开始前（分钟）";
        
        self.numberTF.keyboardType = UIKeyboardTypeNumberPad;
        
        self.numberTF.noLine = YES;
        
        self.numberTF.placeholderColor = UIColorFromRGB(0x333333);
        
        [self.numberView addSubview:self.numberTF];
        
        [self.numberTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, self.courseType == CourseTypeGroup?self.numberView.bottom+Height320(12):self.groupView.bottom+Height320(12), MSW, Height320(40)*3)];
    
    self.thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.thirdView.layer.borderWidth = OnePX;
    
    self.thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.scrollView addSubview:self.thirdView];
    
    self.orderRemainCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.orderRemainCell.titleLabel.text = @"有新预约提醒教练";
    
    self.orderRemainCell.delegate = self;
    
    [self.thirdView addSubview:self.orderRemainCell];
    
    self.replaceOrderCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), self.orderRemainCell.bottom, MSW-Width320(32), Height320(40))];
    
    self.replaceOrderCell.titleLabel.text = self.courseType == CourseTypeGroup?@"教练工作人员代约团课提醒会员":@"教练工作人员代约私教提醒会员";
    
    self.replaceOrderCell.delegate = self;
    
    [self.thirdView addSubview:self.replaceOrderCell];
    
    self.cancelCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), self.replaceOrderCell.bottom, MSW-Width320(32), Height320(40))];
    
    self.cancelCell.titleLabel.text = self.courseType == CourseTypeGroup?@"会员取消团课预约提醒会员":@"会员取消私教预约提醒会员";
    
    self.cancelCell.delegate = self;
    
    [self.thirdView addSubview:self.cancelCell];
//    
//    self.havePlaceCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), self.cancelCell.bottom, MSW-Width320(32), Height320(40))];
//    
//    self.havePlaceCell.titleLabel.text = @"有可约名额时提醒排队候补会员";
//    
//    self.havePlaceCell.noLine = YES;
//    
//    [self.thirdView addSubview:self.havePlaceCell];
//    
}

-(void)reloadUI
{
    
    self.groupCell.on = self.setting.userRemain;
    
    self.groupTF.hidden = !self.setting.userRemain;
    
    self.groupTF.text = self.setting.userRemainTime?[NSString stringWithInteger:self.setting.userRemainTime]:@"";
    
    [self.groupView changeHeight:self.setting.userRemain?Height320(40)*2:Height320(40)];
    
    if (self.courseType == CourseTypeGroup) {
        
        [self.numberView changeTop:self.groupView.bottom+Height320(12)];
        
        self.numberCell.on = self.setting.coachRemain;
        
        self.numberTF.hidden = !self.setting.coachRemain;
        
        self.numberTF.text = self.setting.coachRemainTime?[NSString stringWithInteger:self.setting.coachRemainTime]:@"";
        
        [self.numberView changeHeight:self.setting.coachRemain?Height320(40)*2:Height320(40)];
        
    }
    
    [self.thirdView changeTop:self.courseType ==CourseTypeGroup?self.numberView.bottom+Height320(12):self.groupView.bottom+Height320(12)];
    
    self.orderRemainCell.on = self.setting.orderRemain;
    
    self.replaceOrderCell.on = self.setting.coachOrderRemain;
    
    self.cancelCell.on = self.setting.cancelRemain;
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if (cell == self.groupCell) {
        
        self.setting.userRemain = cell.on;
        
        self.setting.userRemainTime = 0;
        
    }else if (cell == self.numberCell){
        
        self.setting.coachRemain = cell.on;
        
        self.setting.coachRemainTime = 0;
        
    }else if (cell == self.orderRemainCell){
        
        self.setting.orderRemain = cell.on;
        
    }else if (cell == self.replaceOrderCell){
        
        self.setting.coachOrderRemain = cell.on;
        
    }else if(cell == self.cancelCell){
        
        self.setting.cancelRemain = cell.on;
        
    }
    
    [self reloadUI];
    
}

-(void)naviRightClick
{
 
    if (self.setting.userRemain && !self.groupTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写课程开始前多少分钟提醒会员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.setting.userRemainTime = [self.groupTF.text integerValue];
    
    if (self.courseType == CourseTypeGroup) {
        
        self.setting.coachRemainTime = [self.numberTF.text integerValue];
        
        if (self.setting.coachRemain && !self.numberTF.text.length) {
            
            [[[UIAlertView alloc]initWithTitle:@"请填写课程开始前多少分钟提醒教练" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.label.text = @"";
    
    [hud showAnimated:YES];
    
    CourseSettingInfo *info = [[CourseSettingInfo alloc]init];
    
    self.rightButtonEnable = NO;
    
    [info updateNotificationSetting:self.setting result:^(BOOL success, NSString *error) {
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            hud.label.text = @"保存成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else{
            
            self.rightButtonEnable = YES;
            
            hud.label.text = error;
            
            [hud hideAnimated: YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == self.groupTF) {
        
        self.setting.userRemainTime = [textField.text integerValue];
        
    }else if (textField == self.numberTF){
        
        self.setting.coachRemainTime = [textField.text integerValue];
        
    }
    
}

@end
