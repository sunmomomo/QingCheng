//
//  SellerChooseController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerChooseController.h"

#import "SellersInfo.h"

#import "SellerCell.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface SellerChooseController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)SellersInfo *info;

@end

@implementation SellerChooseController

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
    
    self.info = [[SellersInfo alloc]init];
    
    [self.info requestWithGym:self.gym Result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        Seller *seller = [[Seller alloc]init];
        
        seller.name = @"无销售";
        
        [self.info.sellers insertObject:seller atIndex:0];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择销售";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[SellerCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(80);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.sellers.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SellerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Seller *seller = self.info.sellers[indexPath.row];
    
    cell.name = seller.name;
    
    cell.imgUrl = seller.iconURL;

    cell.select = seller.sellerId == self.seller.sellerId;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Seller *seller = self.info.sellers[indexPath.row];
    
    if (self.chooseFinish) {
        self.chooseFinish(seller);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
