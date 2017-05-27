//
//  YFTagCollectionView.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFTagCollectionView.h"

#import "YFTagColloectionViewCell.h"

#import "YFTagPreDesCViewCell.h"

#import "YFTagModel.h"

#import "UICollectionViewLeftAlignedLayout.h"

#import "YFTagPreDesCModel.h"

#import "YFAddTagCViewCell.h"

#import "YFAddTagModel.h"

#import "YFTagFooterModel.h"


#import "YFTagFooterCReusableView.h"

#import "YFCVFlowLeftLayout.h"

@interface YFTagCollectionView ()


@property(nonatomic, strong)YFTagPreDesCModel *preDesCmodel;

@property(nonatomic, strong)YFTagPreDesCModel *moreDesCmodel;

@property(nonatomic, strong)UILabel *preSmsTextLabel;

@end

@implementation YFTagCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.collectionView registerClass:[YFTagColloectionViewCell class] forCellWithReuseIdentifier:yFTagColloectionViewCell];
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self.collectionView registerClass:[YFTagPreDesCViewCell class] forCellWithReuseIdentifier:yFTagPreDesCViewCell];
        
        [self.collectionView registerClass:[YFAddTagCViewCell class] forCellWithReuseIdentifier:yFAddTagCViewCell];
        
        [self.collectionView registerClass:[YFTagFooterCReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:yFTagFooterCReusableView];
        
        YFTagFooterModel *footerModel = [YFTagFooterModel defaultWithYYModelDic:nil];
        self.footerModel = footerModel;
        [self.footerModelArray addObject:footerModel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.collectionView.frame = self.bounds;
}

-(void)addTagModelsArray:(NSMutableArray *)array
{
    if (!array) {
        array = [NSMutableArray array];
    }else
    {
        array = [array mutableCopy];
    }
    
    if (array.count == 0)
    {
        [array addObject:self.preDesCmodel];
    }else
    {
        [array insertObject:self.preDesCmodel atIndex:0];
    }
    [array addObject:self.addModel];

    if ([self.allSectionArray containsObject:self.modelArray])
    {
    [self.allSectionArray removeObject:self.modelArray];
    }
    [self.allSectionArray addObject:array];
    
    self.modelArray = array;
    [self.collectionView reloadData];
}

- (NSMutableArray *)getTagModelsArray
{
    NSMutableArray * tagsModelArray = self.modelArray.mutableCopy;
    
    if (tagsModelArray.count >= 2)
    {
        // 去掉第一 和 最后一个
        [tagsModelArray removeObjectAtIndex:0];
        [tagsModelArray removeObjectAtIndex:tagsModelArray.count - 1];
    }
    return tagsModelArray;
}

- (BOOL)isHaveTagData
{
    return self.modelArray.count > 2;
}

- (UICollectionViewFlowLayout *)flowOutYF
{
    YFCVFlowLeftLayout *flowLayOut = [[YFCVFlowLeftLayout alloc] init];
    
    flowLayOut.maxShowCount = MaxShowCount;
    weakTypesYF
    [flowLayOut setTotalCountBlock:^NSUInteger{
        return weakS.modelArray.count;
    }];
    return flowLayOut;
}


// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 7;
}
// 列 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 7;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.allSectionArray.count > section) {
        NSArray *array = self.allSectionArray[section];
        if (array.count > MaxShowCount) {
            return MaxShowCount + 1;
        }
        return array.count;
    }
    
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.footerModelArray.count >section)
    {
        YFBaseCModel *footerModel = self.footerModelArray[section];
        
        
        
        return footerModel.cellSize;
    }
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
      if (kind == UICollectionElementKindSectionFooter){
          
          if (self.footerModelArray.count > indexPath.section)
          {
              YFBaseCModel *footerModel = self.footerModelArray[indexPath.section];
              
              UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerModel.cvCellIdentifier forIndexPath:indexPath];
              if ([footerModel isEqual:self.footerModel]) {
                  if ([self.textView.superview isEqual:footerview] == NO)
                  {
                      [footerview addSubview:self.textView];
                      [footerview sendSubviewToBack:self.textView];
                  }
              }
              [footerModel bindCollVFooterOrHeader:footerview indexPath:indexPath];
              
              return  footerview;
          }
      }
    return nil;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allSectionArray.count > indexPath.section)
    {
        NSMutableArray *array = self.allSectionArray[indexPath.section];
        if (array.count > indexPath.row)
        {
            YFBaseCModel *cmodel = [self modelWithIndexPath:indexPath array:array];
            
            YFBaseCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cmodel.cvCellIdentifier forIndexPath:indexPath];
            cell.deleteBlock = self.deleteBlock;
            [cmodel bindCollVCell:cell indexPath:indexPath];
            
            return cell;
        }
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellTagDefault" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allSectionArray.count > indexPath.section)
    {
        NSMutableArray *array = self.allSectionArray[indexPath.section];
        if (array.count > indexPath.row)
        {
            YFBaseCModel *cmodel = [self modelWithIndexPath:indexPath array:array];
            DebugLogParamYF(@"-----::%ld",(long)indexPath.row);
            return cmodel.cellSize;
        }
    }
    return CGSizeZero;
}


- (YFAddTagModel *)addModel
{
    if (!_addModel)
    {
        // 添加
        YFAddTagModel * addModel = [YFAddTagModel defaultWithYYModelDic:nil];
        addModel.addTagBlock = self.addTagBlock;
        _addModel = addModel;
    }
    return _addModel;
}



- (YFTagPreDesCModel *)preDesCmodel
{
    if (!_preDesCmodel)
    {
        YFTagPreDesCModel *preDesModel = [YFTagPreDesCModel defaultWithYYModelDic:nil];
        preDesModel.des = @"收件人:";
        _preDesCmodel = preDesModel;
    }
    return _preDesCmodel;
}



- (YFTagPreDesCModel *)moreDesCmodel
{
    if (!_moreDesCmodel)
    {
        YFTagPreDesCModel *preDesModel = [YFTagPreDesCModel defaultWithYYModelDic:nil];
        
        _moreDesCmodel = preDesModel;
        
        _moreDesCmodel.moreTagBlock = self.moreTagBlock;
    }
    NSString *str = [NSString stringWithFormat:@"...等%@人",@(self.modelArray.count - 2)];
    
    CGSize size = YF_MULTILINE_TEXTSIZE(str, FontSizeFY(15.0), CGSizeMake(200, 26), 0)

    _moreDesCmodel.cellSize = CGSizeMake(ceil(size.width) + 10, 26);
    _moreDesCmodel.des = str;
    return _moreDesCmodel;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allSectionArray.count > indexPath.section)
    {
        NSMutableArray *array = self.allSectionArray[indexPath.section];
        
        if (array.count > indexPath.row)
        {
            YFBaseCModel *cmodel = [self modelWithIndexPath:indexPath array:array];
            
            [cmodel collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        }
    }
}

- (YFBaseCModel *)modelWithIndexPath:(NSIndexPath *)indexPath array:(NSMutableArray *)array
{
    YFBaseCModel *cmodel = array[indexPath.row];
    
    if (self.modelArray.count > MaxShowCount && indexPath.row == MaxShowCount - 1) {
        cmodel = self.moreDesCmodel;
    }else if (self.modelArray.count > MaxShowCount && indexPath.row == MaxShowCount)
    {
        cmodel = self.addModel;
    }
    return cmodel;
}


- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, self.footerModel.cellSize.height - 10)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = FontSizeFY(15.0);
//        _textView.placeHolder = @"输入短信内容";
//        _textView.placeHolderTextColor = RGB_YF(187, 187, 187);
        _textView.textColor = RGB_YF(51, 51, 51);
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _textView.width, 1)];
        view.backgroundColor = [UIColor whiteColor];
        [_textView addSubview:view];
        
        [_textView addSubview:self.preSmsTextLabel];
        // 26 个空格
        _textView.text = @"                          ";

    }
    return _textView;
}

- (UILabel *)preSmsTextLabel
{
    if (!_preSmsTextLabel) {
        _preSmsTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8,110, 16)];
        
        _preSmsTextLabel.text =  @"【健身房消息】";
        
        _preSmsTextLabel.textColor = RGB_YF(187, 187, 187);
        
        _preSmsTextLabel.font = FontSizeFY(15.0);
      }
    
    return _preSmsTextLabel;
}


@end
