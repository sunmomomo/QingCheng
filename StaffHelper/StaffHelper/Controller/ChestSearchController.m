//
//  ChestSearchController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestSearchController.h"

#import "ChestSearchCell.h"

#import "ChestAreaSearchView.h"

#import "ChestListInfo.h"

#import "ChestSearchCell.h"

static NSString *identifier = @"Cell";

@interface ChestSearchController ()<DZNEmptyDataSetSource,ChestAreaSearchViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong)ChestAreaSearchView *areaView;

@property(nonatomic,strong)ChestListInfo *info;

@property(nonatomic,strong)UICollectionView *searchView;

@property(nonatomic,strong)NSMutableArray *searchAreas;

@end

@implementation ChestSearchController

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
    
    self.info = [[ChestListInfo alloc]init];
    
    [self.info requestDataResult:^(BOOL success, NSString *error) {
        
        self.areaView.allArray = self.info.areas;
        
        self.areaView.chest = self.chest;
        
    }];
    
}

-(void)createUI
{
    
    self.haveSearchBar = YES;
    
    self.naviSearchBar.placeholder = @"更衣柜号";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.areaView = [ChestAreaSearchView defaultAreaView];
    
    self.areaView.delegate = self;
    
    [self.view addSubview:self.areaView];
    
    self.searchView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.searchView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.searchView.delegate = self;
    
    self.searchView.dataSource = self;
    
    self.searchView.emptyDataSetSource = self;
    
    if ([[UIDevice currentDevice]systemVersion].floatValue>=10.0) {
        
        self.searchView.prefetchingEnabled = NO;
        
    }
    
    [self.searchView registerClass:[ChestSearchCell class] forCellWithReuseIdentifier:identifier];
    
    [self.searchView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.view addSubview:self.searchView];
    
    self.searchView.hidden = YES;
    
}

-(void)areaViewChooseChest:(Chest *)chest
{
    
    if (self.chooseChestFinish) {
        
        self.chooseChestFinish(chest);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.searchAreas.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    ChestArea *area = self.searchAreas[section];
    
    return area.chests.count%2?area.chests.count+1:area.chests.count;
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    [header removeAllView];
    
    ChestArea *area = self.searchAreas[indexPath.section];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, MSW-Width320(24), Height320(36))];
    
    label.text = area.areaName;
    
    label.textColor = UIColorFromRGB(0x666666);
    
    label.font = AllFont(13);
    
    [header addSubview:label];
    
    return header;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height320(36));
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(MSW/2, Height320(90));
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0,0, 0, 0);
    
}

-(void)naviSearchBarDidChanged:(UITextField *)searchBar
{
    
    self.searchAreas = [NSMutableArray array];
    
    if (searchBar.text.length) {
        
        self.searchView.hidden = NO;
        
        [self.view bringSubviewToFront:self.searchView];
        
        for (ChestArea *area in self.info.areas) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (Chest *chest in area.chests) {
                
                if ([[chest.name lowercaseString] rangeOfString:[searchBar.text lowercaseString]].length) {
                    
                    [array addObject:chest];
                    
                }
                
            }
            
            if (array.count) {
                
                ChestArea *nowArea = [[ChestArea alloc]init];
                
                nowArea.areaName = area.areaName;
                
                nowArea.areaId = area.areaId;
                
                nowArea.chests = array;
                
                [self.searchAreas addObject:nowArea];
                
            }
            
        }
        
        [self. searchView reloadData];
        
    }else{
        
        self.searchView.hidden = YES;
        
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    ChestArea *area = self.searchAreas[indexPath.section];
    
    cell.haveRightLine = indexPath.row%2==0;
    
    cell.haveBottomLine = area.chests.count%2?indexPath.row >= area.chests.count-1:indexPath.row>=area.chests.count-2;
    
    if (indexPath.row<area.chests.count) {
        
        Chest *chest = area.chests[indexPath.row];
        
        cell.title = chest.name;
        
        cell.canSelected = !chest.isUsed;
        
        cell.choosed = chest.chestId == self.chest.chestId && chest.area.areaId == self.chest.area.areaId;
        
    }else{
        
        cell.title = @"";
        
        cell.canSelected = NO;
        
        cell.choosed = NO;
        
    }
    
    return cell;
    
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(73), Height320(112), Width320(174), Height320(146))];
    
    emptyImg.image = [UIImage imageNamed:@"empty_search"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(15), MSW, Height320(15))];
    
    emptyLabel.text = @"未找到相关结果";
    
    emptyLabel.textColor = UIColorFromRGB(0x666666);
    
    emptyLabel.font = AllFont(13);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestArea *area = self.searchAreas[indexPath.section];
    
    if (indexPath.row<area.chests.count) {
        
        Chest *chest = area.chests[indexPath.row];
        
        if (self.chooseChestFinish) {
            
            self.chooseChestFinish(chest);
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

@end
