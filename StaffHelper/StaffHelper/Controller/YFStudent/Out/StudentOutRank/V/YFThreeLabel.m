//
//  YFThreeLabel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFThreeLabel.h"

#import "NSObject+YFExtension.h"

@implementation YFThreeLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.valueMidLabel];
        [self addSubview:self.desDownLabel];
        [self addSubview:self.rightTopLabel];
    }
    return self;
}

- (UILabel *)rightTopLabel
{
    if (_rightTopLabel == nil) {
        _rightTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2.0 + 10, -10, 10, 10)];

    }
    return _rightTopLabel;
}

- (UILabel *)valueMidLabel
{
    if (_valueMidLabel == nil) {
        _valueMidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 3 * 2)];
        _valueMidLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueMidLabel;
}

- (UILabel *)desDownLabel
{
    if (_desDownLabel == nil) {
        _desDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height / 3 * 2, self.width, self.height / 3)];
        _desDownLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _desDownLabel;
}



- (void)setBigStyle
{
    self.valueMidLabel.font = FontSizeFY(XFrom5YF(20.0));
    self.desDownLabel.font = FontSizeFY(XFrom5YF(10.0));
    self.rightTopLabel.font = FontSizeFY(XFrom5YF(8));
}

- (void)setStudenetDetaiStyle
{
    self.valueMidLabel.font = FontSizeFY(XFrom5YF(22.0));
    self.desDownLabel.font = FontSizeFY(XFrom5YF(12.0));
    self.rightTopLabel.font = FontSizeFY(XFrom5YF(8));
}


- (void)setBigTextColor
{
    self.valueMidLabel.textColor = RGB_YF(51, 51, 51);
    self.desDownLabel.textColor = RGB_YF(153, 153, 153);
    self.rightTopLabel.textColor = RGB_YF(187, 187, 187);
}


- (void)setSmallStyle
{
    self.valueMidLabel.font = FontSizeFY(XFrom5YF(14));
    self.valueMidLabel.textColor = RGB_YF(51, 51, 51);
    
    self.desDownLabel.textColor = RGB_YF(153, 153, 153);
    self.desDownLabel.font = FontSizeFY(XFrom5YF(10.0));
    
    self.rightTopLabel.font = FontSizeFY(XFrom5YF(8));
    self.rightTopLabel.textColor = RGB_YF(187, 187, 187);
    
}


- (void)setSignUpAttendanceStyle
{
    self.valueMidLabel.font = FontSizeFY(Width(15));
    self.valueMidLabel.textColor = RGB_YF(51, 51, 51);
    
    self.desDownLabel.textColor = RGB_YF(153, 153, 153);
    self.desDownLabel.font = FontSizeFY(Width(10.0));
    
    self.rightTopLabel.font = FontSizeFY(Width(8));
    self.rightTopLabel.textColor = RGB_YF(187, 187, 187);
    
}


- (void)setValueStr:(NSString *)valueStr
{
    valueStr = [valueStr guardStringYF];
    
    if (valueStr.length <= 0) {
        valueStr = @"0";
    }
    
    CGSize size = YF_MULTILINE_TEXTSIZE(valueStr, self.valueMidLabel.font, CGSizeMake(self.width, self.valueMidLabel.height), 0);

    CGFloat width = size.width + 1;
    
    _rightTopLabel.frame = CGRectMake(self.width / 2.0 + width / 2.0, _offsetRightTop, 10, 10);

    _valueMidLabel.text = valueStr;
}

- (void)setBottomLineViewWithColor:(UIColor *)color
{
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width320(16), Height320(2))];
    
    vie.center = CGPointMake(self.width / 2.0, self.height + Width320(7));
    
    vie.backgroundColor = color;
    
    vie.layer.cornerRadius = vie.height;
    
    vie.layer.masksToBounds = YES;
    
    [self addSubview:vie];
}

@end
