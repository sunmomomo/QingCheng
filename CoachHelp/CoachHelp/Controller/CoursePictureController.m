//
//  CoursePictureController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePictureController.h"

#import "CoursePictureShowController.h"

#import "CoursePictureCell.h"

#import "WebViewController.h"

#import "CoursePicturesInfo.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoursePictureController ()<UITableViewDelegate,MOTableViewDatasource,CoursePictureCellDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CoursePicturesInfo *info;

@end

@implementation CoursePictureController

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
    
    self.info = [[CoursePicturesInfo alloc]init];
    
    [self.info requestWithCourse:self.course result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
        if (success) {
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

-(void)updateData
{
    
    [self.info requestWithCourse:self.course result:^(BOOL success, NSString *error) {
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
        if (success) {
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"全部课程照片";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CoursePictureCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self updateData];
        
    }];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.batches.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CoursePlanBatch *batch = self.info.batches[indexPath.row];
    
    cell.courseName = batch.course.name;
    
    cell.coachName = batch.coach.name;
    
    cell.gymName = batch.gym.name;
    
    cell.courseTime = [NSString stringWithFormat:@"%@  %@-%@",batch.date,batch.start,batch.end];
    
    cell.pictures = batch.pictures;
    
    cell.delegate = self;
    
    cell.tag = indexPath.row;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePlanBatch *batch = self.info.batches[indexPath.row];
    
    if (batch.pictures.count) {
        
        return Height320(56)+Height320(12)+Height320(106)*((batch.pictures.count-1)/3+1)+Height320(2)*((batch.pictures.count-1)/3);
        
    }else{
        
        return Height320(105);
        
    }
    
}

-(void)pictureCell:(CoursePictureCell *)cell pictureSelectedAtIndex:(NSInteger)index
{
    
    CoursePictureShowController *svc = [[CoursePictureShowController alloc]init];
    
    CoursePlanBatch *batch = self.info.batches[cell.tag];
    
    svc.coursePictures = batch.pictures;
    
    svc.selectNumber = index;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)manageOfCoursePictureCellClick:(CoursePictureCell *)cell
{
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    CoursePlanBatch *batch = self.info.batches[cell.tag];
    
    svc.url = batch.courseURL;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(73), Height320(106), Width320(174), Height320(146))];
    
    emptyImg.image = [UIImage imageNamed:@"course_picture_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), emptyView.width, Height320(16))];
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.text = @"暂无课程照片";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textAlignment  = NSTextAlignmentCenter;
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

@end
