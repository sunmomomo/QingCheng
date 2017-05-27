//
//  GymListController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GymListController.h"

#import "GymBrandInfo.h"

#import "BrandListController.h"

#import "MOTableView.h"

#import "GymBrandCell.h"

#import "ManageController.h"

static NSString *identifier = @"Cell";

@interface GymListController ()<MOTableViewDatasource,UITableViewDelegate,GymBrandCellDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *brands;

@end

@implementation GymListController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)createData
{
 
    [self reloadData];
    
}

-(void)reloadData
{
    
    GymBrandInfo *info = [[GymBrandInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.brands = info.brands;
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.navi.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.navigationTitleColor = UIColorFromRGB(0x333333);
    
    self.leftType = MONaviLeftTypeBlackClose;
    
    self.title = @"选择健身房";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[GymBrandCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(60))];
    
    footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = footer;
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width(12), Height(8), MSW-Width(24), Height(44))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    addButton.layer.cornerRadius = Width(2);
    
    addButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    addButton.layer.borderWidth = OnePX;
    
    [addButton setTitle:@"+  添加健身房" forState:UIControlStateNormal];
    
    [addButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(15);
    
    [addButton addTarget:self action:@selector(addGym) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:addButton];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Brand *brand = self.brands[indexPath.row];
    
    return Height(149)+Height(80)*brand.gyms.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.brands.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Brand *brand = self.brands[indexPath.row];
    
    cell.brand = brand;
    
    cell.gyms = brand.gyms;
    
    cell.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)addGym
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[ManageController sharedSliderController]addGym];
        
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)gymBrandCellDidSelectGym:(Gym *)gym
{
    
    AppGym = gym;
    
    [[NSUserDefaults standardUserDefaults]setInteger:AppGym.gymId forKey:@"lastGymId"];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[ManageController sharedSliderController]reloadData];
        
    }];
    
}

-(void)manageBrand:(Brand *)brand
{
    
    if (brand.havePower) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [[ManageController sharedSliderController]pushWithBrand:brand];
            
        }];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"无该品牌管理权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

@end
