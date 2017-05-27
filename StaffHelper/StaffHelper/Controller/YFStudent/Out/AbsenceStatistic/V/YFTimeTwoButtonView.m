//
//  YFTimeTwoButtonView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTimeTwoButtonView.h"

#define YFDonwnButtonSHeight XFrom5To6YF(40)


@implementation YFTimeTwoButtonView
{
    CGFloat _lineViewGapWidth;
    CGFloat _gapxx;
    CGFloat _inputyy;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.inputWidth = XFrom5YF(80);
        self.inputHeight = XFrom5To6YF(26);
        self.desName = @"缺勤天数(天)";
        _gapxx = 16.0;
        _lineViewGapWidth = XFrom5To6YF(24);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)creatView
{
    _inputyy = ((self.height - YFDonwnButtonSHeight) - self.inputHeight) / 2.0;
    
    [self addSubview:self.desNameLabel];
    [self addSubview:self.leftTextField];
    [self addSubview:self.rightTextField];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.leftTextField.right + 6, (self.height - YFDonwnButtonSHeight) / 2.0 - 0.5, _lineViewGapWidth - 12, 1)];
    lineView.backgroundColor = RGB_YF(153, 153, 153);
 
    [self addSubview:lineView];
    
    UIView *donwLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, (self.height - YFDonwnButtonSHeight) - 0.5, self.width, 1)];
    donwLineView.backgroundColor = YFGrayViewColor;
    
    [self addSubview:donwLineView];
}


#pragma mark Getter
- (UIButton *)leftButton
{
    if (!_leftButton)
    {
        CGFloat buttonWidth = self.width / 2.0;
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _leftButton.frame = CGRectMake(0, self.height -  YFDonwnButtonSHeight, buttonWidth, YFDonwnButtonSHeight);
        [_leftButton setTitle:@"返回" forState:UIControlStateNormal];
        [_leftButton setTitleColor:YFCellTitleColor forState:UIControlStateNormal];
        [_leftButton.titleLabel setFont:AllFont(14)];
        _leftButton.backgroundColor = YFMainBackColor;
        
//        [_leftButton addTarget:self action:@selector(clearAllFilterConditionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton)
    {
        CGFloat buttonWidth = MSW / 2.0;
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.frame = CGRectMake(buttonWidth, self.height -  YFDonwnButtonSHeight, buttonWidth, YFDonwnButtonSHeight);
        [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton.titleLabel setFont:AllFont(14)];
        _rightButton.backgroundColor = RGB_YF(11, 177, 75.0);
//        [_rightButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightButton;
}

- (UILabel *)desNameLabel
{
    if (_desNameLabel == nil) {
        _desNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0, 100, self.height - YFDonwnButtonSHeight)];
        _desNameLabel.font = FontSizeFY(XFrom5To6YF(12.0));
        
        _desNameLabel.textColor = YFCellTitleColor;
    }
    _desNameLabel.text = self.desName;
    return _desNameLabel;
}

- (UITextField *)leftTextField
{
    if (!_leftTextField)
    {
        CGFloat width = self.inputWidth;
        _leftTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.width - self.inputWidth * 2 - _lineViewGapWidth - _gapxx, _inputyy, width, self.inputHeight)];
        [self setTextFieldSetting:_leftTextField];
    }
    return _leftTextField;
}

- (UITextField *)rightTextField
{
    if (!_rightTextField)
    {
        CGFloat width = self.inputWidth;
        _rightTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.width - self.inputWidth - _gapxx, _inputyy, width, self.inputHeight)];
        [self setTextFieldSetting:_rightTextField];
    }
    return _rightTextField;
}

- (void)setTextFieldSetting:(UITextField *)textfield
{
    textfield.textColor = YFCellTitleColor;
    //        _startTimeTF.text = self.filter.startDate.length?self.filter.startDate:[df stringFromDate:[NSDate date]];
    textfield.backgroundColor = RGB_YF(244, 244, 244);
    textfield.textAlignment = NSTextAlignmentRight;
    textfield.font = FontSizeFY(XFrom5To6YF(12));
    
    textfield.layer.cornerRadius = 4.0f;
    textfield.clipsToBounds = YES;
    
    textfield.textAlignment = NSTextAlignmentCenter;
    
    textfield.keyboardType = UIKeyboardTypeNumberPad;
}



@end
