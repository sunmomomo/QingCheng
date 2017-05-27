//
//  StudentCoachController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/5/3.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "StudentCoachController.h"

#import "CoachListInfo.h"

#import "SellerChangeCell.h"

#import "CoachDistributeInfo.h"
#import "YFAppConfig.h"

static NSString *identifier = @"Cell";

@interface StudentCoachController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *coaches;

@property(nonatomic,strong)NSMutableArray *choosedCoaches;

@end

@implementation StudentCoachController

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
    
    self.choosedCoaches = [NSMutableArray array];
    
    if (self.student.coaches.count) {
        
        self.choosedCoaches = [self.student.coaches mutableCopy];
        
    }
    
    CoachListInfo *info = [[CoachListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(CoachListInfo*)weakInfo = info;
    
    info.requestFinish = ^(BOOL success) {
        
        if (success) {
            
            weakS.coaches = [weakInfo.coaches copy];
            
        }
        
        [weakS.collectionView reloadData];
        
    };
    
    [info requsetWithGym:self.gym andSearchStr:nil];
    
}

-(void)createUI
{
    
    self.title = @"分配教练";
    
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
    
    if (self.isEdit) {
        
        if (self.choosedCoaches.count) {
            
            [self confirmEdit];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"操作成功后，该会员不在任何教练名下，确认继续？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
            
        }
        
    }else{
        
        if (self.chooseFinish) {
            
            self.chooseFinish(self.choosedCoaches);
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [self confirmEdit];
        
    }
    
}

-(void)confirmEdit
{
    
    self.rightButtonEnable = NO;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:hud];
    
    CoachDistributeInfo *info = [[CoachDistributeInfo alloc]init];
    
    weakTypesYF
    [info changeUsers:@[self.student] withOriginalCoach:nil withCoaches:self.choosedCoaches withGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.rightButtonEnable = YES;
        
        if (success) {
            if (weakS.editFinish) {
                weakS.editFinish();
            }
            // 教练 改变
            [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddNewCoachIdtifierYF object:nil];
            hud.label.text = @"修改成功";
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popToViewControllerName:@"StudentDetailController" isReloadData:YES];
                
            });
            
        }else{
            
            hud.label.text = error;
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

@end
