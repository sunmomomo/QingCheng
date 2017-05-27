//
//  YFTagPreDesCModel.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFTagPreDesCModel.h"

#import "YFTagPreDesCViewCell.h"

@implementation YFTagPreDesCModel


- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        
        self.cvCellIdentifier = yFTagPreDesCViewCell;
        self.cellClass = [YFTagPreDesCViewCell class];
        self.cellSize = CGSizeMake(60, 26);
    }
    return self;
}


- (void)bindCollVCell:(YFTagPreDesCViewCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.tagNameLabel.text = self.des;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.moreTagBlock) {
        self.moreTagBlock(self);
    }
}

@end
