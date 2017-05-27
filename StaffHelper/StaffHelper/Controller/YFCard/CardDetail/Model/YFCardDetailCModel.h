//
//  YFCardDetailCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFCardDetailCModel : YFBaseCModel

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *des;
@property(nonatomic, copy)NSString *iconImageName;
@property(nonatomic, assign)BOOL isShowArrow;

@property(nonatomic, assign)NSUInteger numLinesOfdesLabel;


@end
