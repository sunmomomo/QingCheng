//
//  YFGrayCellModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFGrayCellModel : YFBaseCModel


@property(nonatomic,strong)UIColor *backGroungColor;

@property(nonatomic, copy)NSString *title;

+ (instancetype)defaultWithCellHeght:(CGFloat )cellHeight;

+ (instancetype)defaultWithCellHeght:(CGFloat )cellHeight title:(NSString *)title;

@end
