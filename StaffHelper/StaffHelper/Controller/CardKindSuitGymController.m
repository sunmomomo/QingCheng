


//
//  CardKindSuitGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindSuitGymController.h"

#import "GymListInfo.h"

#import "GymSuitCell.h"

#import "CardKindInfo.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CardKindSuitGymController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)GymListInfo *info;

@property(nonatomic,strong)NSMutableArray *allGyms;

@end

@implementation CardKindSuitGymController

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
    
    self.info = [GymListInfo shareInfo];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self getShowData];
        
        self.allGyms = [[[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.allGyms] mutableCopy];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)getShowData
{
    
    self.allGyms = [self.info.gyms mutableCopy];
    
    for (Gym *tempGym in self.gyms) {
        
        Gym *sameGym = [tempGym containInArray:self.info.gyms];
        
        if (!sameGym) {
            
            [self.allGyms addObject:tempGym];
            
        }
        
    }
    
}

-(void)createUI
{
    
    self.title = @"选择适用场馆";
    
    self.rightTitle = @"确定";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[GymSuitCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(36))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(14), Height320(14))];
    
    hintImg.image = [UIImage imageNamed:@"hint_circle"];
    
    [tableHeader addSubview:hintImg];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(hintImg.right+Width320(8), 0, MSW-Width320(24)-hintImg.right, Height320(36))];
    
    hintLabel.text = @"您只能对具有管理员权限的场馆进行操作";
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.font = AllFont(12);
    
    [tableHeader addSubview:hintLabel];
    
    self.tableView.tableFooterView = [UIView new];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.allGyms.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymSuitCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.allGyms[indexPath.row];
    
    cell.title = [NSString stringWithFormat:@"%@ | %@",gym.name,gym.brand.name];
    
    cell.subtitle = gym.city.length?[NSString stringWithFormat:@"%@  %@",gym.city,gym.contact]:gym.contact;
    
    cell.imgUrl = gym.imgUrl;
    
    if ([gym containInArray:self.gyms]) {
        
        cell.isChoosed = YES;
        
    }else
    {
        
        cell.isChoosed = NO;
        
    }
    
    cell.havePower = self.isAdd?gym.permissions.cardKindPermission.addState:gym.permissions.cardKindPermission.editState;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.allGyms[indexPath.row];
    
    if (self.isAdd?gym.permissions.cardKindPermission.addState:gym.permissions.cardKindPermission.editState) {
        
        Gym *temp = [gym containInArray:self.gyms];
        
        if (temp) {
            
            [self.gyms removeObject:temp];
            
        }else
        {
            
            [self.gyms addObject:gym];
            
        }
        
        [self.tableView reloadData];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"没有该场馆的编辑权限" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
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

-(void)naviRightClick
{
    
    if (!self.gyms.count) {
        
        [[[UIAlertView alloc]initWithTitle:@"至少选择一个适用场馆" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
     
        return;
        
    }
    
    if (self.chooseFinish) {
        
        self.chooseFinish(self.gyms);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
