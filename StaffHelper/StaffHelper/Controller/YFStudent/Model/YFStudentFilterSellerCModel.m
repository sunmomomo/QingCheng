//
//  YFStudentFilterSellerCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterSellerCModel.h"

#import "YFStudentFilterSellerCell.h"

#import "YFCollectionViewSellerCell.h"

#import "YFSellerModel.h"

#define YFCollecViewCellHeight (XFrom6YF(113.0) * StudentRightShowScale + 4)

static NSString *yFStudentFilterSellerCell = @"YFStudentFilterSellerCell";

static NSString *yfCollectionViewSellerCell = @"YFCollectionViewSellerCell";

@interface YFStudentFilterSellerCModel ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation YFStudentFilterSellerCModel



- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterSellerCell;
        self.cellClass = [YFStudentFilterSellerCell class];
        self.cellHeight = XFrom6YF(220.0);
    }
    return self;
}

-(void)setCell:(YFStudentFilterSellerCell *)baseCell toObjectFY:(NSObject *)object
{
    
    [baseCell.collectionView registerClass:[YFCollectionViewSellerCell class] forCellWithReuseIdentifier:yfCollectionViewSellerCell];

    baseCell.collectionView.delegate = self;
    baseCell.collectionView.dataSource = self;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray.count <= 8)
    {
        return self.dataArray.count;
    }
 
    if (self.dataArray.count > 8 && self.isShowAll == NO)
    {
        return 8;
    }
    return self.dataArray.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YFCollectionViewSellerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:yfCollectionViewSellerCell forIndexPath:indexPath];
    
    if (self.dataArray.count > indexPath.row)
    {
        YFSellerModel * model = self.dataArray[indexPath.row];
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
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[[self class] sexImageWithGender:@"0"]];
        
        cell.isSelected = model.isSelected;
        
    }
    
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (MSW * StudentRightShowScale - 40) / 4.0 - 0.5;
    
    return CGSizeMake(width, YFCollecViewCellHeight);
}


- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.0;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(-23, 0, 0.0, 0);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > indexPath.row)
    {
        YFSellerModel * model = self.dataArray[indexPath.row];

        if ([_selelctModel isEqual:model])
        {
        _selelctModel.isSelected = !_selelctModel.isSelected;
        }
        else
        {
            _selelctModel.isSelected = NO;
            model.isSelected = YES;
            _selelctModel = model;
        }
        
        [collectionView reloadData];

            if (self.selelctModel.isSelected)
            {
                self.param = @{@"seller_id":model.s_id};
            }
            else
            {
                self.selelctModel = nil;
                self.param = @{};
            }
    }
}

- (void)setUnSelectSellerModel
{
    _selelctModel.isSelected = NO;
    self.selelctModel = nil;
    self.param = @{};
    YFStudentFilterSellerCell *cell = (YFStudentFilterSellerCell *)self.weakCell;
    [cell.collectionView reloadData];
}

- (void)setIsShowAll:(BOOL)isShowAll
{
    _isShowAll = isShowAll;
    
    [self checkCellHight];

    YFStudentFilterSellerCell *cell = (YFStudentFilterSellerCell *)self.weakCell;
    
    [cell.collectionView reloadData];

}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    [self checkCellHight];
    
    YFStudentFilterSellerCell *cell = (YFStudentFilterSellerCell *)self.weakCell;
    
    [cell.collectionView reloadData];
}

-  (void)checkCellHight
{
    CGFloat cellHeight = 0;
    
    if (self.dataArray.count <= 4)
    {
        cellHeight = YFCollecViewCellHeight;
        
    }else if (self.dataArray.count <= 8)
    {
        cellHeight = YFCollecViewCellHeight * 2;
    }else if (self.dataArray.count > 8 && self.isShowAll == NO)
    {
        cellHeight = YFCollecViewCellHeight * 2;;
    }else if (self.dataArray.count % 4 == 0)
    {
        cellHeight = self.dataArray.count / 4 * YFCollecViewCellHeight;
    }else
    {
        cellHeight = (self.dataArray.count / 4 + 1) * YFCollecViewCellHeight;
        
    }
    
    self.cellHeight =  cellHeight - 18;
}

- (void)setSelelctModel:(YFSellerModel *)selelctModel
{
    _selelctModel = selelctModel;
    
    YFStudentFilterSellerCell *cell = (YFStudentFilterSellerCell *)self.weakCell;
    
    [cell.collectionView reloadData];
}


@end
