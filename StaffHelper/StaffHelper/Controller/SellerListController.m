//
//  SellerListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerListController.h"

#import "SellerListCell.h"

#import "SellerDistributeInfo.h"

#import "SellerBelongUserController.h"

#import "MOTableView.h"

#import "YFSellerFiterViewModel.h"

#import "YFModuleManager.h"

static NSString *identifier = @"Cell";

@interface SellerListController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *sellers;

@end

@implementation SellerListController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostAddNewSellerIdtifierYF object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostAddNewStudentToSellerIdtifierYF object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    SellerDistributeInfo *info = [[SellerDistributeInfo alloc]init];
    
    [info requestWithGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView.mj_header endRefreshing];
        
        self.sellers = info.sellers;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"销售列表";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SellerListCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(66)*2)];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sellers.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height320(64);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SellerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Seller *seller = self.sellers[indexPath.row];
    
    cell.sellerName = seller.type == SellerTypeNormal?seller.name:@"未分配";
    
    cell.count = [NSString stringWithFormat:@"%ld名会员",(long)seller.userCount];
    
    if (seller.type == SellerTypeNone)
    {
        cell.imgView.image = [UIImage imageNamed:@"noSeller"];
    }else
    {
        if (seller.avatar.length) {
            cell.imageUrl = seller.avatar;
        }else
        {
            if (seller.sexType == SexTypeMan) {
                cell.imgView.image = [UIImage imageNamed:@"img_default_student_male"];
            }else
            {
                cell.imgView.image = [UIImage imageNamed:@"img_default_student_female"];
            }
        }
    }
    
    
    seller = nil;
    
//    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//    
//    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Seller *seller = self.sellers[indexPath.row];
    
    [self.navigationController pushViewController:[YFModuleManager belongSellerViewControllerWith:seller gym:self.gym] animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
