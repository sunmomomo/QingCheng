//
//  YFCVFlowLeftLayout.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCVFlowLeftLayout : UICollectionViewFlowLayout

@property (nonatomic) CGFloat maximumInteritemSpacing;

// 判断是否 是 最后一个
@property(nonatomic, copy)NSUInteger(^totalCountBlock)();

@property(nonatomic, assign)NSUInteger maxShowCount;

@end
