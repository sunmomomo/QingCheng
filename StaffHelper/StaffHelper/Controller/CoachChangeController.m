//
//  CoachChangeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoachChangeController.h"

#import "CoachListInfo.h"

#import "SellerChangeCell.h"

#import "CoachDistributeInfo.h"

static NSString *identifier = @"Cell";

@interface CoachChangeController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *coaches;

@property(nonatomic,strong)NSMutableArray *choosedCoaches;

@end

@implementation CoachChangeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

-(void)createData
{
    
    self.choosedCoaches = [NSMutableArray array];
    
    if (self.coach.type == CoachDistributeTypeNormal) {
        
        [self.choosedCoaches addObject:self.coach];
        
    }
    
    CoachListInfo *info = [[CoachListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CoachListInfo*)weakInfo = info;
    
    info.requestFinish = ^(BOOL success) {
        
        if (success) {
            
            weakS.coaches = [weakInfo.coaches copy];
            
        }
        
        [self.collectionView reloadData];
        
    };
    
    [info requsetWithGym:self.gym andSearchStr:nil];
    
}

-(void)reloadData
{
    
    CoachListInfo *info = [[CoachListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CoachListInfo*)weakInfo = info;
    
    info.requestFinish = ^(BOOL success) {
        
        if (success) {
            
            weakS.coaches = [weakInfo.coaches copy];
            
        }
        
        [self.collectionView reloadData];
        
    };
    
    [info requsetWithGym:self.gym andSearchStr:nil];
    
}

-(void)createUI
{
    
    self.title = self.coach.type == CoachDistributeTypeNormal?@"变更教练":@"分配教练";
    
    self.rightTitle = @"完成";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(20))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:header];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(150), Height320(20))];
    
    headerLabel.text = @"请选择教练";
    
    headerLabel.textColor = UIColorFromRGB(0x999999);
    
    headerLabel.font = AllFont(11);
    
    [header addSubview:headerLabel];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, header.bottom, MSW, MSH-header.bottom) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.collectionView registerClass:[SellerChangeCell class] forCellWithReuseIdentifier:identifier];
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [mjHeader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [mjHeader setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [mjHeader setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    mjHeader.stateLabel.textColor = [UIColor blackColor];
    
    self.collectionView.mj_header = mjHeader;
    
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.coaches.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(MSW/4, Height320(96));
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SellerChangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    Coach *coach = self.coaches[indexPath.row];
    
    cell.iconURL = coach.iconUrl;
    
    cell.name = coach.name;
    
    BOOL contains = NO;
    
    for (Coach *tempCoach in self.choosedCoaches) {
        
        if (tempCoach.coachId == coach.coachId) {
            
            contains = YES;
            
            break;
            
        }
        
    }
    
    cell.choosed = contains;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Coach *coach = self.coaches[indexPath.row];
    
    BOOL contains = NO;
    
    for (Coach *tempCoach in self.choosedCoaches) {
        
        if (tempCoach.coachId == coach.coachId) {
            
            contains = YES;
            
            [self.choosedCoaches removeObject:tempCoach];
            
            break;
            
        }
        
    }
    
    if (!contains) {
        
        [self.choosedCoaches addObject:coach];
        
    }
    
    [self.collectionView reloadData];
    
}

-(void)naviRightClick
{
    
    if (self.choosedCoaches.count) {
        
        NSString *coachesStr = @"";
        
        for (NSInteger i =0;i<self.choosedCoaches.count;i++) {
            
            Coach *tempCoach = self.choosedCoaches[i];
            
            coachesStr = [coachesStr stringByAppendingString:tempCoach.name];
            
            if (i<self.choosedCoaches.count-1) {
                
                coachesStr = [coachesStr stringByAppendingString:@"、"];
                
            }
            
        }
        
        BOOL contains = NO;
        
        if (self.coach.type == CoachDistributeTypeNone) {
            
            contains = YES;
            
        }else{
            
            for (Coach *tempCoach in self.choosedCoaches) {
                
                if (tempCoach.coachId == self.coach.coachId) {
                    
                    contains = YES;
                    
                    break;
                    
                }
                
            }
            
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定将所选会员%@到%@名下？",contains?@"分配":@"转移",coachesStr] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请选择教练" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        hud.mode = MBProgressHUDModeText;
        
        [self.view addSubview:hud];
        
        CoachDistributeInfo *info = [[CoachDistributeInfo alloc]init];
        
        [info changeUsers:self.users withOriginalCoach:self.coach withCoaches:self.choosedCoaches withGym:self.gym result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                hud.label.text = self.coach.type == CoachDistributeTypeNormal?@"变更成功":@"分配成功";
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popToViewControllerName:@"CoachDistributeListController" isReloadData:YES];
                    
                });
                
            }else{
                
                self.rightButtonEnable = YES;
                
                hud.label.text = error;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

@end

