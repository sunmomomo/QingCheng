//
//  YFConditionSellerPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFConditionSellerPopView.h"
#import "YFAppConfig.h"
#import "YFCollectionViewSellerCell.h"
#import "YFSellerDataModel.h"
#import "YFSellerModel.h"
#import "YFAppService.h"

static NSString *yfCollectionViewSellerCell = @"YFCollectionViewSellerCell";

@interface YFConditionSellerPopView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)YFSellerDataModel *dataModel;

@property(nonatomic,strong)YFSellerModel *selelctModel;



@end

@implementation YFConditionSellerPopView
{
    NSString *_seller_idFromRightVC;
    
    BOOL _isChecked;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame superView:superView];
    if (self)
    {
        _isChecked = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNOPull) name:kPostAddNewSellerIdtifierYF object:nil];

        if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone) {
            self.isCanShow = NO;
        }
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, self.childredView.width - 20, self.childredView.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        self.collectionView.mj_insetB = 20;
        self.collectionView.delegate = self;
        
        self.collectionView.dataSource = self;
        
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        [self.childredView addSubview:self.collectionView];

        [self.collectionView registerClass:[YFCollectionViewSellerCell class] forCellWithReuseIdentifier:yfCollectionViewSellerCell];

        [self setRefreshViewSettingto:self.collectionView];
        
//        self.baseDataArray = @[@"1",@"2",@"3",@"4",@"5"].mutableCopy;
      
        [self.collectionView reloadData];
        self.backgroundColor = [UIColor clearColor];
     
        [self refreshTableListData];
        self.collectionView.showsVerticalScrollIndicator = NO;

    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.baseDataArray.count;
    
}

- (void)setOriginFrame:(CGRect)originFrame
{
    [super setOriginFrame:originFrame];
    
    self.collectionView.frame = CGRectMake(0, 0, originFrame.size.width, originFrame.size.height);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YFCollectionViewSellerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:yfCollectionViewSellerCell forIndexPath:indexPath];
    
    if (self.baseDataArray.count > indexPath.row)
    {
        YFSellerModel * model = self.baseDataArray[indexPath.row];
        cell.nameLabel.text = model.username;
        if (model.isALl || model.isNoSelle)
        {
            
            if (model.isALl && model.isSelected)
            {
                [cell.headImageView setImage:[UIImage imageNamed:@"AllSellerSe"]];
            }else
            {
                [cell.headImageView setImage:[UIImage imageNamed:model.avatar]];
            }
            
        }else
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];

        cell.isSelected = model.isSelected;
        
    }
    
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (MSW - 20) / 4.0 - 0.5;
    
    return CGSizeMake(width, XFrom6YF(113.0));
}


- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.0;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 4.0;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0.0, 0, 0.0, 0);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDataArray.count > indexPath.row)
    {
        _selelctModel.isSelected = NO;
        YFSellerModel * model = self.baseDataArray[indexPath.row];
        model.isSelected = YES;
        _selelctModel = model;
        
        [collectionView reloadData];
        if (self.selectBlock)
        {
//            self.value = model.username;

            if (model.isALl)
            {
                // 无效 只是 记住 选过值了
                self.param = @{};
                self.isValidParam = NO;
            }else
            {
                self.param = @{@"seller_id":model.s_id};
                self.isValidParam = YES;
            }
            self.selectBlock(self.value,self.param);

        }
    }
}

- (void)requestData
{
    if (self.isReFreshing) {
        self.dataModel.page = 1;
    }else
    {
        self.dataModel.page = (self.dataModel.dataMOdel.current_page.integerValue + 1);
    }
    weakTypesYF
    [self.dataModel getResponseDatashowLoadingOn:nil gym:self.gym isHaveAllSeller:YES successBlock:^{
        [self checkSelectId];
        
        [weakS requestSuccessArray:weakS.dataModel.dataMOdel.listArray];
        if (weakS.dataModel.allModel.isSelected && weakS.selelctModel == nil)
        {
            weakS.selelctModel = weakS.dataModel.allModel;
        }
        if (weakS.dataModel.page >= weakS.dataModel.dataMOdel.pages.integerValue)
        {
            weakS.refreshScrollView.mj_footer = nil;
        }
    } failBlock:^{
        [weakS failRequest:nil];
    }];
}

-(YFSellerDataModel *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [[YFSellerDataModel alloc] init];
    }
    return _dataModel;
}


- (void)emptyDataReminderAction
{
    
}
- (void)showWhenCannotShow
{
    [YFAppService showAlertMessage:@"您只能查看自己名下的会员"];
}

-(void)showFailViewOnSuperView:(UIView *)superView
{
    superView = self.childredView;
    [super showFailViewOnSuperView:superView];
}

- (void)afterSetRightVCAllConditionsParam:(NSDictionary *)patamDic
{
    NSString *seller_id = patamDic[@"seller_id"];
    _seller_idFromRightVC = seller_id;
    _isChecked = NO;
    if (self.baseDataArray.count)
    {
        [self checkSelectId];
    }
}

- (void)checkSelectId
{
    if (_isChecked) {
        return;
    }
    _selelctModel.isSelected = NO;

    _isChecked = YES;
    for (YFSellerModel * model in self.baseDataArray)
    {
        if (!_seller_idFromRightVC) {
            if (model.isALl) {
                model.isSelected = YES;
                self.selelctModel = model;
            }
        }else
        {
            if(model.s_id.integerValue == _seller_idFromRightVC.integerValue && model.isALl == NO)
            {
                model.isSelected = YES;
                self.selelctModel = model;
            }
        }
    }

    if (self.selelctModel.isALl)
    {
        // 无效 只是 记住 选过值了
        self.param = @{};
        self.isValidParam = NO;
    }else
    {
        self.param = @{@"seller_id":self.selelctModel.s_id};
        self.isValidParam = YES;
    }

    
    [self.collectionView reloadData];
}


@end
