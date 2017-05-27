//
//  CoursePlanDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanDetailController.h"

#import "MOCell.h"

#import "MOSwitchCell.h"

#import "QCTextField.h"

#import "CoursePlanDetailInfo.h"

#import "CoursePlanYardController.h"

#import "CoursePlanWayController.h"

#import "CoursePlanCoachController.h"

#import "CoursePlanCourseController.h"

#import "CoursePlanBatchEditController.h"

#import "GymProHintView.h"

#import "MOTableView.h"

#import "CoursePlanDetailWeekCell.h"

#import "QCKeyboardView.h"

#import "MOTimePicker.h"

#import "CoursePlanPayCardController.h"

#import "CoursePlanPayOnlineController.h"

#import "KeyboardManager.h"

static NSString *identifier = @"Cell";

@interface CoursePlanDetailController ()<UIAlertViewDelegate,GymProHintViewDelegate,MOTableViewDatasource,UITableViewDelegate,QCKeyboardViewDelegate,UITextFieldDelegate,MOSwitchCellDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)MOCell *topCell;

@property(nonatomic,strong)MOCell *yardCell;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)UIView *needPayView;

@property(nonatomic,strong)MOSwitchCell *needPayCell;

@property(nonatomic,strong)MOCell *onlinePayCell;

@property(nonatomic,strong)MOCell *cardPayCell;

@property(nonatomic,strong)CoursePlanDetailInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)MOTimePicker *startTP;

@property(nonatomic,strong)MOTimePicker *endTP;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UITextField *hideTF;

@property(nonatomic,strong)UIView *tableHeaderView;

@end

@implementation CoursePlanDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, Width(16), 0, 0)];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, Width(16), 0, 0)];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)dealloc
{
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, Width(16), 0, 0)];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsMake(0, Width(16), 0, 0)];
        
    }
    
}

-(void)createData
{
    
    [self.iconView sd_setImageWithURL:self.courseType == CourseTypeGroup?self.course.imgUrl:self.coach.iconUrl];
    
    self.titleLabel.text = self.courseType == CourseTypeGroup?self.course.name:self.coach.name;
    
    if (self.courseType == CourseTypeGroup) {
        
        self.subtitleLabel.text = [NSString stringWithFormat:@"%ldmin",(long)self.course.during];
        
    }
    
    self.topCell.subtitle = self.courseType == CourseTypeGroup?self.batch.coach.name:self.batch.course.name;
    
    __weak typeof(self)weakS = self;
    
    self.info = [[CoursePlanDetailInfo alloc]init];
    
    self.info.requestFinish = ^(BOOL success){
        
        weakS.batch = weakS.info.batch;
        
        weakS.batch.gym = weakS.gym;
        
        weakS.batch.course.type = weakS.courseType;
        
        if (weakS.batch.yards.count == 1) {
            
            weakS.yardCell.subtitle = ((Yard*)[weakS.batch.yards firstObject]).name;
            
        }else if(weakS.batch.yards.count)
        {
            
            weakS.yardCell.subtitle = [NSString stringWithFormat:@"%ld处场地",(unsigned long)weakS.batch.yards.count];
            
        }
        
        weakS.tableView.dataSuccess = success;
        
        weakS.capacityTF.text = [NSString stringWithInteger:weakS.batch.course.capacity];
        
        weakS.cardPayCell.placeholder = @"未设置可支付会员卡";
        
        [weakS reloadData];
        
        [weakS.tableView reloadData];
        
    };
    
    [self.info requestWithBatchId:self.batch.batchId];
    
}

-(void)reloadData
{
    
    self.needPayCell.on = !self.batch.isFree;
    
    self.needPayCell.noLine = self.batch.isFree;
    
    NSArray *onlinePays = self.batch.onlinePays;
    
    NSArray *cardKinds = self.batch.cardKinds;
    
    OnlinePay *pay = [onlinePays firstObject];
    
    self.onlinePayCell.subtitle = pay.isUsed?@"已开启":@"已关闭";
    
    self.cardPayCell.subtitle = cardKinds.count?[NSString stringWithFormat:@"可用%ld种卡结算",(unsigned long)cardKinds.count]:@"未设置可结算会员卡";
    
    [self.needPayView changeHeight:self.batch.isFree?Height(44):Height(44)*3];
    
    self.onlinePayCell.hidden = self.cardPayCell.hidden = self.batch.isFree;
    
    [self.dateLabel changeTop:self.needPayView.bottom+Height(12)];
    
    [self.tableHeaderView changeHeight:self.dateLabel.bottom+Height(10)];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
}

-(void)createUI
{
    
    self.title = @"详情";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height(40)) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CoursePlanDetailWeekCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(90)+Height(44)*7+Height(12))];
    
    self.tableHeaderView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(90)+Height(44)*3)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.tableHeaderView addSubview:topView];
    
    UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(90))];
    
    [topView addSubview:topButton];
    
    [topButton addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(60), Height(60))];
    
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
    
    self.iconView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    if (self.courseType == CourseTypePrivate) {
        
        self.iconView.layer.cornerRadius = self.iconView.width/2;
        
        self.iconView.layer.masksToBounds = YES;
        
    }
    
    [topButton addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(12), self.courseType == CourseTypePrivate?Height320(33):Height320(21), MSW-Width320(35.5)-self.iconView.right, Height320(17))];
    
    self.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.titleLabel.font = AllFont(15);
    
    [topButton addSubview:self.titleLabel];
    
    if (self.courseType == CourseTypeGroup) {
        
        self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height320(8), self.titleLabel.left, Height320(15))];
        
        self.subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        self.subtitleLabel.font = AllFont(13);
        
        [topButton addSubview:self.subtitleLabel];
        
    }
    
    if ([PermissionInfo sharedInfo].permissions.courseOrderPermission.editState) {
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width(23.5), Height(35), Width(7.5), Height(12))];
        
        arrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [topButton addSubview:arrow];
        
    }
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width(16), topButton.bottom-1/[UIScreen mainScreen].scale, MSW-Width(32), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    self.topCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(15), topButton.bottom, MSW-Width(30), Height(44))];
    
    self.topCell.titleLabel.text = self.courseType == CourseTypeGroup?@"教练":@"课程";
    
    self.topCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.topCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.topCell.tag = 101;
    
    [self.topCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.topCell];
    
    self.yardCell = [[MOCell alloc]initWithFrame:CGRectMake(self.topCell.left, self.topCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.yardCell.titleLabel.text = @"场地";
    
    self.yardCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.yardCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.yardCell.tag = 102;
    
    [self.yardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.yardCell];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.topCell.left, self.yardCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.capacityTF.placeholder = @"单节课可约人数";
    
    self.capacityTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.capacityTF.textColor = UIColorFromRGB(0x888888);
    
    self.capacityTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.capacityTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.capacityTF];
    
    self.needPayView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height(12), MSW, Height(44))];
    
    self.needPayView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.needPayView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.needPayView.layer.borderWidth = OnePX;
    
    [self.tableHeaderView addSubview:self.needPayView];
    
    self.needPayCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width(15), 0, MSW-Width(30), Height(44))];
    
    self.needPayCell.titleLabel.text = @"需要结算";
    
    if (!AppGym.pro) {
        
        self.needPayCell.pro = YES;
        
    }
    
    self.needPayCell.noLine = YES;
    
    self.needPayCell.delegate = self;
    
    [self.needPayView addSubview:self.needPayCell];
    
    [self.needPayCell addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.onlinePayCell = [[MOCell alloc]initWithFrame:CGRectMake(self.needPayCell.left, self.needPayCell.bottom, self.needPayCell.width, self.needPayCell.height)];
    
    self.onlinePayCell.titleLabel.text = @"在线支付结算";
    
    self.onlinePayCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.onlinePayCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.onlinePayCell.placeholderColor = UIColorFromRGB(0xbbbbbb);
    
    self.onlinePayCell.tag = 103;
    
    [self.needPayView addSubview:self.onlinePayCell];
    
    [self.onlinePayCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.onlinePayCell.hidden = YES;
    
    self.cardPayCell = [[MOCell alloc]initWithFrame:CGRectMake(self.needPayCell.left, self.onlinePayCell.bottom, self.needPayCell.width, self.needPayCell.height)];
    
    self.cardPayCell.titleLabel.text = @"会员卡结算";
    
    self.cardPayCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.cardPayCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.cardPayCell.placeholderColor = UIColorFromRGB(0xbbbbbb);
    
    self.cardPayCell.tag = 104;
    
    self.cardPayCell.hidden = YES;
    
    [self.needPayView addSubview:self.cardPayCell];
    
    [self.cardPayCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), self.needPayView.bottom+Height(12), MSW-Width(30), Height(15))];
    
    self.dateLabel.textColor = UIColorFromRGB(0x999999);
    
    self.dateLabel.font = AllFont(12);
    
    self.dateLabel.text = [NSString stringWithFormat:self.courseType == CourseTypeGroup?@"%@ 至 %@的课程":@"%@ 至 %@的排期",self.batch.start,self.batch.end];
    
    [self.tableHeaderView addSubview:self.dateLabel];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (!permission.editState) {
        
        self.topCell.haveArrow = self.yardCell.haveArrow = NO;
        
        self.topCell.userInteractionEnabled = self.yardCell.userInteractionEnabled = self.needPayCell.userInteractionEnabled = self.onlinePayCell.userInteractionEnabled = self.cardPayCell.userInteractionEnabled = NO;
        
    }
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(64))];
    
    footerView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = footerView;
    
    UIButton *detailButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height(12), MSW, Height(44))];
    
    detailButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    detailButton.layer.borderWidth = OnePX;
    
    detailButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [detailButton addTarget:self action:@selector(batchDetail) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:detailButton];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW-Width(149), Height(44))];
    
    detailLabel.text = self.courseType == CourseTypeGroup?@"查看所有课程":@"查看所有排期";
    
    detailLabel.textColor = UIColorFromRGB(0x333333);
    
    detailLabel.textAlignment = NSTextAlignmentRight;
    
    detailLabel.font = AllFont(14);
    
    [detailButton addSubview:detailLabel];
    
    UIImageView *detailImg = [[UIImageView alloc]initWithFrame:CGRectMake(detailLabel.right+Width(6), Height(19), Width(7), Height(12))];
    
    detailImg.image = [UIImage imageNamed:@"cellarrow"];
    
    [detailButton addSubview:detailImg];
    
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.tableView.bottom, MSW, MSH-self.tableView.bottom)];
    
    deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    deleteButton.layer.borderWidth = OnePX;
    
    deleteButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    
    [deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    deleteButton.titleLabel.font = AllFont(16);
    
    [self.view addSubview:deleteButton];
    
    [deleteButton addTarget:self action:@selector(deleteBatch) forControlEvents:UIControlEventTouchUpInside];
    
    self.hideTF = [[UITextField alloc]initWithFrame:CGRectZero];
    
    self.hideTF.placeholder = @"排期时间";
    
    self.hideTF.delegate = self;
    
    self.hideTF.tag = 101;
    
    [self.view addSubview:self.hideTF];
    
    QCKeyboardView *timeKV = [QCKeyboardView defaultKeboardView];
    
    timeKV.delegate = self;
    
    self.hideTF.inputView = timeKV;
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    timeKV.keyboard = timeView;
    
    self.startTP = [[MOTimePicker alloc]initWithFrame:CGRectMake(0, 0, self.courseType == CourseTypeGroup?MSW:MSW/2, 177)];
    
    self.startTP.timeGap = 15;
    
    [timeView addSubview:self.startTP];
    
    if (self.courseType == CourseTypePrivate) {
        
        self.endTP = [[MOTimePicker alloc]initWithFrame:CGRectMake(MSW/2, 0, MSW/2, 177)];
        
        self.endTP.timeGap = 15;
        
        [timeView addSubview:self.endTP];
        
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    CoursePlan *plan = self.batch.course.coursePlans[self.indexPath.row];
    
    self.startTP.time = plan.startTime;
    
    self.endTP.time = plan.endTime;
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.view endEditing:YES];
    
    CoursePlan *plan = self.batch.course.coursePlans[self.indexPath.row];
    
    if (self.batch.course.type == CourseTypeGroup) {
        
        plan.startTime = self.startTP.time;
        
    }else{
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        dateFormatter.dateFormat = @"HH:mm";
        
        if ([[dateFormatter dateFromString:self.startTP.time] timeIntervalSinceDate:[dateFormatter dateFromString:self.endTP.time]]>0) {
            
            plan.startTime = self.endTP.time;
            
            plan.endTime = self.startTP.time;
            
        }else{
            
            plan.startTime = self.startTP.time;
            
            plan.endTime = self.endTP.time;
            
        }
        
    }
    
    [self.tableView reloadData];
    
}

-(void)deleteBatch
{
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (permission.deleteState) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除该排期吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        
        alert.tag = 0;
        
        [alert show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 0) {
        
        if (buttonIndex == 1) {
            
            CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
            
            [info deleteBatch:self.batch result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"删除成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([NSStringFromClass([vc class]) isEqualToString:@"CourseArrangeController"]) {
                            
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            
                            self.editFinish();
                            
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
                }else{
                    
                    [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                    
                }
                
            }];
            
        }
        
    }else if(alertView.tag == 999){
        
        if (buttonIndex == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}

-(void)batchDetail
{
    
    CoursePlanBatchEditController *svc = [[CoursePlanBatchEditController alloc]init];
    
    self.batch.gym = self.gym;
    
    svc.batch = self.batch;
    
    self.batch.course.gym = self.gym;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)topClick
{
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (permission.editState) {
        
        if (self.courseType == CourseTypeGroup) {
            
            CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
            
            svc.isAdd = NO;
            
            svc.batch = self.batch;
            
            svc.gym = self.gym;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Course *course){
                
                weakS.batch.course = course;
                
                weakS.titleLabel.text = course.name;
                
                weakS.subtitleLabel.text = [NSString stringWithFormat:@"%ldmin",(long)course.during];
                
                [weakS.iconView sd_setImageWithURL:course.imgUrl];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            CoursePlanCoachController *svc = [[CoursePlanCoachController alloc]init];
            
            svc.title = @"选择私教教练";
            
            svc.isAdd = NO;
            
            svc.batch = self.batch;
            
            svc.gym = self.gym;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Coach *coach){
                
                weakS.batch.coach = coach;
                
                weakS.titleLabel.text = coach.name;
                
                [weakS.iconView sd_setImageWithURL:coach.iconUrl];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else{
        
        return;
        
    }
    
}

-(void)cellClick:(MOCell *)cell
{
    
    if (cell.tag == 101) {
        
        if (self.courseType == CourseTypeGroup) {
            
            CoursePlanCoachController *svc = [[CoursePlanCoachController alloc]init];
            
            svc.isAdd = NO;
            
            svc.title = @"选择教练";
            
            svc.batch = self.batch;
            
            svc.gym = self.gym;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Coach *coach){
                
                weakS.batch.coach = coach;
                
                weakS.topCell.subtitle = coach.name;
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
            
            svc.isAdd = NO;
            
            svc.batch = self.batch;
            
            svc.gym = self.gym;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Course *course){
                
                weakS.batch.course = course;
                
                weakS.topCell.subtitle = course.name;
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else if (cell.tag == 102){
        
        CoursePlanYardController *svc = [[CoursePlanYardController alloc]init];
        
        svc.isAdd = NO;
        
        svc.batch = [self.batch copy];
        
        svc.gym = self.gym;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(NSArray *yards){
            
            weakS.batch.yards = yards;
            
            if (weakS.batch.yards.count == 1) {
                
                weakS.yardCell.subtitle = ((Yard*)[weakS.batch.yards firstObject]).name;
                
            }else
            {
                
                weakS.yardCell.subtitle = [NSString stringWithFormat:@"%ld处场地",(unsigned long)weakS.batch.yards.count];
                
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if(cell.tag == 103)
    {
        
        if ([self.capacityTF.text integerValue]>0) {
            
            weakTypesYF
            CoursePlanPayOnlineController *svc = [[CoursePlanPayOnlineController alloc]init];
            
            svc.batch = [self.batch copy];
            
            svc.setFinish = ^(CoursePlanBatch*batch){
                
                weakS.batch = batch;
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"请先填写单节课可约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }else if(cell.tag == 104){
        
        if ([self.capacityTF.text integerValue]>0) {
            
            weakTypesYF
            CoursePlanPayCardController *svc = [[CoursePlanPayCardController alloc]init];
            
            svc.batch = [self.batch copy];
            
            svc.setFinish = ^(CoursePlanBatch*batch){
                
                weakS.batch = batch;
                
                weakS.cardPayCell.placeholder = @"未设置可支付会员卡";
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"请先填写单节课可约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }
    
}

-(void)switchClick:(MOSwitchCell *)cell
{
    
    if (!AppGym.pro){
 
        GymProHintView *hintView = [GymProHintView defaultView];
        
        hintView.title = @"课程需要结算";
        
        hintView.delegate = self;
        
        hintView.canTry = !AppGym.haveTried;
        
        [hintView showInView:self.view];
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    self.batch.isFree = !cell.on;
    
    [self reloadData];
    
    [self.tableView reloadData];
    
}

-(void)naviRightClick
{
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (permission.editState) {
        
        if (!self.batch.isFree) {
            
            NSArray *onlinePays = self.batch.onlinePays;
            
            NSArray *cardKinds = self.batch.cardKinds;
            
            OnlinePay *pay = [onlinePays firstObject];
            
            if (!pay.isUsed && !cardKinds.count) {
                
                [[[UIAlertView alloc]initWithTitle:@"请设置结算方式" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
            if ([self.cardPayCell.placeholder isEqualToString:@"已修改可约人数，请重新设置"] && !self.cardPayCell.subtitle.length) {
                
                [[[UIAlertView alloc]initWithTitle:@"请重新设置会员卡支付" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        if (self.batch.course.capacity<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"当前课程可约人数非正数，请到结算方式页面重新设置" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        if (self.batch.yards.count<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"请设置场地" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.rightButtonEnable = NO;
        
        CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
        
        __weak typeof(self)weakS = self;
        
        self.batch.gym = self.gym;
        
        [info checkBatch:self.batch result:^(BOOL success,NSString *error) {
            
            if (success) {
                
                [weakS changeBatch];
                
            }else{
                
                [self.hud hideAnimated:YES];
                
                self.rightButtonEnable = YES;
                
                [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        }];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)changeBatch
{
    
    CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
    
    [info changeBatch:self.batch result:^(BOOL success, NSString *error) {
        
        self.rightButtonEnable = YES;
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"修改成功";
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.editFinish) {
                    
                    self.editFinish();
                    
                }
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }];
    
}

-(void)trySuccessAlertStart
{
    
    self.needPayCell.pro = NO;
    
    self.needPayCell.userInteractionEnabled = YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.batch.course.coursePlans count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height(44);
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePlanDetailWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CoursePlan *plan = self.batch.course.coursePlans[indexPath.row];
    
    cell.week = self.courseType == CourseTypeGroup?plan.week:[NSString stringWithFormat:@"%@可约时间段",plan.week];
    
    cell.indexPath = indexPath;
    
    cell.time = self.courseType == CourseTypePrivate?[NSString stringWithFormat:@"%@-%@",plan.startTime,plan.endTime]:plan.startTime;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.indexPath = indexPath;
    
    [self.hideTF becomeFirstResponder];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (self.courseType == CourseTypePrivate) {
        
        if (self.cardPayCell.subtitle.length && ![self.cardPayCell.subtitle isEqualToString:@"未设置可结算会员卡"]) {
            
            self.cardPayCell.subtitle = @"";
            
            self.cardPayCell.placeholder = @"已修改可约人数，请重新设置";
            
        }
        
    }
    
    self.batch.course.capacity = [textField.text integerValue];
    
}

-(void)naviLeftClick
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定要放弃本次编辑？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    alert.tag = 999;
    
    [alert show];
    
}


@end
