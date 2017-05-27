//
//  CourseArrangeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseArrangeController.h"

#import "ChooseView.h"

#import "CourseArrangeInfo.h"

#import "CoursePlanBatchCell.h"

#import "CoursePlanPrivateController.h"

#import "CoursePlanGroupController.h"

#import "CoursePlanAddChooseCoachController.h"

#import "CoursePlanAddChooseCourseController.h"

#import "WebViewController.h"

#import "MOTableView.h"

#import "CourseListController.h"

#import "MOMenuView.h"

#import "CourseAstrictController.h"

#import "FunctionHintController.h"

#import "NotificationSettingController.h"

#define GroupHelpURL @"http://cloud.qingchengfit.cn/mobile/urls/e382d87968dd4f54a89bb5e5a933f779/"

#define PrivateHelpURL @"http://cloud.qingchengfit.cn/mobile/urls/34890304d8bc40ba9677ca8d99bcd02a/"

static NSString *identifier = @"Cell";

@interface CourseArrangeController ()<UITableViewDelegate,MOTableViewDatasource,MOMenuDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CourseArrangeInfo *info;

@property(nonatomic,strong)UIView *courseHeader;

@property(nonatomic,strong)UIButton *courseButton;

@property(nonatomic,strong)NSDateFormatter *dateFormatter;

@property(nonatomic,strong)UIButton *addButton;

@end

@implementation CourseArrangeController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dateFormatter = [[NSDateFormatter alloc]init];
        
        self.dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
        
    }
    return self;
}

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
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    self.info = [[CourseArrangeInfo alloc]init];
    
    [self.info requestDataWithCourseType:self.courseType result:^(BOOL success, NSString *error) {
        
        [self.tableView.mj_header endRefreshing];
        
        self.tableView.dataSuccess = success;
        
        if (self.courseType == CourseTypeGroup) {
            
            [self.tableView reloadData];
            
            self.courseHeader.hidden = !self.info.groups.count;
            
            self.courseButton.hidden = !self.info.groups.count;
            
            self.addButton.hidden = !self.info.groups.count;
            
        }else{
            
            [self.tableView reloadData];
            
            self.courseHeader.hidden = !self.info.privates.count;
            
            self.courseButton.hidden = !self.info.privates.count;
            
            self.addButton.hidden = !self.info.privates.count;
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.courseType == CourseTypeGroup?@"团课":@"私教";
    
    self.rightType = MONaviRightTypeMore;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.tableView registerClass:[CoursePlanBatchCell class] forCellReuseIdentifier:identifier];
    
    self.courseHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    self.courseHeader.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.courseHeader.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.courseHeader.layer.borderWidth = OnePX;
    
    self.tableView.tableHeaderView = self.courseHeader;
    
    self.courseHeader.hidden = YES;
    
    UILabel *courseLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(150), Height320(40))];
    
    courseLabel.textColor = UIColorFromRGB(0x999999);
    
    courseLabel.font = AllFont(13);
    
    courseLabel.text = self.courseType == CourseTypeGroup?@"团课排期":@"私教排期";
    
    [self.courseHeader addSubview:courseLabel];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(47))];
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    helpButton.frame = CGRectMake(MSW/2-Width320(77), self.tableView.tableFooterView.height-Height320(38),Width320(154), Height320(27));
    
    [helpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView.tableFooterView addSubview:helpButton];
    
    UIImageView *helpImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(18), Height320(7), Width320(13), Height320(13))];
    
    helpImg.image = [[UIImage imageNamed:@"hint_circle"]imageWithTintColor:UIColorFromRGB(0xbbbbbb)];
    
    [helpButton addSubview:helpImg];
    
    UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(helpImg.right+Width320(4), 0, helpButton.width-helpImg.right-Width320(4), helpButton.height)];
    
    helpLabel.text = self.courseType == CourseTypeGroup?@"如何添加团课排期？":@"如何添加私教排期？";
    
    helpLabel.textColor = UIColorFromRGB(0x888888);
    
    helpLabel.font = AllFont(12);
    
    [helpButton addSubview:helpLabel];
    
    [self.view addSubview:self.tableView];
    
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(74), MSH-Height320(75), Width320(48), Height320(48))];
    
    [self.addButton setImage:[UIImage imageNamed:@"course_list_add"] forState:UIControlStateNormal];
    
    self.addButton.layer.shadowOffset = CGSizeMake(0, Height320(2));
    
    self.addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    self.addButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:self.addButton];
    
    [self.addButton addTarget:self action:@selector(courseAdd:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)naviRightClick
{
    
    MOMenuView *sheet = self.courseType == CourseTypeGroup?[MOMenuView menuWithTitie:nil delegate:self destructiveButtonTitle:nil cancelButtonTitle:nil otherButtonTitles:@"团课种类",@"团课预约限制",@"预约短信通知",@"课件",nil]:[MOMenuView menuWithTitie:nil delegate:self destructiveButtonTitle:nil cancelButtonTitle:nil otherButtonTitles:@"私教种类",@"私教预约限制",@"预约短信通知",@"课件",nil];
    
    sheet.textAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [sheet show];
    
}

-(void)actionSheet:(MOMenuView *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        if (self.courseType == CourseTypeGroup) {
            
            if ([PermissionInfo sharedInfo].permissions.groupPermission.readState) {
                
                CourseListController *svc = [[CourseListController alloc]init];
                
                svc.courseType = self.courseType;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }else{
            
            if ([PermissionInfo sharedInfo].permissions.privatePermission.readState) {
                
                CourseListController *svc = [[CourseListController alloc]init];
                
                svc.courseType = self.courseType;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }
        
    }else if (buttonIndex == 2){
        
        if (self.courseType == CourseTypeGroup) {
            
            if ([PermissionInfo sharedInfo].permissions.groupLimitPermission.editState) {
                
                CourseAstrictController *svc = [[CourseAstrictController alloc]init];
                
                svc.courseType = self.courseType;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }else{
            
            if ([PermissionInfo sharedInfo].permissions.privateLimitPermission.editState) {
                
                CourseAstrictController *svc = [[CourseAstrictController alloc]init];
                
                svc.courseType = self.courseType;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }
        
    }else if (buttonIndex == 3){
        
        if (self.courseType == CourseTypeGroup) {
            
            if ([PermissionInfo sharedInfo].permissions.groupMessagePermission.editState) {
                
                NotificationSettingController *svc = [[NotificationSettingController alloc]init];
                
                svc.courseType = self.courseType;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }else{
            
            if ([PermissionInfo sharedInfo].permissions.privateMessagePermission.editState) {
                
                NotificationSettingController *svc = [[NotificationSettingController alloc]init];
                
                svc.courseType = self.courseType;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }
        
    }else if(buttonIndex == 4){
        
        FunctionHintController *svc = [[FunctionHintController alloc]init];
        
        svc.module = self.courseType == CourseTypeGroup?@"/plans/setting":@"/private/course/plans/setting";
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)coursePreview:(UIButton*)button
{
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    if (self.courseType == CourseTypeGroup) {
        
        svc.url = self.info.groupURL;
        
    }else
    {
        
        svc.url = self.info.privateURL;
        
    }
    
    svc.completeAction = ^{
        
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)courseAdd:(UIButton*)button
{
    
    if (self.courseType == CourseTypeGroup) {
        
        if ([PermissionInfo sharedInfo].permissions.groupArrangePermission.addState) {
            
            CoursePlanAddChooseCourseController *svc = [[CoursePlanAddChooseCourseController alloc]init];
            
            svc.gym = self.gym;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else
    {
        
        if ([PermissionInfo sharedInfo].permissions.privateArrangePermission.addState) {
            
            CoursePlanAddChooseCoachController *svc = [[CoursePlanAddChooseCoachController alloc]init];
            
            svc.gym = self.gym;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.courseType == CourseTypeGroup?self.info.groups.count:self.info.privates.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(82);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePlanBatchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (self.courseType == CourseTypeGroup) {
        
        Course *course = self.info.groups[indexPath.row];
        
        cell.title = course.name;
        
        NSTimeInterval timeInterval = [[self.dateFormatter  dateFromString:course.end] timeIntervalSinceDate:[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:[NSDate date]]]];
        
        cell.subtitle = timeInterval>=0?[NSString stringWithFormat:@"%@ 至 %@，%ld节课程",course.start,course.end,(long)course.count]:@"无有效排期";
        
        cell.imgURL = course.imgUrl;
        
        cell.type = CourseTypeGroup;
        
    }else
    {
        
        Coach *coach = self.info.privates[indexPath.row];
        
        cell.title = coach.name;
        
        NSTimeInterval timeInterval = [[self.dateFormatter  dateFromString:coach.end] timeIntervalSinceDate:[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:[NSDate date]]]];
        
        cell.subtitle = timeInterval>=0?[NSString stringWithFormat:@"%@ 至 %@，%ld种课程",coach.start,coach.end,(long)coach.count]:@"无有效排期";
        
        cell.imgURL = coach.iconUrl;
        
        cell.type = CourseTypePrivate;
        
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.courseType == CourseTypeGroup) {
        
        CoursePlanGroupController *svc = [[CoursePlanGroupController alloc]init];
        
        Course *course = self.info.groups[indexPath.row];
        
        svc.course = course;
        
        svc.gym = self.gym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else
    {
        
        CoursePlanPrivateController *svc = [[CoursePlanPrivateController alloc]init];
        
        Coach *coach = self.info.privates[indexPath.row];
        
        svc.coach = coach;
        
        svc.gym = self.gym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIScrollView *emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(88), Width320(190), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"course_arrange_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(18))];
    
    emptyLabel.text = self.courseType == CourseTypeGroup?@"暂无团课排期":@"暂无私教排期";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(14);
    
    [emptyView addSubview:emptyLabel];
    
    UIButton *emptyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(69), emptyLabel.bottom+Height320(30), Width320(138), Height320(40))];
    
    emptyButton.backgroundColor = kMainColor;
    
    [emptyButton setTitle:self.courseType == CourseTypeGroup?@"+ 添加团课排期":@"+ 添加私教排期" forState:UIControlStateNormal];
    
    [emptyButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    emptyButton.titleLabel.font = AllFont(14);
    
    emptyButton.tag = tableView.tag;
    
    [emptyButton addTarget:self action:@selector(courseAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    [emptyView addSubview:emptyButton];
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    helpButton.frame = CGRectMake(MSW/2-Width320(77), emptyView.height-Height320(38),Width320(154), Height320(27));
    
    [helpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    [emptyView addSubview:helpButton];
    
    UIImageView *helpImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(18), Height320(7), Width320(13), Height320(13))];
    
    helpImg.image = [[UIImage imageNamed:@"hint_circle"]imageWithTintColor:UIColorFromRGB(0xbbbbbb)];
    
    [helpButton addSubview:helpImg];
    
    UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(helpImg.right+Width320(4), 0, helpButton.width-helpImg.right-Width320(4), helpButton.height)];
    
    helpLabel.text = self.courseType == CourseTypeGroup?@"如何添加团课排期？":@"如何添加私教排期？";
    
    helpLabel.textColor = UIColorFromRGB(0x888888);
    
    helpLabel.font = AllFont(12);
    
    [helpButton addSubview:helpLabel];
    
    return emptyView;
    
}

-(void)help
{
    
    WebViewController *vc = [[WebViewController alloc]init];
    
    vc.url = [NSURL URLWithString:self.courseType == CourseTypeGroup?GroupHelpURL:PrivateHelpURL];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
