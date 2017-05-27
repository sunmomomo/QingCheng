//
//  YFInputValueCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFInputValueCell.h"

#import "YFAppConfig.h"

@implementation YFInputValueCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.valueTF];
    }
    return self;
}



- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 0.0, XFrom5To6YF(95.0), XFrom5To6YF(40))];
        _nameLabel.textColor = RGBCOLOR(51, 51, 51);
        _nameLabel.font =  AllFont(14);
    }
    return _nameLabel;
}

- (UITextField *)valueTF
{
    if (!_valueTF) {
        _valueTF = [[UITextField alloc]initWithFrame:CGRectMake(self.nameLabel.right + 5, 0, MSW - self.nameLabel.right - 19 , XFrom5To6YF(40))];
        _valueTF.textAlignment = NSTextAlignmentRight;
        _valueTF.textColor = RGB_YF(153, 153, 153);
        _valueTF.font = FontSizeFY(14.0);
        _valueTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [_valueTF addTarget:self action:@selector(textFieldChangeFY:) forControlEvents:UIControlEventEditingChanged];
    }
    return _valueTF;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake(19, 0.0, Width320(95), self.contentView.height);
    _valueTF.frame = CGRectMake(self.nameLabel.right + 5, 0, MSW - self.nameLabel.right - 19 , self.contentView.height);
    _valueTF.font = FontSizeFY(XFromWidthYF(self.contentView.height,40.0, 14));

    _nameLabel.font =  FontSizeFY(XFromWidthYF(self.contentView.height,40.0, 14));

    
}

-(void)textFieldChangeFY:(id)sender
{
    if (self.changeValueBlock)
    {
        self.changeValueBlock(self.valueTF);
    }
}

@end
