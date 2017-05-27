//
//  BrandListController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandListController.h"

#import "BrandListInfo.h"

#import "BrandCell.h"

#import "BrandCreateController.h"

#import "GymCreateController.h"

#import "GuideGymSetController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface BrandListController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *brands;

@end

@implementation BrandListController

-(void)viewDidLoad{
    
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

-(void)reloadData
{
    
    BrandListInfo *info = [[BrandListInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView.mj_header endRefreshing];
        
        self.brands = info.brands;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)createUI
{
    
    self.title = @"选择健身房品牌";
    
    self.leftType = self.isGuide?MONaviLeftTypeNO:MONaviLeftTypeBack;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[BrandCell class] forCellReuseIdentifier:identifier];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(54))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    addButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    addButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(117), Height320(18), Width320(18), Height320(18))];
    
    addImg.image = [UIImage imageNamed:@"table_footer_add"];
    
    [addButton addSubview:addImg];
    
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImg.right+Width320(6), 0, Width320(150), Height320(54))];
    
    addLabel.text = @"添加新品牌";
    
    addLabel.textColor = kMainColor;
    
    addLabel.font = AllFont(12);
    
    [addButton addSubview:addLabel];
    
    self.tableView.tableFooterView = addButton;
    
    [addButton addTarget:self action:@selector(addBrand) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.brands.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Brand *brand = self.brands[indexPath.row];
    
    cell.iconURL = brand.imgURL;
    
    cell.title = brand.name;
    
    cell.subtitle = [NSString stringWithFormat:@"品牌ID：%@  创建人：%@",brand.cname.length?brand.cname:@"",brand.owner.name.length?brand.owner.name:@""];
    
    cell.havePower = brand.havePower;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(144);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Brand *brand = self.brands[indexPath.row];
    
    if (brand.havePower) {
        
        if (self.isWorkAdd) {
            
            GymCreateController *svc = [[GymCreateController alloc]init];
            
            svc.brand = brand;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            GuideGymSetController *svc = [[GuideGymSetController alloc]init];
            
            MOAppDelegate.guide = [[Guide alloc]init];
            
            MOAppDelegate.guide.brand = brand;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"只能由品牌创建人%@添加场馆",brand.owner.name.length?brand.owner.name:@""] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
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

-(void)addBrand
{
    
    BrandCreateController *svc = [[BrandCreateController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
