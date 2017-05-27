//
//  FunctionEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "FunctionEditController.h"

#import "FunctionEditCell.h"

#import "AllFunctionInfo.h"

#import "FunctionNoneCell.h"

static NSString *identifier = @"Cell";

static NSString *noneIdentifier = @"None";

static NSString *headIdentifier = @"Head";

static NSString *footIdentifier = @"Foot";

static NSString *normalFootIdentifier = @"Normal";

@interface FuncEditHeaderView : UICollectionReusableView

{
    
    UILabel *_textLabel;
    
}

@property(nonatomic,copy)NSString *title;

@end

@implementation FuncEditHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), Height320(8), MSW-Width320(20), Height320(12))];
        
        _textLabel.textColor = UIColorFromRGB(0x666666);
        
        _textLabel.font = AllFont(10);
        
        [self addSubview:_textLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-OnePX, frame.size.width, OnePX)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:line];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
}

@end

@interface FuncEditFooterView :UICollectionReusableView

@end

@implementation FuncEditFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, OnePX)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:line];
        
    }
    return self;
}

@end

@interface FunctionEditController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,FunctionEditCellDelegate>

@property(nonatomic,strong)AllFunctionInfo *info;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation FunctionEditController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    self.info = [AllFunctionInfo defaultInfo];
    
    for (Function *func in self.myFunctions) {
        
        for (FunctionGroup *group in self.info.allFunctions) {
            
            for (Function *tempFunc in group.functions) {
                
                if ([tempFunc.key isEqualToString:func.key]) {
                    
                    tempFunc.choosed = YES;
                    
                }
                
            }
            
        }
        
    }
    
    [self.collectionView reloadData];
    
}

-(void)createUI
{
    
    self.title = @"全部功能";
    
    self.rightTitle = @"完成";
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[FunctionEditCell class] forCellWithReuseIdentifier:identifier];
    
    [self.collectionView registerClass:[FunctionNoneCell class] forCellWithReuseIdentifier:noneIdentifier];
    
    [self.collectionView registerClass:[FuncEditHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
    
    [self.collectionView registerClass:[FuncEditFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:normalFootIdentifier];
    
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.info.allFunctions.count+1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return self.myFunctions.count?(ceil((float)[self.myFunctions count]/4))*4:1;
        
    }else{
        
        FunctionGroup *group = self.info.allFunctions[section-1];
        
        return (ceil((float)[group.functions count]/4))*4;
        
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (!self.myFunctions.count) {
            
            FunctionNoneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:noneIdentifier forIndexPath:indexPath];
            
            cell.title = @"将常用功能添加到这里";
            
            return cell;
            
        }else{
            
            FunctionEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            if (indexPath.row<[self.myFunctions count]) {
                
                Function *func = self.myFunctions[indexPath.row];
                
                cell.title = func.title;
                
                cell.image = [UIImage imageNamed:func.imagePath];
                
                cell.type = FunctionEditCellTypeDelete;
                
                cell.delegate = self;
                
                cell.indexPath = indexPath;
                
            }else
            {
                
                cell.title = nil;
                
                cell.image = nil;
                
                cell.type = FunctionEditCellTypeNone;
                
            }
            
            NSInteger totalSection = (ceil((float)[self.myFunctions count]/4));
            
            NSInteger section = indexPath.row/4;
            
            cell.noBottomLine = section == totalSection-1;
            
            return cell;
            
        }
        
    }else{
        
        FunctionEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        FunctionGroup *group = self.info.allFunctions[indexPath.section-1];
        
        if (indexPath.row<[group.functions count]) {
            
            Function *func = group.functions[indexPath.row];
            
            cell.title = func.title;
            
            cell.image = [UIImage imageNamed:func.imagePath];
            
            cell.type = func.choosed?FunctionEditCellTypeChoosed:FunctionEditCellTypeAdd;
            
            cell.delegate = self;
            
            cell.indexPath = indexPath;
            
        }else
        {
            
            cell.title = nil;
            
            cell.image = nil;
            
            cell.type = FunctionEditCellTypeNone;
            
        }
        
        NSInteger totalSection = (ceil((float)[group.functions count]/4));
        
        NSInteger section = indexPath.row/4;
        
        cell.noBottomLine = section == totalSection-1;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && self.myFunctions.count == 0) {
        
        return CGSizeMake(MSW, MSW/4);
        
    }else{
        
        NSInteger width = MSW/4;
        
        return CGSizeMake(width, width);
        
    }
    
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    NSInteger width = MSW/4;
    
    float gap = (MSW-width*4)/2;
    
    return UIEdgeInsetsMake(0, gap, 0, gap);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height320(26));
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (section == self.info.allFunctions.count) {
        
        return CGSizeMake(MSW, Height320(18));
        
    }else
    {
        
        return CGSizeMake(MSW, OnePX);
        
    }
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section<self.info.allFunctions.count+1) {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            FuncEditHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
            
            if (indexPath.section == 0) {
                
                header.title = @"常用功能";
                
            }else{
                
                FunctionGroup *group = self.info.allFunctions[indexPath.section-1];
                
                header.title = group.title;
                
            }
            
            return header;
            
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]&& indexPath.section == self.info.allFunctions.count) {
            
            FuncEditFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footIdentifier forIndexPath:indexPath];
            
            return footer;
            
        }else
        {
            
            UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:normalFootIdentifier forIndexPath:indexPath];
            
            footer.backgroundColor = UIColorFromRGB(0xdddddd);
            
            return footer;
            
        }
        
    }else
    {
        
        return nil;
        
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}

-(void)deleteFunctionWithIndexPath:(NSIndexPath *)indexPath
{
    
    Function *func = self.myFunctions[indexPath.row];
    
    func.choosed = NO;
    
    for (FunctionGroup *group in self.info.allFunctions) {
        
        for (Function *tempFunc in group.functions) {
            
            if ([tempFunc.key isEqualToString:func.key]) {
                
                tempFunc.choosed = NO;
                
                break;
                
            }
            
        }
        
    }
    
    [self.myFunctions removeObjectAtIndex:indexPath.row];
    
    [self.collectionView reloadData];
    
}

-(void)addFunctionWithIndexPath:(NSIndexPath *)indexPath
{
    
    FunctionGroup *group = self.info.allFunctions[indexPath.section-1];
    
    Function *func = group.functions[indexPath.row];
    
    BOOL contains = NO;
    
    for (NSInteger i = 0 ; i<self.myFunctions.count; i++) {
        
        Function *tempFunc = self.myFunctions[i];
        
        if ([tempFunc.key isEqualToString:func.key]) {
            
            contains = YES;
            
            break;
            
        }
        
    }
    
    if (!contains) {
        
        func.choosed = YES;
        
        [self.myFunctions addObject:[func copy]];
        
    }
    
    [self.collectionView reloadData];
    
}

-(void)naviRightClick
{
    
    AllFunctionInfo *info = [[AllFunctionInfo alloc]init];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [hud showAnimated:YES];
    
    [info uploadMyFunctions:self.myFunctions result:^(BOOL success, NSString *error) {
        
        NSData *gymData = [[NSUserDefaults standardUserDefaults]objectForKey:@"func_edit"];
        
        NSMutableArray *gyms = [[NSKeyedUnarchiver unarchiveObjectWithData:gymData]mutableCopy];
        
        if (!gyms) {
            
            gyms = [NSMutableArray array];
            
        }
        
        BOOL contains = NO;
        
        for (Gym *gym in gyms) {
            
            if ([gym isEqualToGym:AppGym]) {
                
                contains = YES;
                
                break;
                
            }
            
        }
        
        if (!contains) {
            
            [gyms addObject:AppGym];
            
        }
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:gyms];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"func_edit"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            hud.label.text = @"修改成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            for (MOViewController *vc in self.navigationController.viewControllers) {
                
                if ([NSStringFromClass([vc class]) isEqualToString:@"GymDetailController"]||[NSStringFromClass([vc class]) isEqualToString:@"AllFunctionController"]) {
                    
                    [vc reloadData];
                    
                }
                
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:NO];
                
            });
            
        }else{
            
            hud.label.text = error;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

@end
