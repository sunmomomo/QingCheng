//
//  YFCardConditionCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardConditionCell.h"

#import "YFAppConfig.h"

@implementation YFCardConditionCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.valueTF];
    }
    return self;
}



- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0.0, XFrom5To6YF(95.0), XFrom5To6YF(40))];
        _nameLabel.textColor = RGB_YF(153, 153, 153);
        _nameLabel.font = FontSizeFY(14.0);
    }
    return _nameLabel;
}

- (UILabel *)unitLabel
{
    if (_unitLabel == nil)
    {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(MSW - 30, 0.0, 15.0, XFrom5To6YF(40))];
        _unitLabel.textColor = [UIColor blackColor];
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.font = FontSizeFY(14.0);
    }
    return _unitLabel;
}

- (UITextField *)valueTF
{
    if (!_valueTF) {
        _valueTF = [[UITextField alloc]initWithFrame:CGRectMake(self.nameLabel.right + 5, 0, MSW - self.nameLabel.right - 5 - self.unitLabel.width - 15.0 , XFrom5To6YF(40))];
        _valueTF.textAlignment = NSTextAlignmentRight;
        _valueTF.textColor = RGB_YF(51, 51, 51);
        _valueTF.font = FontSizeFY(14.0);
        _valueTF.keyboardType = UIKeyboardTypeNumberPad;

        [_valueTF addTarget:self action:@selector(textFieldChangeFY:) forControlEvents:UIControlEventEditingChanged];
    }
    return _valueTF;
}

-(void)textFieldChangeFY:(id)sender
{
    if (self.changeValueBlock)
    {
        self.changeValueBlock(self.valueTF);
    }
}



@end
