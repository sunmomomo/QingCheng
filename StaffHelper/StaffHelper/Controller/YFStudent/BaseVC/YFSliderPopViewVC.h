//
//  YFSliderPopViewVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

@interface YFSliderPopViewVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, strong)UIView *rightView;
@property(nonatomic, strong)UIView *leftView;

- (void)showRightView;
- (void)showLeftView;

- (void)showRightViewNow;

@end
