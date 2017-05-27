//
//  BrandListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandListController.h"

#import "BrandListInfo.h"

#import "BrandCell.h"

#import "BrandCreateController.h"

#import "GuideSetGymController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface BrandListController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)BrandListInfo *info;

@end

@implementation BrandListController

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
    
    self.title = @"选择健身房品牌";
    
    self.leftType = MONaviLeftTypeBack;
    
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
    
    addImg.image = [UIImage imageNamed:@"card_recharge"];
    
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
    
    return self.info.brands.count;
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(144);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Brand *brand = self.info.brands[indexPath.row];
    
    if (brand.havePower) {
        
        GuideSetGymController *svc = [[GuideSetGymController alloc]init];
        
        Course *course = [[Course alloc]initNewCourse];
        
        course.gym.brand = brand;
        
        ((AppDelegate *)[UIApplication sharedApplication].delegate).course = course;
        
        [self.navigationController pushViewController:svc animated:YES];
        
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
    
    __weak typeof(self)weakS = self;
    
    svc.addFinish = ^{
       
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
