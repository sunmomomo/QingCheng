//
//  YFAddSmsPeopleCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFAddSmsPeopleCModel : YFBaseCModel

@property(nonatomic, strong)void(^addButtonBlock)(id);

/**
 * 标签 Model Array
 */
@property(nonatomic, strong)NSMutableArray *tagsModelArray;

- (void)addStudentArray:(NSMutableArray *)array;

@end
