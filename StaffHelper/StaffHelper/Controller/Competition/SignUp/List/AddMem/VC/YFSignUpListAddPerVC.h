//
//  YFSignUpListAddPerVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFSignUpListAddPerCModel.h"

@interface YFSignUpListAddPerVC : YFBaseRefreshTBExtensionVC

// 已经选择的，要设置为 不可选择
@property(nonatomic, strong)NSSet *choosedNumIdDic;

@property(nonatomic ,strong)NSNumber *gym_id;

@property(nonatomic, copy)NSNumber *competition_id;

@property(nonatomic, copy)void(^chooseArrayB)(NSMutableArray *,id);


- (void)setSelctModel:(YFSignUpListAddPerCModel *)model check:(BOOL)check;

- (void)removeSelctModel:(YFSignUpListAddPerCModel *)model;

@end
