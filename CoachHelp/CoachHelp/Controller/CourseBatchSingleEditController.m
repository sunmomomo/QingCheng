//
//  CourseBatchSingleEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/19.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CourseBatchSingleEditController.h"

#import "CoursePlanCourseController.h"

#import "CoursePlanYardController.h"

#import "CoursePlanWayController.h"

#import "MOCell.h"

#import "QCKeyboardView.h"

#import "MOTimePicker.h"

#import "QCKeyboardView.h"

#import "CoursePlanDetailInfo.h"

#import "CoursePlanBatchesInfo.h"

@interface CourseBatchSingleEditController ()<UIAlertViewDelegate,QCKeyboardViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)MOCell *topCell;

@property(nonatomic,strong)MOCell *yardCell;

@property(nonatomic,strong)MOCell *cardCell;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)QCTextField *timeCell;

@property(nonatomic,strong)MOTimePicker *startDP;

@property(nonatomic,strong)MOTimePicker *endDP;

@end

@implementation CourseBatchSingleEditController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    [self.iconView sd_setImageWithURL:self.plan.course.type == CourseTypeGroup?self.plan.course.imgUrl:[NSURL URLWithString:CoachIcon]];
    
    CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
    
    [info requestWithPlan:self.plan result:^(BOOL success, NSString *error) {
        
        self.plan = info.plan;
        
        self.titleLabel.text = self.plan.course.type == CourseTypeGroup?self.plan.course.name:self.plan.coach.name;
        
        if (self.plan.course.type == CourseTypeGroup) {
            
            self.subtitleLabel.text = [NSString stringWithFormat:@"%ldmin",(long)self.plan.course.during];
            
        }
        
        self.topCell.subtitle = self.plan.course.type == CourseTypeGroup?self.plan.coach.name:self.plan.course.name;
        
        self.timeCell.text = self.plan.course.type == CourseTypeGroup?self.plan.startTime:[NSString stringWithFormat:@"%@-%@",self.plan.startTime,self.plan.endTime];
        
        if (self.plan.yards.count == 1) {
            
            self.yardCell.subtitle = ((Yard*)[self.plan.yards firstObject]).name;
            
        }else if(self.plan.yards.count)
        {
            
            self.yardCell.subtitle = [NSString stringWithFormat:@"%ld处场地",(unsigned long)self.plan.yards.count];
            
        }
        
        if ((self.plan.cardKinds.count || self.plan.onlinePays.count)&&!self.plan.isFree) {
            
            self.cardCell.subtitle = @"已设置";
            
        }else if (self.plan.isFree && self.plan.course.capacity){
            
            self.cardCell.subtitle = @"已设置";
            
        }
        
        self.startDP.time = self.plan.startTime;
        
        if (self.plan.course.type == CourseTypePrivate) {
            
            self.endDP.time = self.plan.endTime;
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"课程排期";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(204))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:topView];
    
    UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(82))];
    
    [topView addSubview:topButton];
    
    [topButton addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(50), Height320(50))];
    
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
    
    self.iconView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    if (self.plan.course.type == CourseTypePrivate) {
        
        self.iconView.layer.cornerRadius = self.iconView.width/2;
        
        self.iconView.layer.masksToBounds = YES;
        
    }
    
    [topButton addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(12), self.plan.course.type == CourseTypePrivate?Height320(33):Height320(21), MSW-Width320(35.5)-self.iconView.right, Height320(17))];
    
    self.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.titleLabel.font = AllFont(15);
    
    [topButton addSubview:self.titleLabel];
    
    if (self.plan.course.type == CourseTypeGroup) {
        
        self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height320(8), self.titleLabel.left, Height320(15))];
        
        self.subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        self.subtitleLabel.font = AllFont(13);
        
        [topButton addSubview:self.subtitleLabel];
        
    }
    
    if ([PermissionInfo sharedInfo].permissions.courseOrderPermission.editState) {
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(35), Width320(7.5), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [topButton addSubview:arrow];
        
    }
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom-1/[UIScreen mainScreen].scale, MSW-Width320(32), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    self.topCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom, MSW-Width320(32), Height320(40))];
    
    self.topCell.titleLabel.text = self.plan.course.type == CourseTypeGroup?@"教练":@"课程";
    
    self.topCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.topCell.subtitleColor = UIColorFromRGB(0x333333);
    
    self.topCell.tag = 101;
    
    [self.topCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.topCell];
    
    self.yardCell = [[MOCell alloc]initWithFrame:CGRectMake(self.topCell.left, self.topCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.yardCell.titleLabel.text = @"场地";
    
    self.yardCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.yardCell.subtitleColor = UIColorFromRGB(0x333333);
    
    self.yardCell.tag = 102;
    
    [self.yardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.yardCell];
    
    self.cardCell = [[MOCell alloc]initWithFrame:CGRectMake(self.topCell.left, self.yardCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.cardCell.titleLabel.text = @"结算方式";
    
    self.cardCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.cardCell.subtitleColor = UIColorFromRGB(0x333333);
    
    self.cardCell.noLine = YES;
    
    self.cardCell.tag = 103;
    
    self.cardCell.placeholder = @"未设置";
    
    [self.cardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.cardCell];
    
    UILabel *courseLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(14), Width320(100), Height320(16))];
    
    courseLabel.text = @"课程排期";
    
    courseLabel.textColor = UIColorFromRGB(0x999999);
    
    courseLabel.font = AllFont(14);
    
    [self.mainView addSubview:courseLabel];
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(40), MSW, Height320(40)*2)];
    
    timeView.backgroundColor = UIColorFromRGB(0xffffff);
    
    timeView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    timeView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:timeView];
    
    QCTextField *dateTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    dateTF.placeholder = @"日期";
    
    dateTF.textColor = UIColorFromRGB(0xbbbbbb);
    
    dateTF.text = [NSString stringWithFormat:@"%@ %@",self.plan.date,self.plan.week];
    
    dateTF.userInteractionEnabled = NO;
    
    [timeView addSubview:dateTF];
    
    self.timeCell = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), dateTF.bottom, dateTF.width, dateTF.height)];
    
    self.timeCell.placeholder = self.plan.course.type == CourseTypeGroup?@"课程时间":@"可约时间段";
    
    self.timeCell.noLine = YES;
    
    self.timeCell.text = [NSString stringWithFormat:@"%@-%@",self.plan.startTime,self.plan.endTime];
    
    [timeView addSubview:self.timeCell];
    
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.mainView.height-Height320(40), MSW, Height320(40))];
    
    deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [deleteButton setTitle:@"删除该排期" forState:UIControlStateNormal];
    
    [deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    deleteButton.titleLabel.font = AllFont(14);
    
    [self.mainView addSubview:deleteButton];
    
    [deleteButton addTarget:self action:@selector(deleteBatch) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    QCKeyboardView *keyboardView = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    keyboardView.delegate = self;
    
    self.timeCell.inputView = keyboardView;
    
    UIView *datePicker = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    keyboardView.keyboard = datePicker;
    
    self.startDP = [[MOTimePicker alloc]initWithFrame:CGRectMake(0, 0, self.plan.course.type == CourseTypePrivate?MSW/2-Width320(10):MSW, Height320(177))];
    
    self.startDP.timeGap = 5;
    
    [datePicker addSubview:self.startDP];
    
    if (self.plan.course.type == CourseTypePrivate) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2-Width320(10), 0, Width320(20), Height320(177))];
        
        label.text = @"-";
        
        label.textColor = UIColorFromRGB(0x222222);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font =STFont(20);
        
        [datePicker addSubview:label];
        
        self.endDP = [[MOTimePicker alloc]initWithFrame:CGRectMake(MSW/2+Width320(10), 0, MSW/2-Width320(10), Height320(177))];
        
        self.endDP.timeGap = 5;
        
        [datePicker addSubview:self.endDP];
        
    }
    
}


-(void)topClick
{
    
    Permission *permission;
    
    if (self.plan.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (permission.editState) {
        
        if (self.plan.course.type == CourseTypeGroup) {
            
            CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
            
            svc.isAdd = NO;
            
            svc.plan = self.plan;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Course *course){
                
                weakS.plan.course = course;
                
                weakS.titleLabel.text = course.name;
                
                weakS.subtitleLabel.text = [NSString stringWithFormat:@"%ldmin",(long)course.during];
                
                [weakS.iconView sd_setImageWithURL:course.imgUrl];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            [self showAppAlertWithTitle:@"选择教练" andSubtitle:nil];
            
        }
        
    }else{
        
        return;
        
    }
    
}

-(void)cellClick:(MOCell *)cell
{
    
    if (cell.tag == 101) {
        
        if (self.plan.course.type == CourseTypeGroup) {
            
            [self showAppAlertWithTitle:@"选择教练" andSubtitle:nil];
            
        }else
        {
            
            CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
            
            svc.isAdd = NO;
            
            svc.plan = self.plan;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Course *course){
                
                weakS.plan.course = course;
                
                weakS.topCell.subtitle = course.name;
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else if (cell.tag == 102){
        
        CoursePlanYardController *svc = [[CoursePlanYardController alloc]init];
        
        svc.isAdd = NO;
        
        svc.plan = self.plan;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(NSArray *yards){
            
            weakS.plan.yards = yards;
            
            if (weakS.plan.yards.count == 1) {
                
                weakS.yardCell.subtitle = ((Yard*)[weakS.plan.yards firstObject]).name;
                
            }else
            {
                
                weakS.yardCell.subtitle = [NSString stringWithFormat:@"%ld处场地",(unsigned long)weakS.plan.yards.count];
                
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if(cell.tag == 103)
    {
        
        CoursePlanWayController *svc = [[CoursePlanWayController alloc]init];
        
        svc.isAdd = NO;
        
        svc.plan = self.plan;
        
        __weak typeof(self)weakS = self;
        
        svc.setPlanFinish = ^(CoursePlan*plan){
            
            weakS.plan = plan;
            
            if ((weakS.plan.cardKinds.count || weakS.plan.onlinePays.count)&&!weakS.plan.isFree) {
                
                weakS.cardCell.subtitle = @"已设置";
                
            }else if (weakS.plan.isFree && weakS.plan.course.capacity){
                
                weakS.cardCell.subtitle = @"已设置";
                
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)deleteBatch
{
    
    Permission *permission;
    
    if (self.plan.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (permission.deleteState) {
        
        [[[UIAlertView alloc]initWithTitle:@"确定删除该排期吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        NSString *ids = [NSString stringWithInteger:self.plan.planId];
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:ids forKey:@"ids"];
        
        if (AppGym.type.length &&AppGym.gymId) {
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
            
            [para setParameter:AppGym.type forKey:@"model"];
            
        }else if(AppGym.shopId && AppGym.brand.brandId){
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
            
            [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
            
        }
        
        CoursePlanBatchesInfo *info = [[CoursePlanBatchesInfo alloc]init];
        
        [info deleteWithPara:para andCourse:self.plan.course];
        
        [self.hud showAnimated:YES];
        
        __weak typeof(self)weakS = self;
        
        info.deleteFinish = ^(BOOL success){
            
            if (success) {
                
                weakS.hud.mode = MBProgressHUDModeText;
                
                weakS.hud.label.text = @"删除成功";
                
                [weakS.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else
            {
                
                weakS.hud.mode = MBProgressHUDModeText;
                
                weakS.hud.label.text = @"删除失败";
                
                [weakS createData];
                
                [weakS.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        };
        
    }
    
}


-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSString *dateStr = [NSString stringWithFormat:@"%@ %@:%@",self.plan.date,self.startDP.hour,self.startDP.minute];
    
    if ([[df dateFromString:dateStr]timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]]<0) {
        
        [[[UIAlertView alloc]initWithTitle:@"开始时间不能早于当前时间" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }else if (self.plan.course.type == CourseTypePrivate){
        
        NSString *endStr = [NSString stringWithFormat:@"%@ %@:%@",self.plan.date,self.endDP.hour,self.endDP.minute];
        
        if ([[df dateFromString:endStr]timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[df dateFromString:dateStr]]]]<0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束时间不能早于开始时间" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
    }
    
    [self.timeCell resignFirstResponder];
    
    self.plan.startTime = [NSString stringWithFormat:@"%@:%@",self.startDP.hour,self.startDP.minute];
    
    if (self.plan.course.type == CourseTypePrivate) {
        
        self.plan.endTime = [NSString stringWithFormat:@"%@:%@",self.endDP.hour,self.endDP.minute];
        
    }else
    {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.dateFormat = @"HH:mm";
        
        self.plan.endTime = [df stringFromDate:[NSDate dateWithTimeInterval:self.plan.course.during*60 sinceDate:[df dateFromString:self.plan.startTime]]];
        
    }
    
    self.timeCell.text = self.plan.course.type == CourseTypeGroup?self.plan.startTime:[NSString stringWithFormat:@"%@-%@",self.plan.startTime,self.plan.endTime];
    
}


-(void)naviRightClick
{
    
    Permission *permission;
    
    if (self.plan.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (permission.editState) {
        
        if (self.plan.course.capacity<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"当前课程可约人数非正数，请到结算方式页面重新设置" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        if (self.plan.yards.count<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"请设置场地" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.rightButtonEnable = NO;
        
        CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
        
        [info changePlan:self.plan result:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"修改成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                [self.hud hideAnimated:YES];
                
                [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        }];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

@end
