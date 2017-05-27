//
//  YFStuDetailPopViewCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFStuDetailPopViewCModel : YFBaseCModel

@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,assign)BOOL isAll;

@property(nonatomic, strong)Gym *gym;

+ (instancetype)allModel;
@end
