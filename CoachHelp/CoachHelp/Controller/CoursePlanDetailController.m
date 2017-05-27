//
//  CoursePlanDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanDetailController.h"

#import "MOCell.h"

#import "QCTextField.h"

#import "CoursePlanDetailInfo.h"

#import "CoursePlanYardController.h"

#import "CoursePlanWayController.h"

#import "CoursePlanBatchEditController.h"

#import "CoursePlanCourseController.h"

@interface CoursePlanDetailController ()<UIAlertViewDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)MOCell *topCell;

@property(nonatomic,strong)MOCell *yardCell;

@property(nonatomic,strong)MOCell *cardCell;

@property(nonatomic,strong)CoursePlanDetailInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CoursePlanDetailController

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
    
    [self.iconView sd_setImageWithURL:self.courseType == CourseTypeGroup?self.course.imgUrl:self.coach.iconUrl];
    
    self.titleLabel.text = self.courseType == CourseTypeGroup?self.course.name:self.coach.name;
    
    if (self.courseType == CourseTypeGroup) {
        
        self.subtitleLabel.text = [NSString stringWithFormat:@"%ldmin",(long)self.course.during];
        
    }
    
    self.topCell.subtitle = self.courseType == CourseTypeGroup?self.batch.coach.name:self.batch.course.name;
    
    __weak typeof(self)weakS = self;
    
    self.info = [[CoursePlanDetailInfo alloc]init];
    
    self.info.requestFinish = ^(BOOL success){
        
        if (success) {
            
            weakS.batch = weakS.info.batch;
            
            weakS.batch.course.type = weakS.courseType;
            
            if (weakS.batch.yards.count == 1) {
                
                weakS.yardCell.subtitle = ((Yard*)[weakS.batch.yards firstObject]).name;
                
            }else if(weakS.batch.yards.count)
            {
                
                weakS.yardCell.subtitle = [NSString stringWithFormat:@"%ld处场地",(unsigned long)weakS.batch.yards.count];
                
            }
            
            if ((weakS.batch.cardKinds.count || weakS.batch.onlinePays.count)&&!weakS.batch.isFree) {
                
                weakS.cardCell.subtitle = @"已设置";
                
            }else if (weakS.batch.isFree && weakS.batch.course.capacity){
                
                weakS.cardCell.subtitle = @"已设置";
                
            }
            
        }
        
    };
    
    [self.info requestWithBatchId:self.batch.batchId];
    
}

-(void)createUI
{
    
    self.title = @"课程排期";
    
    self.rightTitle = @"确定";
    
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
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(35), Width320(7.5), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [topButton addSubview:arrow];
        
    }
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom-1/[UIScreen mainScreen].scale, MSW-Width320(32), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    self.topCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom, MSW-Width320(32), Height320(40))];
    
    self.topCell.titleLabel.text = self.courseType == CourseTypeGroup?@"教练":@"课程";
    
    self.topCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.topCell.subtitleColor = UIColorFromRGB(0x333333);
    
    self.topCell.tag = 101;
    
    if (self.courseType == CourseTypeGroup) {
        
        self.topCell.haveArrow = NO;
        
    }
    
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
    
    [self.cardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.cardCell];
    
    UILabel *courseLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(14), Width320(100), Height320(16))];
    
    courseLabel.text = @"课程排期";
    
    courseLabel.textColor = UIColorFromRGB(0x999999);
    
    courseLabel.font = AllFont(14);
    
    [self.mainView addSubview:courseLabel];
    
    UIButton *timeView = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(40), MSW, Height320(64))];
    
    timeView.backgroundColor = UIColorFromRGB(0xffffff);
    
    timeView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    timeView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:timeView];
    
    [timeView addTarget:self action:@selector(batchDetail) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *calendarImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(22), Width320(20), Height320(20))];
    
    calendarImg.image = [UIImage imageNamed:@"course_plan_calendar"];
    
    [timeView addSubview:calendarImg];
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(48), Height320(11), Width320(150), Height320(16))];
    
    startLabel.text = self.batch.start;
    
    startLabel.textColor = UIColorFromRGB(0x333333);
    
    startLabel.font = AllFont(14);
    
    [timeView addSubview:startLabel];
    
    UILabel  *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(startLabel.left, startLabel.bottom+Height320(8), startLabel.width, startLabel.height)];
    
    endLabel.text = self.batch.end;
    
    endLabel.textColor = UIColorFromRGB(0x333333);
    
    endLabel.font = AllFont(14);
    
    [timeView addSubview:endLabel];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(80), Height320(24), Width320(48), Height320(16))];
    
    detailLabel.text = @"详情";
    
    detailLabel.textColor = UIColorFromRGB(0x999999);
    
    detailLabel.font = AllFont(14);
    
    detailLabel.textAlignment = NSTextAlignmentRight;
    
    [timeView addSubview:detailLabel];
    
    UIImageView *timeArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(26), Width320(7.5), Height320(12))];
    
    timeArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [timeView addSubview:timeArrow];
    
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.mainView.height-Height320(40), MSW, Height320(40))];
    
    deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [deleteButton setTitle:@"删除该排期" forState:UIControlStateNormal];
    
    [deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    deleteButton.titleLabel.font = AllFont(14);
    
    [self.mainView addSubview:deleteButton];
    
    [deleteButton addTarget:self action:@selector(deleteBatch) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (!permission.editState) {
        
        self.topCell.haveArrow = self.yardCell.haveArrow = self.cardCell.haveArrow = NO;
        
        self.topCell.userInteractionEnabled = self.yardCell.userInteractionEnabled = self.cardCell.userInteractionEnabled = NO;
        
    }
    
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
        
        [[[UIAlertView alloc]initWithTitle:@"确定删除该排期吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
        
        [info deleteBatch:self.batch result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"删除成功";
                
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
    
}

-(void)batchDetail
{
    
    CoursePlanBatchEditController *svc = [[CoursePlanBatchEditController alloc]init];
    
    svc.batch = self.batch;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)topClick
{
    
    if (self.courseType == CourseTypeGroup) {
        
        CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
        
        svc.isAdd = NO;
        
        svc.batch = self.batch;
        
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
        
    }
    
}

-(void)cellClick:(MOCell *)cell
{
    
    if (cell.tag == 101) {
        
        if (self.courseType == CourseTypeGroup) {
            
        }else
        {
            
            CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
            
            svc.isAdd = NO;
            
            svc.batch = self.batch;
            
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
        
        svc.batch = self.batch;
        
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
        
    }else
    {
        
        CoursePlanWayController *svc = [[CoursePlanWayController alloc]init];
        
        svc.isAdd = NO;
        
        svc.batch = [self.batch copy];
        
        __weak typeof(self)weakS = self;
        
        svc.setFinish = ^(CoursePlanBatch *batch){
            
            self.batch = batch;
            
            if ((weakS.batch.cardKinds.count || weakS.batch.onlinePays.count)&&!weakS.batch.isFree) {
                
                weakS.cardCell.subtitle = @"已设置";
                
            }else if (weakS.batch.isFree && weakS.batch.course.capacity){
                
                weakS.cardCell.subtitle = @"已设置";
                
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
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
            
            [self.hud hideAnimated:YES];
            
            [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }];
    
}

@end
