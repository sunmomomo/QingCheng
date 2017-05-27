//
//  YFSignUpListAddPerCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListBaseCModel.h"

@interface YFSignUpListAddPerCModel : YFSignUpListBaseCModel

@property(nonatomic,assign)BOOL isCannotSelected;

@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic, strong)NSDictionary *dataDic;

- (instancetype)sameModel:(void(^)(id))selectBlock;

@end
