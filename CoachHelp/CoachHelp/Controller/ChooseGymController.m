//
//  ChooseGymController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ChooseGymController.h"

#import "SearchCell.h"

#include "SearchInfo.h"

#import "DistrictInfo.h"

#import "BrandListController.h"

#import "WorkEditController.h"

static NSString *identifier = @"Cell";

@interface ChooseGymController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong)UITextField *searchTF;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)SearchInfo *searchInfo;

@end

@implementation ChooseGymController

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
    
    SearchInfo *info = [[SearchInfo alloc]initGymInfoWithStr:self.searchTF.text];
    
    __weak typeof(SearchInfo*)weakInfo = info;
    
    __weak typeof(self)weakS = self;
    
    info.request = ^(BOOL success){
        
        if (success) {
            
            weakS.tableView.emptyDataSetSource = weakS;
            
            weakS.searchInfo = weakInfo;
            
            weakS.tableView.tableFooterView.hidden = YES;
            
        }
        
        [weakS.tableView reloadData];
        
    };
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(81))];
    
    topView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:topView];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(180), Height320(18))];
    
    topLabel.text = @"请先选择您工作的健身房";
    
    topLabel.textColor = UIColorFromRGB(0x999999);
    
    topLabel.font = AllFont(14);
    
    [topView addSubview:topLabel];
    
    self.searchTF = [[UITextField alloc]initWithFrame:CGRectMake(Width320(12), topLabel.bottom+Height320(4), MSW-Width320(24), Height320(36))];
    
    self.searchTF.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.searchTF.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.searchTF.layer.borderWidth = 0.5;
    
    self.searchTF.returnKeyType = UIReturnKeySearch;
    
    self.searchTF.font = AllFont(14);
    
    UIView *searchLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(32), Height320(36))];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(7), 0, Width320(18), Height320(18))];
    
    searchImg.image = [UIImage imageNamed:@"choosesearch"];
    
    searchImg.center = CGPointMake(searchImg.center.x, self.searchTF.height/2);
    
    [searchLeft addSubview:searchImg];
    
    self.searchTF.leftView = searchLeft;
    
    self.searchTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchTF.placeholder = @"搜索健身房（至少3个字）";
    
    self.searchTF.delegate = self;
    
    [self.searchTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.searchTF];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, MSH-topView.bottom) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[SearchCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(65), 0, 0);
    
    [self.view addSubview:self.tableView];
    
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(53))];
    
    tableFooterView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(Width320(71), Height320(5), MSW-Width320(142), Height320(43));
    
    addBtn.backgroundColor = kMainColor;
    
    [addBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [addBtn setTitle:@"添加健身房" forState:UIControlStateNormal];
    
    [tableFooterView addSubview:addBtn];
    
    [addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = tableFooterView;
    
    self.tableView.tableFooterView.hidden = YES;
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    [self.searchTF resignFirstResponder];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.searchTF.text.length>=3) {
        
        if (self.searchInfo.gymArr.count) {
            
            self.tableView.tableFooterView.hidden = NO;
            
        }
        
        return self.searchInfo.gymArr.count;
        
    }else
    {
        
        return self.searchInfo.hotGymArr.count;
        
    }
    
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if (self.searchTF.text.length<3) {
        
        return nil;
        
    }
    
    UIScrollView *emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.tableView.height)];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    emptyView.mj_header = header;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(40), MSW, Height320(40))];
    
    label.textColor = UIColorFromRGB(0x666666);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.numberOfLines = 2;
    
    label.font = STFont(14);
    
    [emptyView addSubview:label];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(Width320(71), label.bottom+Height320(27), MSW-Width320(142), Height320(43));
    
    addBtn.backgroundColor = kMainColor;
    
    [addBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [emptyView addSubview:addBtn];
    
    [addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    label.text = @"没有匹配的健身房\n您可以添加该健身房";
    
    [addBtn setTitle:@"添加健身房" forState:UIControlStateNormal];
    
    return emptyView;
    
    
}

-(void)add:(UIButton*)btn
{
    
    BrandListController *svc = [[BrandListController alloc]init];
    
    svc.isWorkAdd = YES;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym;
    
    if (self.searchTF.text.length>=3) {
        
        gym = self.searchInfo.gymArr[indexPath.row];
        
    }else
    {
        
        gym = self.searchInfo.hotGymArr[indexPath.row];
        
    }
    
    cell.title = gym.name;
    
    cell.subtitle = [NSString stringWithFormat:@"%@%@",gym.city.length?[gym.city stringByAppendingString:@"    "]:@"",gym.brandName.length?gym.brandName:@""];
    
    cell.imgUrl = gym.imgUrl;
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.searchTF.text.length<3) {
        
        return Height320(44);
        
    }else if(self.searchTF.text.length>=3 &&self.searchInfo.gymArr.count)
    {
        
        return Height320(44);
        
    }else
    {
        
        return 0;
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(66);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(44))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(15), Height320(20), Width320(100), Height320(18))];
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.font = AllFont(14);
    
    [header addSubview:label];
    
    if (self.searchTF.text.length<3)
    {
        
        label.text = @"热门健身房";
        
        return header;
        
    }else if (self.searchInfo.gymArr.count) {
        
        label.text = @"所有健身房";
        
        return header;
        
    }else
    {
        
        return nil;
        
    }
    
}


-(void)textFieldDidChanged:(UITextField *)textField{
    
    [self createData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.searchTF.text.length>=3?self.searchInfo.gymArr[indexPath.row]:self.searchInfo.hotGymArr[indexPath.row];
    
    if (self.addSuccess) {
        
        self.addSuccess(gym);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}


@end
