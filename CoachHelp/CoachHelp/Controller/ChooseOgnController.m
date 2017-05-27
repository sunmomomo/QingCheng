//
//  ChooseOgnController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ChooseOgnController.h"

#import "SearchCell.h"

#include "SearchInfo.h"

#import "DistrictInfo.h"

#import "AddOrganizationController.h"

#import "QualityMeetingEditController.h"

#import "QualityTrainEditController.h"

#import "QualityMatchEditController.h"

static NSString *identifier = @"Cell";

@interface ChooseOgnController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong)UITextField *searchTF;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)SearchInfo *searchInfo;

@end

@implementation ChooseOgnController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.quality = [[Quality alloc]init];
        
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
    
    SearchInfo *info = [[SearchInfo alloc]initOgnInfoWithStr:self.searchTF.text];
    
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
    
    topLabel.text = @"请先选择认证的主办机构";
    
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
    
    self.searchTF.placeholder = @"搜索主办机构（至少3个字）";
    
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
    
    [addBtn setTitle:@"添加组织机构" forState:UIControlStateNormal];
    
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
        
        if (self.searchInfo.organizationsArr.count) {
            self.tableView.tableFooterView.hidden = NO;
        }
        
        return self.searchInfo.organizationsArr.count;
        
    }else
    {
        
        return self.searchInfo.hotOrganizationsArr.count;
        
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
    
    label.text = @"没有匹配的机构\n您可以添加该机构";
    
    [addBtn setTitle:@"添加组织机构" forState:UIControlStateNormal];
    
    return emptyView;
    
    
}

-(void)add:(UIButton*)btn
{
    
    AddOrganizationController *svc = [[AddOrganizationController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.title = @"添加组织机构";
    
    svc.addSuccess = ^(Organization *ogn){
        
        if (weakS.addSuccess) {
            
            weakS.quality.organization = ogn;
            
            weakS.addSuccess(weakS.quality);
            
        }
        
    };
    
    [self presentViewController:svc animated:YES completion:nil];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Organization *ogn;
    
    if (self.searchTF.text.length>=3) {
        
        ogn = self.searchInfo.organizationsArr[indexPath.row];
        
    }else
    {
        
        ogn = self.searchInfo.hotOrganizationsArr[indexPath.row];
        
    }
    
    cell.title = ogn.name;
    
    cell.subtitle = ogn.contact;
    
    cell.imgUrl = ogn.imgUrl;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(66);
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.searchTF.text.length<3) {
        
        return Height320(44);
        
    }else if(self.searchTF.text.length>=3&&self.searchInfo.organizationsArr.count)
    {
        
        return Height320(44);
        
    }else
    {
        
        return 0;
        
    }
    
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
        
        label.text = @"热门机构";
        
        return header;
        
    }else if (self.searchInfo.organizationsArr.count) {
        
        label.text = @"所有机构";
        
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
    
    Organization *ogn = self.searchTF.text.length>=3?self.searchInfo.organizationsArr[indexPath.row]:self.searchInfo.hotOrganizationsArr[indexPath.row];
    
    self.quality.organization = ogn;
    
    if (self.addSuccess) {
        
        self.addSuccess(self.quality);
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
