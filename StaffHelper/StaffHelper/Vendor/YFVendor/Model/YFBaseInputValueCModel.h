//
//  YFBaseInputValueCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFBaseInputValueCModel : YFBaseCModel

@property(nonatomic,copy)void(^changeValueBlock)(id);

@property(nonatomic, copy)NSString *valueStringFY;

/**
 * 值 改变
 */
-(void)valueChangeFY:(id)sender;

@end

