//
//  CoursePlanPrivateController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanPrivateController.h"

#import "CoursePlanCell.h"

#import "CoursePlanInfo.h"

#import "CoursePlanDetailController.h"

#import "CoursePlanAddController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoursePlanPrivateController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)CoursePlanInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UILabel *subLabel;

@property(nonatomic,strong)NSDateFormatter *dateFormatter;

@end

@implementation CoursePlanPrivateController

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

-(void)createData
{
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    CoursePlanInfo *info = [[CoursePlanInfo alloc]init];
    
    info.coach = self.coach;
    
    info.gym = self.gym;
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CoursePlanInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        weakS.info = weakInfo;
        
        [weakS.tableView reloadData];
        
        weakS.subLabel.text = [NSString stringWithFormat:@"累计%ld节，服务%ld人次",(long)weakS.info.coach.courseCount,(long)weakS.coach.serviceCount];
        
    };
    
    [info requestPrivateData];
    
}

-(void)reloadData
{
    
    [self createData];
    
}

-(void)createUI
{
    
    self.title = @"私教排期";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CoursePlanCell class] forCellReuseIdentifier:identifier];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(94))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = header;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(82))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [header addSubview:topView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(50), Height320(50))];
    
    iconView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
    
    iconView.layer.borderWidth = 1;
    
    iconView.layer.masksToBounds = YES;
    
    iconView.layer.cornerRadius = iconView.width/2;
    
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    [iconView sd_setImageWithURL:self.coach.iconUrl];
    
    [topView addSubview:iconView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(78), Height320(22), MSW-Width320(110), Height320(17))];
    
    nameLabel.text = self.coach.name;
    
    nameLabel.textColor = UIColorFromRGB(0x333333);
    
    nameLabel.font = AllFont(15);
    
    [topView addSubview:nameLabel];
    
    self.subLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom+Height320(6), nameLabel.width, Height320(15))];
    
    self.subLabel.textColor = UIColorFromRGB(0x666666);
    
    self.subLabel.font = AllFont(13);
    
    [topView addSubview:self.subLabel];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, header.height-topView.bottom)];
    
    bottomView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    bottomView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [header addSubview:bottomView];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(74), MSH-Height320(75), Width320(48), Height320(48))];
    
    [addButton setImage:[UIImage imageNamed:@"course_list_add"] forState:UIControlStateNormal];
    
    addButton.layer.shadowOffset = CGSizeMake(0, Height320(2));
    
    addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    addButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addClick
{
    
    if ([PermissionInfo sharedInfo].permissions.privateArrangePermission.addState) {
        
        CoursePlanAddController *svc = [[CoursePlanAddController alloc]init];
        
        svc.coach = self.coach;
        
        svc.gym = self.gym;
        
        svc.courseType = CourseTypePrivate;
        
        __weak typeof(self)weakS = self;
        
        svc.addFinish = ^{
            
            [weakS createData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.batches.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CoursePlanBatch *batch = self.info.batches[indexPath.row];
    
    cell.title = [NSString stringWithFormat:@"%@ 至 %@",batch.start,batch.end];
    
    cell.subtitle = batch.course.name;
    
    cell.imgURL = batch.course.imgUrl;
    
    cell.type = CourseTypePrivate;
    
    cell.outTime = [[self.dateFormatter dateFromString:batch.end] timeIntervalSinceDate:[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:[NSDate date]]]]<0;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(82);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePlanDetailController *svc = [[CoursePlanDetailController alloc]init];
    
    CoursePlanBatch *batch = self.info.batches[indexPath.row];
    
    svc.batch = batch;
    
    svc.coach = self.coach;
    
    svc.courseType = CourseTypePrivate;
    
    svc.gym = self.gym;
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
       
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
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


@end
