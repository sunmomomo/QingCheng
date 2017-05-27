//
//  YFCollectionView.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFCollectionView.h"

#import "YFBaseCModel.h"

#import "YFBaseCViewCell.h"


@implementation YFCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:[self flowOutYF]];
        
        self.collectionView.delegate = self;
        
        self.collectionView.dataSource = self;

        self.collectionView.backgroundColor = [UIColor clearColor];
        
        self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

        [self addSubview:self.collectionView];
    }
    return self;
}

- (UICollectionViewFlowLayout *)flowOutYF
{
    return [[UICollectionViewFlowLayout alloc]init];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.allSectionArray.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.allSectionArray.count > section) {
        NSArray *array = self.allSectionArray[section];
        return array.count;
    }
    
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allSectionArray.count > indexPath.section)
    {
        NSMutableArray *array = self.allSectionArray[indexPath.section];
        if (array.count > indexPath.row)
        {
            YFBaseCModel *cmodel = array[indexPath.row];

            return cmodel.cellSize;
        }
    }
    return CGSizeZero;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allSectionArray.count > indexPath.section)
    {
        NSMutableArray *array = self.allSectionArray[indexPath.section];
        if (array.count > indexPath.row)
        {
            YFBaseCModel *cmodel = array[indexPath.row];
   
            YFBaseCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cmodel.cvCellIdentifier forIndexPath:indexPath];
            [cmodel bindCollVCell:cell indexPath:indexPath];

            return cell;
        }
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellTagDefault" forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allSectionArray.count > indexPath.section)
    {
        NSMutableArray *array = self.allSectionArray[indexPath.section];
        
        if (array.count > indexPath.row)
        {
            YFBaseCModel *cmodel = array[indexPath.row];
            
            [cmodel collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        }
    }
}

- (NSMutableArray *)allSectionArray
{
    if (_allSectionArray == nil) {
        _allSectionArray = [NSMutableArray array];
    }
    return _allSectionArray;
}

- (NSMutableArray *)footerModelArray
{
    if (_footerModelArray == nil) {
        _footerModelArray = [NSMutableArray array];
    }
    return _footerModelArray;
}
@end
