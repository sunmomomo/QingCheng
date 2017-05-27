//
//  SellerChangeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerChangeController.h"

#import "SellersInfo.h"

#import "SellerChangeCell.h"

#import "SellerDistributeInfo.h"

static NSString *identifier = @"Cell";

@interface SellerChangeController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *sellers;

@property(nonatomic,strong)NSMutableArray *choosedSellers;

@end

@implementation SellerChangeController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.isCanOnlyChooseSeller = NO;
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

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

-(void)createData
{
    
    self.choosedSellers = [NSMutableArray array];
    
    if (self.seller.type == SellerTypeNormal) {
        
        [self.choosedSellers addObject:self.seller];
        
    }
    
    SellersInfo *info = [[SellersInfo alloc]init];
    
    if (self.isCanOnlyChooseSeller == NO)
    {
        [info requestWithGym:self.gym Result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.sellers = [info.sellers copy];
                
            }
            
            [self.collectionView reloadData];
            
        }];
    }else
    {
        [info requestOnlySellerWithGym:self.gym Result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.sellers = [info.sellers copy];
                
            }
            
            [self.collectionView reloadData];
            
        }];
    }
   
    
}

-(void)reloadData
{
    
    SellersInfo *info = [[SellersInfo alloc]init];
    
    [info requestWithGym:self.gym Result:^(BOOL success, NSString *error) {
        
        [self.collectionView.mj_header endRefreshing];
        
        if (success) {
            
            self.sellers = [info.sellers copy];
            
        }
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.seller.type == SellerTypeNormal?@"变更销售":@"分配销售";
    
    self.rightTitle = @"完成";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(20))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:header];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(150), Height320(20))];
    
    headerLabel.text = @"请选择销售";
    
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
    
    return self.sellers.count;
    
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
    
    Seller *seller = self.sellers[indexPath.row];
    
    cell.iconURL = seller.iconURL;
    
    cell.name = seller.name;
    
    BOOL contains = NO;
    
    for (Seller *tempSeller in self.choosedSellers) {
        
        if (tempSeller.sellerId == seller.sellerId) {
            
            contains = YES;
            
            break;
            
        }
        
    }
    
    cell.choosed = contains;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Seller *seller = self.sellers[indexPath.row];
    
    BOOL contains = NO;
    
    for (Seller *tempSeller in self.choosedSellers) {
        
        if (tempSeller.sellerId == seller.sellerId) {
            
            contains = YES;
            
            [self.choosedSellers removeObject:tempSeller];
            
            break;
            
        }
        
    }
    
    if (!contains) {
        
        [self.choosedSellers addObject:seller];
        
    }
    
    [self.collectionView reloadData];
    
}

-(void)naviRightClick
{
    
    if (self.choosedSellers.count) {
        
        NSString *sellerStr = @"";
        
        for (NSInteger i =0;i<self.choosedSellers.count;i++) {
            
            Seller *tempSeller = self.choosedSellers[i];
            
            sellerStr = [sellerStr stringByAppendingString:tempSeller.name];
            
            if (i<self.choosedSellers.count-1) {
                
                sellerStr = [sellerStr stringByAppendingString:@"、"];
                
            }
            
        }
        
        BOOL contains = NO;
        
        if (self.seller.type == SellerTypeNone) {
            
            contains = YES;
            
        }else{
            
            for (Seller *tempSeller in self.choosedSellers) {
                
                if (tempSeller.sellerId == self.seller.sellerId) {
                    
                    contains = YES;
                    
                    break;
                    
                }
                
            }
            
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定将所选会员%@到%@名下？",contains?@"分配":@"转移",sellerStr] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请选择销售" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        hud.mode = MBProgressHUDModeText;
        
        [self.view addSubview:hud];
        
        SellerDistributeInfo *info = [[SellerDistributeInfo alloc]init];
        
        [info changeUsers:self.users withOriginalSeller:self.seller withSellers:self.choosedSellers withGym:self.gym result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                hud.label.text = self.seller.type == SellerTypeNormal?@"变更成功":@"分配成功";
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popToViewControllerName:@"SellerListController" isReloadData:YES];
                    
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
