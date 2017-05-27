//
//  NSObject+firterModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFFilterOtherModel.h"

@interface NSObject (firterModel)

/**
 * 因为 有的 情况 需要 左滑 筛选
 */
@property(nonatomic, strong)YFFilterOtherModel *fiterOtherModelCaYF;

@property(nonatomic, copy)void(^showRightBlockCaYF)(id);


@end
