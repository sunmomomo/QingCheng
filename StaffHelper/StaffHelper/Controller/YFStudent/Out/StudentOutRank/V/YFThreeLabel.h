//
//  YFThreeLabel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFThreeLabel : UIView

@property(nonatomic, strong)UILabel *rightTopLabel;
@property(nonatomic, strong)UILabel *valueMidLabel;
@property(nonatomic, strong)UILabel *desDownLabel;

@property(nonatomic, assign)CGFloat offsetRightTop;


- (void)setBigStyle;
- (void)setBigTextColor;

- (void)setSmallStyle;

- (void)setValueStr:(NSString *)valueStr;

- (void)setStudenetDetaiStyle;

- (void)setBottomLineViewWithColor:(UIColor *)color;

- (void)setSignUpAttendanceStyle;
@end
