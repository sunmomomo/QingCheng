//
//  ChangeBrandController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChangeBrandController.h"

#import "BrandListInfo.h"

#import "BrandCell.h"

#import "GymListController.h"

#import "MOTableView.h"

#import "BrandCreateController.h"

static NSString *identifier = @"Cell";

@interface ChangeBrandController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)BrandListInfo *info;

@end

@implementation ChangeBrandController

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
    
    BrandListInfo *info = [[BrandListInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        self.info = info;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择品牌";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[BrandCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(54))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    addButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    addButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(117), Height320(18), Width320(18), Height320(18))];
    
    addImg.image = [UIImage imageNamed:@"card_recharge"];
    
    [addButton addSubview:addImg];
    
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImg.right+Width320(6), 0, Width320(150), Height320(54))];
    
    addLabel.text = @"创建品牌";
    
    addLabel.textColor = kMainColor;
    
    addLabel.font = AllFont(12);
    
    [addButton addSubview:addLabel];
    
    self.tableView.tableFooterView = addButton;
    
    [addButton addTarget:self action:@selector(addBrand) forControlEvents:UIControlEventTouchUpInside];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.brands.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Brand *brand = self.info.brands[indexPath.row];
    
    cell.iconURL = brand.imgURL;
    
    cell.title = brand.name;
    
    cell.subtitle = [NSString stringWithFormat:@"品牌ID：%@  创建人：%@",brand.cname.length?brand.cname:@"",brand.owner.name.length?brand.owner.name:@""];
    
    cell.havePower = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(144);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Brand *brand = self.info.brands[indexPath.row];
    
    if (0) {
        
//        [[[UIAlertView alloc]initWithTitle:@"该品牌下无可用场馆" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        ((AppDelegate*)[UIApplication sharedApplication].delegate).brand = brand;
        
        [GymListController sharedController].brand = brand;
        
        [[PermissionInfo sharedInfo]requestWithBrand:brand result:^(BOOL success, NSString *error) {
            
            if (self.setFinish) {
                self.setFinish();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
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
    
    __weak typeof(self)weakS = self;
    
    svc.addFinish = ^{
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}



@end
