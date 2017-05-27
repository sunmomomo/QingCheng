//
//  YFCardBasePopView.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFConditionPopView.h"

#import "YFBaseRefreshVC.h"

@interface YFCardBasePopView : YFConditionPopView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame sufient:(BOOL)isSuffent;


@property(nonatomic ,assign)BOOL isNotSuffient;

@property(nonatomic, weak)YFBaseRefreshVC *popSubVC;


@property(nonatomic, copy)void(^hideBlock)();

@end
