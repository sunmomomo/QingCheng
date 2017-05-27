//
//  YFOutRandDaysCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFOutRandDaysCell.h"

#import "YFAppConfig.h"

#import "YFButton.h"

@implementation YFOutRandDaysCell
{
    CGFloat _buttonWidth;
    CGFloat _buttonHeight;
    CGFloat _labelImageGap;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        
        _buttonWidth = XFrom5To6YF(68.0);
        _buttonHeight = XFrom5To6YF(24.0);
        _labelImageGap = 2;
        
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
    }
    return self;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 46)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(14);
    }
    return _nameLabel;
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        
        _leftButton = [self buttonWithFrame:CGRectMake(MSW - 2 * _buttonWidth - 15 - 10, 9, _buttonWidth, _buttonHeight)];
        
        [_leftButton setImage:[UIImage imageNamed:@"filterUnSelectGrayDown"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"filterSelectDown"] forState:UIControlStateSelected];
        [_leftButton setTitle:@"从高到低" forState:UIControlStateNormal];
        _leftButton.tag = 1;
        [self setButton:_leftButton];
    }
    return _leftButton;
}

-(YFButton *)buttonWithFrame:(CGRect )frame
{
    NSString *title = @"从高到低";
    
    CGFloat _imageWidth = XFrom5To6YF(6.0);
    CGFloat _imageHeight = XFrom5To6YF(9.0);
    
    CGSize size =  YF_MULTILINE_TEXTSIZE(title, FontSizeFY(XFrom5To6YF(11.0)), CGSizeMake(_buttonWidth  - _labelImageGap, 30), 0);
    
    CGFloat labelWidth = (long)size.width + 1;
    
    CGFloat xxlabel = (_buttonWidth - labelWidth - _imageWidth - _labelImageGap) / 2.0 ;
    CGFloat xxImage = xxlabel + labelWidth + _labelImageGap;
    

    
    YFButton *button = [[YFButton alloc] initWithFrame:frame imageFrame:CGRectMake(xxImage, _buttonHeight / 2 - 3, _imageWidth, _imageHeight) titleFrame:CGRectMake(xxlabel, 0, labelWidth, _buttonHeight)];
    
    
    return button;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [self buttonWithFrame:CGRectMake(MSW -  _buttonWidth - 15, 9, _buttonWidth, _buttonHeight)];
        
        [_rightButton setImage:[UIImage imageNamed:@"filterUnSelectGrayUp"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"filterSelectUp"] forState:UIControlStateSelected];
        [_rightButton setTitle:@"从低到高" forState:UIControlStateNormal];
        _rightButton.tag = 2;
        [self setButton:_rightButton];
        
    }
    return _rightButton;
}

- (void)setButton:(UIButton *)button
{
    button.layer.cornerRadius = button.height / 2.0;
    button.layer.borderWidth = OnePX;
    button.layer.borderColor = RGB_YF(187, 187, 187).CGColor;
    [button setTitleColor:RGB_YF(187, 187, 187) forState:UIControlStateNormal];
    [button setTitleColor:YFSelectedButtonColor forState:UIControlStateSelected];
    [button.titleLabel setFont:FontSizeFY(XFrom5To6YF(11.0))];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)buttonAction:(UIButton *)button
{
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button);
    }
}


@end
