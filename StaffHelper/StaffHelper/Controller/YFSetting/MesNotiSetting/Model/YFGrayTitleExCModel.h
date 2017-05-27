//
//  YFGrayTitleExCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFGrayTitleExCModel : YFBaseCModel

@property(nonatomic, assign)CGFloat xx;

@property(nonatomic, copy)NSString *title;

@property(nonatomic,strong)UIColor *backGroungColor;

+ (instancetype)defaultWithCellHeght:(CGFloat )cellHeight title:(NSString *)title;

@end
