//
//  YFCVFlowLeftLayout.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCVFlowLeftLayout.h"


@implementation YFCVFlowLeftLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //第0个cell没有上一个cell，所以从1开始
    for(int i = 1; i < [attributes count]; ++i) {
        //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
        UICollectionViewLayoutAttributes *curAttr = attributes[i];
        UICollectionViewLayoutAttributes *preAttr = attributes[i-1];
        
        NSInteger origin = CGRectGetMaxX(preAttr.frame);
        //根据  maximumInteritemSpacing 计算出的新的 x 位置
        CGFloat targetX = origin + _maximumInteritemSpacing;
        // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
        if (CGRectGetMinX(curAttr.frame) > targetX) {
            // 换行时不用调整
            if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                CGRect frame = curAttr.frame;
                frame.origin.x = targetX;
                curAttr.frame = frame;
            }
        }
    }
    
    // 最后一个 靠右
    if (attributes.count > 2)
    {
        UICollectionViewLayoutAttributes *curAttr = attributes[attributes.count - 2];
        
        if (self.totalCountBlock)
        {
            if (curAttr.indexPath.row == self.totalCountBlock() - 1 ||  self.maxShowCount == curAttr.indexPath.row)
            {
                //根据  maximumInteritemSpacing 计算出的新的 x 位置
                CGFloat targetX = self.collectionView.frame.size.width - curAttr.frame.size.width - _maximumInteritemSpacing;
                // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
                if (curAttr.frame.origin.x != targetX) {
                    // 换行时不用调整
                    CGRect frame = curAttr.frame;
                    frame.origin.x = targetX;
                    curAttr.frame = frame;
                }
            }
        }
    }
    return attributes;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self. maximumInteritemSpacing = 8.f;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self. maximumInteritemSpacing = 8.f;
}

@end
