//
//  YFAddNewGymCVCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/4.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFAddNewGymCVCell : UICollectionViewCell

// 用于 跳转 到 新增健身房
@property(nonatomic,weak)UIViewController *weakVC;
@property(nonatomic,strong)Brand *brand;

@property(nonatomic,assign)BOOL noGym;

@end
