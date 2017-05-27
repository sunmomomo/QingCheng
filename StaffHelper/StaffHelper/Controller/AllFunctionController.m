//
//  AllFunctionController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "AllFunctionController.h"

#import "FunctionCell.h"

#import "FunctionNoneCell.h"

#import "FunctionEditController.h"

#import "AllFunctionInfo.h"

#import "GymProHintView.h"

#import "GymProController.h"

#import "GymTrySuccessAlert.h"

#import "QingChengHandler.h"

#import "GymProInfo.h"

static NSString *identifier = @"Cell";

static NSString *noneIdentifier = @"None";

static NSString *headIdentifier = @"Head";

static NSString *footIdentifier = @"Foot";

static NSString *normalFootIdentifier = @"Normal";

@interface AllFuncHeaderView : UICollectionReusableView
{
    
    UILabel *_textLabel;
    
}

@property(nonatomic,copy)NSString *title;

@end

@implementation AllFuncHeaderView

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

@interface AllFuncFooterView :UICollectionReusableView

@end

@implementation AllFuncFooterView

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

@interface AllFunctionController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,GymProHintViewDelegate,GymTrySuccessAlertDelegate>

@property(nonatomic,strong)AllFunctionInfo *info;

@property(nonatomic,strong)NSArray *myFunctions;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)Function *tryFunction;

@end

@implementation AllFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [AllFunctionInfo defaultInfo];
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    AllFunctionInfo *info = [AllFunctionInfo defaultInfo];
    
    [info requestMyFunctionResult:^(BOOL success, NSString *error) {
        
        self.myFunctions = info.myFunctions;
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"全部功能";
    
    self.rightTitle = @"管理";
    
    self.rightColor = UIColorFromRGB(0xffffff);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.collectionView registerClass:[FunctionCell class] forCellWithReuseIdentifier:identifier];
    
    [self.collectionView registerClass:[FunctionNoneCell class] forCellWithReuseIdentifier:noneIdentifier];
    
    [self.collectionView registerClass:[AllFuncHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
    
    [self.collectionView registerClass:[AllFuncFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footIdentifier];
    
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
            
            cell.title = @"点击【管理】，将常用功能添加到这里";
            
            return cell;
            
        }else{
            
            FunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            if (indexPath.row<[self.myFunctions count]) {
                
                Function *func = self.myFunctions[indexPath.row];
                
                cell.title = func.title;
                
                cell.image = [UIImage imageNamed:func.imagePath];
                
                cell.indexPath = indexPath;
                
                if (AppGym.pro) {
                    
                    cell.type = FunctionCellTypeFree;
                    
                }else{
                    
                    cell.type = func.pro?FunctionCellTypePro:FunctionCellTypeFree;
                    
                }
                
            }else
            {
                
                cell.title = nil;
                
                cell.image = nil;
                
                cell.type = FunctionCellTypeFree;
                
            }
            
            return cell;
            
        }
        
    }else{
        
        FunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        FunctionGroup *group = self.info.allFunctions[indexPath.section-1];
        
        if (indexPath.row<[group.functions count]) {
            
            Function *func = group.functions[indexPath.row];
            
            cell.title = func.title;
            
            cell.image = [UIImage imageNamed:func.imagePath];
            
            cell.indexPath = indexPath;
            
            if (AppGym.pro) {
                
                cell.type = FunctionCellTypeFree;
                
            }else{
                
                cell.type = func.pro?FunctionCellTypePro:FunctionCellTypeFree;
                
            }
            
        }else
        {
            
            cell.title = nil;
            
            cell.image = nil;
            
            cell.type = FunctionCellTypeFree;
            
        }
        
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
            
            AllFuncHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
            
            if (indexPath.section == 0) {
                
                header.title = @"常用功能";
                
            }else{
                
                FunctionGroup *group = self.info.allFunctions[indexPath.section-1];
                
                header.title = group.title;
                
            }
            
            return header;
            
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]&& indexPath.section == self.info.allFunctions.count) {
            
            AllFuncFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footIdentifier forIndexPath:indexPath];
            
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
    
    Function *function;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row<self.myFunctions.count) {
            
            function = self.myFunctions[indexPath.row];
            
        }
        
    }else{
        
        FunctionGroup *group = self.info.allFunctions[indexPath.section-1];
        
        if (indexPath.row< [group.functions count]){
            
            function = group.functions[indexPath.row];
            
        }
        
    }
    
    if (function) {
        
        if (function.pro && !AppGym.pro) {
            
            GymProHintView *hintView = [GymProHintView defaultView];
            
            hintView.title = function.title;
            
            hintView.delegate = self;
            
            hintView.canTry = !AppGym.haveTried;
            
            [hintView showInView:self.view];
            
            self.tryFunction = function;
            
        }else{
            
            UIViewController *vc = [QingChengHandler handlerOpenWithFunction:function];
            
            if (vc) {
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        
        pasteboard.string = @"http://cloud.qingchengfit.cn/backend/settings/";
        
        [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)trySuccessAlertStart
{
    
    UIViewController *vc = [QingChengHandler handlerOpenWithFunction:self.tryFunction];
    
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)openWithFunction:(Function*)function
{
    
    UIViewController *vc = [QingChengHandler handlerOpenWithFunction:function];
    
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)naviRightClick
{
    
    FunctionEditController *svc = [[FunctionEditController alloc]init];
    
    svc.myFunctions = [self.myFunctions mutableCopy];
    
    [self.navigationController pushViewController:svc animated:NO];
    
}

@end
