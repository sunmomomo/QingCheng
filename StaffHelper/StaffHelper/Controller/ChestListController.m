//
//  ChestListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestListController.h"

#import "ChestAreaView.h"

#import "ChestListInfo.h"

#import "ChestCell.h"

#import "ChestBorrowDetailView.h"

#import "ChestBorrowController.h"

#import "ChestReturnController.h"

#import "ChestContinueBorrowController.h"

#import "ChestAreaListController.h"

#import "ChestEditController.h"

#import "ChestBorrowInfo.h"

static NSString *identifier = @"Cell";

@interface ChestListController ()<UITextFieldDelegate,ChestAreaViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,ChestBorrowDetailViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UIView *naviSearchView;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)ChestAreaView *areaView;

@property(nonatomic,strong)ChestListInfo *info;

@property(nonatomic,strong)UICollectionView *searchView;

@property(nonatomic,strong)NSMutableArray *searchAreas;

@property(nonatomic,strong)Chest *currentChest;

@end

@implementation ChestListController

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
        
    }];
    
}

-(void)reloadData
{
    
    [self.info requestDataResult:^(BOOL success, NSString *error) {
        
        self.areaView.allArray = self.info.areas;
        
    }];
    
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeAdd;
    
    self.rightSubType = MONaviRightSubTypeSearch;
    
    self.title = @"更衣柜";
    
    self.naviSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
    
    self.naviSearchView.backgroundColor = UIColorFromRGB(0x4e4e4e);
    
    [self.view addSubview:self.naviSearchView];
    
    self.naviSearchView.hidden = YES;
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(7.5), 23.1, Width320(257), 35.7)];
    
    [self.naviSearchView addSubview:self.searchBar];
    
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.masksToBounds = YES;
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
    
    self.searchBar.font = AllFont(14);
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.searchBar.height)];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(16.8, 10.3, 15.5, 15.5)];
    
    searchImg.image = [UIImage imageNamed:@"search"];
    
    [leftView addSubview:searchImg];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder = @"更衣柜号/会员姓名/手机";
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    clearButton.frame = CGRectMake(self.searchBar.right-Width320(24), 0, Width320(24), self.searchBar.height);
    
    self.searchBar.rightView = clearButton;
    
    UIImageView *clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(3), 0, Width320(12.4), Height320(12.4))];
    
    clearImg.image = [UIImage imageNamed:@"clear"];
    
    clearImg.center = CGPointMake(clearImg.center.x, clearButton.height/2);
    
    [clearButton addSubview:clearImg];
    
    [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchBar addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancel.frame = CGRectMake(self.searchBar.right, 20, MSW-self.searchBar.right, 44);
    
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancel setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    cancel.backgroundColor = [UIColor clearColor];
    
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.naviSearchView addSubview:cancel];
    
    self.areaView = [ChestAreaView defaultAreaView];
    
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
    
    [self.searchView registerClass:[ChestCell class] forCellWithReuseIdentifier:identifier];
    
    [self.searchView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.view addSubview:self.searchView];
    
    self.searchView.hidden = YES;
    
}


-(void)clear:(UIButton*)btn
{
    
    self.searchBar.text = @"";
    
    [self textFieldDidChanged:self.searchBar];
    
    [self.searchBar resignFirstResponder];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    self.searchAreas = [NSMutableArray array];
    
    if (self.searchBar.text.length) {
        
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
        
        self.searchView.hidden = NO;
        
        [self.view bringSubviewToFront:self.searchView];
        
        for (ChestArea *area in self.info.areas) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (Chest *chest in area.chests) {
                
                if ([[chest.name lowercaseString] rangeOfString:[self.searchBar.text lowercaseString]].length) {
                    
                    [array addObject:chest];
                    
                }else if (chest.borrowUser){
                    
                    if ([[chest.borrowUser.name lowercaseString]rangeOfString:[self.searchBar.text lowercaseString]].length) {
                        
                        [array addObject:chest];
                        
                    }else if([chest.borrowUser.phone rangeOfString:self.searchBar.text].length){
                        
                        [array addObject:chest];
                        
                    }
                    
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
        
        self.searchBar.rightViewMode = UITextFieldViewModeNever;
        
        self.searchView.hidden = YES;
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)naviRightSubClick
{
    
    self.naviSearchView.hidden = NO;
    
    [self.view bringSubviewToFront:self.naviSearchView];
    
}

-(void)cancel:(UIButton*)btn
{
    
    [self.searchBar resignFirstResponder];
    
    self.naviSearchView.hidden = YES;
    
    self.searchBar.text = @"";
    
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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    ChestArea *area = self.searchAreas[indexPath.section];
    
    cell.haveRightLine = indexPath.row%2==0;
    
    cell.haveBottomLine = area.chests.count%2?indexPath.row >= area.chests.count-1:indexPath.row>=area.chests.count-2;
    
    if (indexPath.row<area.chests.count) {
        
        Chest *chest = area.chests[indexPath.row];
        
        cell.title = chest.name;
        
        cell.canSelected = !chest.isUsed;
        
        cell.name = chest.borrowUser.name;
        
        cell.phone = chest.borrowUser.phone;
        
        if (chest.longTermUse) {
            
            cell.time = [NSString stringWithFormat:@"%@ 至 %@",chest.start,chest.end];
            
        }
        
        cell.longTermUse = chest.longTermUse;
        
    }else{
        
        cell.isEmpty = YES;
        
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
        
        [self areaViewChooseChest:chest];
        
    }
    
}

-(void)areaViewChooseChest:(Chest *)chest
{
    
    self.currentChest = chest;
    
    if (chest.isUsed) {
        
        ChestBorrowDetailView *view = [ChestBorrowDetailView defaultView];
        
        [self.view addSubview:view];
        
        view.chest = chest;
        
        view.delegate = self;
        
        [view show];
        
    }else{
        
        ChestBorrowController *svc = [[ChestBorrowController alloc]init];
        
        svc.chest = chest;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}


-(void)returnChest
{
    
    if (!self.currentChest.longTermUse) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定归还更衣柜%@？",self.currentChest.name] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else{
        
        ChestReturnController *svc = [[ChestReturnController alloc]init];
        
        svc.chest = self.currentChest;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        ChestBorrowInfo *info = [[ChestBorrowInfo alloc]init];
        
        [info returnTempChest:self.currentChest result:^(BOOL success, NSString *error) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"归还成功";
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                [self reloadData];
                
            }else{
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)continueBorrowChest
{
    
    ChestContinueBorrowController *svc = [[ChestContinueBorrowController alloc]init];
    
    svc.chest = self.currentChest;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)manageArea
{
    
    [self.areaView close];
    
    ChestAreaListController *svc = [[ChestAreaListController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)naviRightClick
{
    
    if ([PermissionInfo sharedInfo].gym.permissions.lockerPermission.addState) {
        
        ChestEditController *svc = [[ChestEditController alloc]init];
        
        svc.isAdd = YES;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}


@end
