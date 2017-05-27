//
//  CourseRateLabel.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LabelBackColor [UIColorFromRGB(0xF9944E) colorWithAlphaComponent:0.15];

@interface CourseRateLabel : UIView

@property(nonatomic,copy)NSString *text;

@property(nonatomic,strong)UIColor *textColor;

@end
