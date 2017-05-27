//
//  YFAddTagModel.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFAddTagModel.h"

#import "YFAddTagCViewCell.h"

@implementation YFAddTagModel


- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        
        self.cvCellIdentifier = yFAddTagCViewCell;
        
        self.cellSize = CGSizeMake(30, 26);
    }
    return self;
}


- (void)bindCollVCell:(YFAddTagCViewCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"添加");
    
    if (self.addTagBlock) {
        self.addTagBlock(self);
    }
}


@end
