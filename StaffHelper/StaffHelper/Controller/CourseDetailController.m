
//
//  CourseDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseDetailController.h"

#import "CoverPictureView.h"

#import "CoursePictureController.h"

#import "CourseEditController.h"

#import "CourseCoverImageController.h"

#import "HorizontalGradientView.h"

#import "CourseDetailInfo.h"

#import "CourseInfoView.h"

#import "CourseRateView.h"

#import "CourseCoachView.h"

#import "CourseSummaryView.h"

#import "FunctionHintController.h"

#import "CourseRateController.h"

#import "CourseCoachRateController.h"

#import "CourseListInfo.h"

#import <MediaPlayer/MediaPlayer.h>

#import "PictureShowController.h"

@interface CourseDetailController ()<CoverPictureViewDatasource,UIActionSheetDelegate,UIAlertViewDelegate,MPMediaPickerControllerDelegate>

@property(nonatomic,strong)CourseDetailInfo *info;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)CoverPictureView *coverView;

@property(nonatomic,strong)CourseInfoView *basicView;

@property(nonatomic,strong)CourseRateView *rateView;

@property(nonatomic,strong)CourseCoachView *coachView;

@property(nonatomic,strong)CourseSummaryView *summaryView;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    
    [self.info requestWithCourse:self.course result:^(BOOL success, NSString *error) {
        
        [self.mainView.mj_header endRefreshing];
        
        if (success) {
            
            self.course = self.info.course;
            
        }
        
        self.coverView.datasource = self;
        
        self.basicView.course = self.info.course;
        
        [self.rateView changeTop:self.basicView.bottom+Height320(12)];
        
        self.rateView.grades = self.course.rate.rates;
        
        [self.rateView setCoachGrade:self.course.rate.coachRate andCourseGrade:self.course.rate.courseRate andServiceGrade:self.course.rate.serviceRate];
        
        self.coachView.coaches = self.course.coaches;
        
        [self.coachView changeTop:self.rateView.bottom+Height320(12)];
        
        [self.summaryView changeTop:self.coachView.bottom+Height320(12)];
        
        self.summaryView.htmlData = self.course.htmlData;
        
    }];
    
}

-(void)createData
{
    
    self.info = [[CourseDetailInfo alloc]init];
    
    [self reloadData];
    
}

-(void)createUI
{
    
    self.title = @"课程种类详情";
    
    self.rightType = MONaviRightTypeMore;
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.mainView.mj_header = header;
    
    self.coverView = [[CoverPictureView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(240))];
    
    self.coverView.datasource = self;
    
    [self.mainView addSubview:self.coverView];
    
    UIButton *coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Width320(158), Height320(26))];
    
    [coverButton addTarget:self action:@selector(coverChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.coverView addSubview:coverButton];
    
    HorizontalGradientView *coverButtonBack = [[HorizontalGradientView alloc]initWithFrame:CGRectMake(0, 0, coverButton.width, coverButton.height)];
    
    coverButtonBack.leftColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    coverButtonBack.rightColor = [UIColor clearColor];
    
    [coverButton addSubview:coverButtonBack];
    
    UIImageView *coverImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(7), Width320(12), Height320(12))];
    
    coverImg.image = [UIImage imageNamed:@"navi_edit"];
    
    [coverButton addSubview:coverImg];
    
    UILabel *coverLabel = [[UILabel alloc]initWithFrame:CGRectMake(coverImg.right+Width320(4), 0, coverButton.width-Width320(4)-coverImg.right, coverButton.height)];
 
    coverLabel.text = @"编辑封面照片";
    
    coverLabel.textColor = UIColorFromRGB(0xffffff);
    
    coverLabel.font = AllFont(12);
    
    [coverButton addSubview:coverLabel];
    
    self.basicView = [[CourseInfoView alloc]initWithFrame:CGRectMake(0, self.coverView.bottom, MSW, Height320(220))];
    
    [self.basicView addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:self.basicView];
    
    self.rateView = [[CourseRateView alloc]initWithFrame:CGRectMake(0, self.basicView.bottom+Height320(12), MSW, Height320(220))];
    
    [self.rateView addTarget:self action:@selector(rateShow) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:self.rateView];
    
    self.coachView = [[CourseCoachView alloc]initWithFrame:CGRectMake(0, self.rateView.bottom+Height320(12), MSW, Height320(220))];
    
    [self.mainView addSubview:self.coachView];
    
    self.summaryView = [[CourseSummaryView alloc]initWithFrame:CGRectMake(0, self.coachView.bottom+Height320(12), MSW, Height320(77))];
    
    [self.summaryView addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];

    [self.mainView addSubview:self.summaryView];
    
    self.mainView.contentSize = CGSizeMake(0, self.summaryView.bottom);
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}


-(void)editCourse
{
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupPermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privatePermission;
        
    }
    
    if ((AppGym && permission.editState)||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit])) {
        
        CourseEditController *svc = [[CourseEditController alloc]init];
        
        svc.course = self.course;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS reloadData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else
    {
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)rateShow
{
    
    if (AppGym) {
        
        CourseCoachRateController *svc = [[CourseCoachRateController alloc]init];
        
        svc.course = self.course;
        
        svc.gym = AppGym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        CourseRateController *svc = [[CourseRateController alloc]init];
        
        svc.course = self.course;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)scan
{
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupPermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privatePermission;
        
    }
    
    if ((AppGym &&self.course.gyms.count == 1 && permission.editState)||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]==PermissionStateAll)) {
        
        FunctionHintController *svc = [[FunctionHintController alloc]init];
        
        svc.url = self.course.summaryURL.absoluteString;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (AppGym && self.course.gyms.count >1){
        
        [[[UIAlertView alloc]initWithTitle:@"此课程种类适用于多个场馆，请在【连锁运营】里对简介详情进行编辑。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
    }else if (!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]!=PermissionStateAll && self.course.gyms.count>1){
        
        [[[UIAlertView alloc]initWithTitle:@"此课程种类适用于多个场馆，仅在所有适用场馆下都具有编辑课程种类权限的用户才能进行编辑。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)coverChange
{
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupPermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privatePermission;
        
    }
    
    if ((AppGym &&self.course.gyms.count == 1 && permission.editState)||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]==PermissionStateAll)) {
        
        CourseCoverImageController *svc = [[CourseCoverImageController alloc]init];
        
        svc.course = self.course;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (AppGym && self.course.gyms.count >1){
        
        [[[UIAlertView alloc]initWithTitle:@"此课程种类适用于多个场馆，请在【连锁运营】里对封面照片进行编辑。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
    }else if (!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]!=PermissionStateAll && self.course.gyms.count>1){
        
        [[[UIAlertView alloc]initWithTitle:@"此课程种类适用于多个场馆，仅在所有适用场馆下都具有编辑课程种类权限的用户才能进行编辑。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(NSInteger)pictureNumberOfCoverPicutreView:(CoverPictureView *)cview
{
    
    return self.course.covers.count;
    
}

-(UIImage*)coverPictureView:(CoverPictureView *)cview pictureURLInIndex:(NSInteger)index
{
    
    return self.course.covers[index];
    
}

-(void)showAllPicture
{
    
    CoursePictureController *svc = [[CoursePictureController alloc]init];
    
    svc.course = self.course;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)coverPictureView:(CoverPictureView *)cview pictureSelectedAtIndex:(NSInteger)index
{
    
    if (self.course.covers.count) {
        
        NSURL *url = self.course.covers[index];
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = url;
        
        [self presentViewController:svc animated:YES completion:^{
            
        }];
        
    }
    
}

-(void)naviRightClick
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除该课程种类" otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        UIAlertView *alert;
        
        Permission *permission;
        
        if (self.course.type == CourseTypeGroup) {
            
            permission = [PermissionInfo sharedInfo].permissions.groupPermission;
            
        }else{
            
            permission = [PermissionInfo sharedInfo].permissions.privatePermission;
            
        }
        
        if (!AppGym&&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeDelete] != PermissionStateAll && self.course.gyms.count>1) {
            
            alert = [[UIAlertView alloc]initWithTitle:@"无删除权限" message:@"此课程种类适用于多个场馆，仅在所有适用场馆下都具有删除课程种类权限的用户才能进行删除。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            
        }else if(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeDelete] == PermissionStateAll){
            
            alert = [[UIAlertView alloc]initWithTitle:@"确定删除该课程种类？" message:@"删除后，已有的排期和课程预约都不会受到影响" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            
        }else if (AppGym &&self.course.gyms.count>1){
            
            alert = [[UIAlertView alloc]initWithTitle:@"无删除权限" message:@"此课程种类适用于多个场馆，请在【连锁运营】中删除课程种类" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            
        }else if(AppGym && permission.deleteState){
            
            alert = [[UIAlertView alloc]initWithTitle:@"确定删除该课程种类？" message:@"删除后，已有的排期和课程预约都不会受到影响" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            
        }else
        {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
        [alert show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        CourseListInfo *info = [[CourseListInfo alloc]init];
        
        [info deleteCourse:self.course result:^(BOOL success, NSString *error) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            if (success) {
                
                self.hud.label.text = @"删除成功";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

@end
