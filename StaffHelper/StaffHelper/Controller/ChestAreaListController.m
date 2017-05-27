//
//  ChestAreaListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestAreaListController.h"

#import "ChestAreaListCell.h"

#import "ChestAreaListInfo.h"

#import "ChestAreaEditController.h"

static NSString *identifier = @"Cell";

@interface ChestAreaListController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)ChestAreaListInfo *info;

@end

@implementation ChestAreaListController

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
    
    self.info = [[ChestAreaListInfo alloc]init];
    
    [self.info requestDataResult:^(BOOL success, NSString *error) {
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    [self.info requestDataResult:^(BOOL success, NSString *error) {
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"更衣柜区域";
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[ChestAreaListCell class] forCellWithReuseIdentifier:identifier];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.info.areas.count+1;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestAreaListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.isAdd = indexPath.row == 0;
    
    if (indexPath.row > 0) {
        
        ChestArea *area = self.info.areas[indexPath.row-1];
        
        cell.name = area.areaName;
        
    }
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(Width320(136), Height320(60));
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Width320(16);
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Width320(16);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Width320(16), Width320(16), Width320(16), Width320(16));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestAreaEditController *svc = [[ChestAreaEditController alloc]init];
    
    if (indexPath.row == 0) {
        
        if (![PermissionInfo sharedInfo].gym.permissions.lockerPermission.addState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
        svc.isAdd = YES;
        
    }else{
        
        if (![PermissionInfo sharedInfo].gym.permissions.lockerPermission.editState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
        ChestArea *area = self.info.areas[indexPath.row-1];
        
        svc.area = area;
        
        svc.isAdd = NO;
        
    }
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
