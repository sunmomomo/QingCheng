//
//  CoursePlanBatchEditController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanBatchEditController.h"

#import "CoursePlanEditCell.h"

#import "CoursePlanDetailCell.h"

#import "MOTableView.h"

#import "CourseBatchSingleEditController.h"

static NSString *identifier = @"Cell";

static NSString *editIdentifier = @"Edit";

@interface CoursePlanBatchEditController ()<MOTableViewDatasource,UITableViewDelegate,MONaviDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)NSMutableArray *deleteIndexPaths;

@property(nonatomic,strong)NSIndexPath *currentIndexPath;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIView *touchView;

@property(nonatomic,assign)BOOL isEditing;

@end

@implementation CoursePlanBatchEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.deleteIndexPaths = [NSMutableArray array];
        
    }
    return self;
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    CoursePlanBatchesInfo *info = [[CoursePlanBatchesInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CoursePlanBatchesInfo*)weakInfo = info;
    
    info.request = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        if (success) {
            
            weakS.info = weakInfo;
            
            [weakS.tableView reloadData];
            
        }
        
    };
    
    [info requestWithCourse:self.batch.course andBatchId:self.batch.batchId];
    
}

-(void)createUI
{
    
    self.title = self.batch.course.type == CourseTypeGroup?@"所有课程":@"所有排期";
    
    self.rightTitle = @"编辑";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[CoursePlanEditCell class] forCellReuseIdentifier:editIdentifier];
    
    [self.tableView registerClass:[CoursePlanDetailCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, MSH-Height320(40), MSW, Height320(40))];
    
    self.deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.deleteButton setTitle:self.batch.course.type == CourseTypeGroup?@"删除所选课程":@"删除所选排期" forState:UIControlStateNormal];
    
    [self.deleteButton setTitleColor:UIColorFromRGB(0xEA6161) forState:UIControlStateNormal];
    
    self.deleteButton.titleLabel.font = STFont(14);
    
    [self.view addSubview:self.deleteButton];
    
    self.deleteButton.hidden = YES;
    
    [self.deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    self.touchView = [[UIView alloc]initWithFrame:self.view.frame];
    
    self.touchView.backgroundColor = [UIColor clearColor];
    
    [self.touchView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchTap:)]];
    
    [self.view addSubview:self.touchView];
    
    self.touchView.hidden = YES;
    
}

-(void)touchTap:(UITapGestureRecognizer*)tap
{
    
    self.touchView.hidden = YES;
    
    [self.view endEditing:YES];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
                
        NSString *ids = @"";
        
        for (NSIndexPath *indexPath in self.deleteIndexPaths) {
            
            CoursePlan *plan = self.info.data[indexPath.section][@"data"][indexPath.row];
            
            ids = [ids stringByAppendingString:[NSString stringWithInteger:plan.planId]];
            
            if ([self.deleteIndexPaths indexOfObject:indexPath]<self.deleteIndexPaths.count-1) {
                
                ids = [ids stringByAppendingString:@","];
                
            }
            
        }
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:ids forKey:@"ids"];
        
        if (AppGym.type.length &&AppGym.gymId) {
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
            
            [para setParameter:AppGym.type forKey:@"model"];
            
        }else if(AppGym.shopId && AppGym.brand.brandId){
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
            
            [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
            
        }
        
        [self.info deleteWithPara:para andCourse:self.batch.course];
        
        [self.hud showAnimated:YES];
        
        __weak typeof(self)weakS = self;
        
        self.info.deleteFinish = ^(BOOL success){
            
            if (success) {
                
                weakS.hud.mode = MBProgressHUDModeText;
                
                weakS.hud.label.text = @"删除成功";
                
                [weakS.hud hideAnimated:YES afterDelay:1.5];
                
                [weakS.deleteIndexPaths removeAllObjects];
                
                weakS.deleteButton.hidden = YES;
                
                [weakS.tableView changeHeight:MSH-64];
                
                [weakS createData];
                
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

-(void)deleteClick:(UIButton*)button
{
    
    Permission *permission;
    
    if (self.batch.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupArrangePermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privateArrangePermission;
        
    }
    
    if (permission.deleteState) {
        
        [[[UIAlertView alloc]initWithTitle:@"确定删除所选排期吗？已预约的课程不会被删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.info.data.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.info.data[section][@"data"] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(40);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), Height320(40))];
    
    sectionLabel.text = [NSString stringWithFormat:@"%@排期",self.info.data[section][@"title"]];
    
    sectionLabel.textColor = UIColorFromRGB(0x999999);
    
    sectionLabel.font = STFont(16);
    
    [view addSubview:sectionLabel];
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(42);
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isEditing) {
        
        CoursePlanEditCell *cell = [tableView dequeueReusableCellWithIdentifier:editIdentifier];
        
        CoursePlan *plan = self.info.data[indexPath.section][@"data"][indexPath.row];
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        df.dateFormat = @"yyyy-MM-dd HH:mm";
        
        if ([[df dateFromString:[NSString stringWithFormat:@"%@ %@",plan.date,plan.startTime]] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]]<0) {
            
            cell.canEdit = NO;
            
        }else
        {
            
            cell.canEdit = YES;
            
        }
        
        cell.day = plan.date;
        
        cell.week = plan.week;
        
        cell.indexPath = indexPath;
        
        cell.time = self.batch.course.type == CourseTypePrivate?plan.startTime.length?[NSString stringWithFormat:@"%@-%@",plan.startTime,plan.endTime]:@"":plan.startTime;
        
        cell.isChoosed = [self.deleteIndexPaths containsObject:indexPath];
        
        return cell;
        
    }else{
        
        CoursePlanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        CoursePlan *plan = self.info.data[indexPath.section][@"data"][indexPath.row];
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        df.dateFormat = @"yyyy-MM-dd HH:mm";
        
        cell.outTime = [[df dateFromString:[NSString stringWithFormat:@"%@ %@",plan.date,plan.startTime]] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]]<0;
        
        cell.day = plan.date;
        
        cell.week = plan.week;
        
        cell.indexPath = indexPath;
        
        cell.time = self.batch.course.type == CourseTypePrivate?plan.startTime.length?[NSString stringWithFormat:@"%@-%@",plan.startTime,plan.endTime]:@"":plan.startTime;
        
        return cell;
        
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.touchView.hidden = NO;
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(50), Height320(75.5), Width320(100), Height320(100))];
    
    emptyImg.image = [UIImage imageNamed:@"emptyreport"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(16), MSW, Height320(15))];
    
    emptyLabel.text = @"无详细排期";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isEditing) {
        
        if ([self.deleteIndexPaths containsObject:indexPath]) {
            
            [self.deleteIndexPaths removeObject:indexPath];
            
        }else
        {
            
            [self.deleteIndexPaths addObject:indexPath];
            
        }
        
        if (self.deleteIndexPaths.count) {
            
            self.deleteButton.hidden = NO;
            
            [self.tableView changeHeight:MSH-64-Height320(40)];
            
        }else
        {
            
            self.deleteButton.hidden = YES;
            
            [self.tableView changeHeight:MSH-64];
            
        }
        
        [self.tableView reloadData];
        
    }else{
        
        CourseBatchSingleEditController *svc = [[CourseBatchSingleEditController alloc]init];
        
        CoursePlan *plan = self.info.data[indexPath.section][@"data"][indexPath.row];
        
        svc.plan = [plan copy];
        
        svc.plan.course = self.batch.course;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)naviRightClick
{
    
    self.isEditing = !self.isEditing;
    
    self.rightTitle = self.isEditing?@"完成":@"编辑";
    
    if (!self.isEditing) {
        
        [self.deleteIndexPaths removeAllObjects];
        
        self.deleteButton.hidden = YES;
        
        [self.tableView changeHeight:MSH-64];
        
    }
    
    [self.tableView reloadData];
    
}

@end
