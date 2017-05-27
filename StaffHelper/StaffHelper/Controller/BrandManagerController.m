//
//  BrandManagerController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandManagerController.h"

#import "BrandCell.h"

#import "BrandListInfo.h"

#import "BrandDetailController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface BrandManagerController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)BrandListInfo *info;

@end

@implementation BrandManagerController

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    self.info = [[BrandListInfo alloc]init];
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"品牌管理";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[BrandCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.brands.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(144);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Brand *brand = self.info.brands[indexPath.row];
    
    cell.iconURL = brand.imgURL;
    
    cell.title = brand.name;
    
    cell.subtitle = [NSString stringWithFormat:@"品牌ID：%@  创建人：%@",brand.cname.length?brand.cname:@"",brand.owner.name.length?brand.owner.name:@""];
    
    cell.havePower = brand.havePower;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Brand *brand = self.info.brands[indexPath.row];
    
    if (brand.havePower) {
        
        BrandDetailController *svc = [[BrandDetailController alloc]init];
        
        svc.brand = [brand copy];
        svc.brandCount = self.info.brands.count;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"仅品牌创建人%@可编辑",brand.owner.name.length?brand.owner.name:@""] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
