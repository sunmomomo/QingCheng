//
//  CourseAstrictController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/19.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CourseAstrictController.h"

#import "MOSwitchCell.h"

#import "QCTextField.h"

#import "KeyboardManager.h"

#import "CourseSettingInfo.h"

@interface CourseAstrictController ()<MOSwitchCellDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIView *astrictView;

@property(nonatomic,strong)UILabel *cancelLabel;

@property(nonatomic,strong)UIView *cancelView;

//@property(nonatomic,strong)UILabel *lineupLabel;

//@property(nonatomic,strong)UIView *lineupView;

@property(nonatomic,strong)MOSwitchCell *astrictCell;

@property(nonatomic,strong)QCTextField *astrictTF;

@property(nonatomic,strong)MOSwitchCell *cancelCell;

@property(nonatomic,strong)QCTextField *cancelTF;

//@property(nonatomic,strong)MOSwitchCell *lineupCell;

@property(nonatomic,strong)CourseSetting *setting;

@end

@implementation CourseAstrictController

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
    
    [info requestCourseSettingWithCourseType:self.courseType result:^(BOOL success, NSString *error) {
        
        self.setting = info.courseSetting;
        
        [self reloadUI];
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.courseType == CourseTypeGroup?@"团课预约限制":@"私教预约限制";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    [self.view addSubview:self.scrollView];
    
    UILabel *astrictLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(14), Width320(250), Height320(15))];
    
    astrictLabel.text = self.courseType == CourseTypeGroup?@"会员在团课开始前多长时间不能预约：":@"会员在私教开始前多长时间不能预约：";
    
    astrictLabel.textColor = UIColorFromRGB(0x999999);
    
    astrictLabel.font = AllFont(12);
    
    [self.scrollView addSubview:astrictLabel];
    
    self.astrictView = [[UIView alloc]initWithFrame:CGRectMake(0, astrictLabel.bottom+Height320(8), MSW, Height320(40)*2)];
    
    self.astrictView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.astrictView.layer.borderWidth = OnePX;
    
    self.astrictView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.scrollView addSubview:self.astrictView];
    
    self.astrictCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.astrictCell.titleLabel.text = self.courseType == CourseTypeGroup?@"团课预约限制":@"私教预约限制";
    
    self.astrictCell.delegate = self;
    
    [self.astrictView addSubview:self.astrictCell];
    
    self.astrictTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.astrictCell.bottom, self.astrictCell.width, self.astrictCell.height)];
    
    self.astrictTF.placeholder = @"课程开始前（分钟）";
    
    self.astrictTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.astrictTF.noLine = YES;
    
    self.astrictTF.placeholderColor = UIColorFromRGB(0x333333);
    
    [self.astrictView addSubview:self.astrictTF];
    
    [self.astrictTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.astrictView.bottom+Height320(14), Width320(250), Height320(15))];
    
    self.cancelLabel.text = self.courseType == CourseTypeGroup?@"会员在团课开始前多长时间不能取消":@"会员在私教开始前多长时间不能取消：";
    
    self.cancelLabel.textColor = UIColorFromRGB(0x999999);
    
    self.cancelLabel.font = AllFont(12);
    
    [self.scrollView addSubview:self.cancelLabel];
    
    self.cancelView = [[UIView alloc]initWithFrame:CGRectMake(0, self.cancelLabel.bottom+Height320(8), MSW, Height320(40)*2)];
    
    self.cancelView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.cancelView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.cancelView.layer.borderWidth = OnePX;
    
    [self.scrollView addSubview:self.cancelView];
    
    self.cancelCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.cancelCell.titleLabel.text = self.courseType == CourseTypeGroup?@"团课取消预约限制":@"私教取消预约限制";
    
    self.cancelCell.delegate = self;
    
    [self.cancelView addSubview:self.cancelCell];
    
    self.cancelTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.cancelCell.bottom, self.cancelCell.width, self.cancelCell.height)];
    
    self.cancelTF.placeholder = @"课程开始前（分钟）";
    
    self.cancelTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.cancelTF.noLine = YES;
    
    self.cancelTF.placeholderColor = UIColorFromRGB(0x333333);
    
    [self.cancelView addSubview:self.cancelTF];
    
    [self.cancelTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
//    
//    self.lineupLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.cancelView.bottom+Height320(14), Width320(250), Height320(15))];
//    
//    self.lineupLabel.text = self.courseType == CourseTypeGroup?@"团课约满后，是否允许会员排队候补：":@"私教约满后，是否允许会员排队候补：";
//    
//    self.lineupLabel.textColor = UIColorFromRGB(0x999999);
//    
//    self.lineupLabel.font = AllFont(12);
//    
//    [self.scrollView addSubview:self.lineupLabel];
//    
//    self.lineupView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lineupLabel.bottom+Height320(8), MSW, Height320(40))];
//    
//    self.lineupView.backgroundColor = UIColorFromRGB(0xffffff);
//    
//    self.lineupView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
//    
//    self.lineupView.layer.borderWidth = OnePX;
//    
//    [self.scrollView addSubview:self.lineupView];
//    
//    self.lineupCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
//    
//    self.lineupCell.titleLabel.text = @"排队候补";
//    
//    self.lineupCell.noLine = YES;
//    
//    [self.lineupView addSubview:self.lineupCell];
//    
}

-(void)reloadUI
{
    
    self.astrictCell.on = self.setting.orderAstrict;
    
    self.astrictTF.hidden = !self.setting.orderAstrict;
    
    [self.astrictView changeHeight:self.setting.orderAstrict?Height320(40)*2:Height320(40)];
    
    self.astrictTF.text = self.setting.orderPretime?[NSString stringWithInteger:self.setting.orderPretime]:@"";
    
    [self.cancelLabel changeTop:self.astrictView.bottom+Height320(14)];
    
    [self.cancelView changeTop:self.cancelLabel.bottom+Height320(8)];
    
    self.cancelCell.on = self.setting.cancelAstrict;
    
    self.cancelTF.hidden = !self.setting.cancelAstrict;
    
    [self.cancelView changeHeight:self.setting.cancelAstrict?Height320(40)*2:Height320(40)];
    
    self.cancelTF.text = self.setting.cancelPretime?[NSString stringWithInteger:self.setting.cancelPretime]:@"";
    
}


-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if (cell == self.astrictCell) {
        
        self.setting.orderAstrict = cell.on;
        
        if (!cell.on) {
            
            self.setting.orderPretime = 0;
            
        }
        
    }else if (cell == self.cancelCell){
        
        self.setting.cancelAstrict = cell.on;
        
        if (!cell.on) {
            
            self.setting.cancelPretime = 0;
            
        }
        
    }
    
    [self reloadUI];
    
}

-(void)naviRightClick
{
    
    if (self.astrictCell.on && !self.astrictTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写课程开始前多少分钟不能预约" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.cancelCell.on && !self.cancelTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写课程开始前多少分钟不能取消预约" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.setting.orderAstrict = self.astrictCell.on;
    
    self.setting.orderPretime = [self.astrictTF.text integerValue];
    
    self.setting.cancelAstrict = self.cancelCell.on;
    
    self.setting.cancelPretime = [self.cancelTF.text integerValue];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.label.text = @"";
    
    [hud showAnimated:YES];
    
    CourseSettingInfo *info = [[CourseSettingInfo alloc]init];
    
    self.rightButtonEnable = NO;
    
    [info updateCourseSetting:self.setting result:^(BOOL success, NSString *error) {
        
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
    
    if (textField == self.astrictTF) {
        
        self.setting.orderPretime = [self.astrictTF.text integerValue];
        
    }else if (textField == self.cancelTF){
        
        self.setting.cancelPretime = [self.cancelTF.text integerValue];
        
    }
    
}

@end
