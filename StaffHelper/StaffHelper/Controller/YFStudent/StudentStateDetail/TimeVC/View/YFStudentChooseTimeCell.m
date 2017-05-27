//
//  YFStudentChooseTimeCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentChooseTimeCell.h"
#import "YFAppConfig.h"

@interface YFStudentChooseTimeCell ()<UITextFieldDelegate>

@end

@implementation YFStudentChooseTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.startTimeTF];
        [self.contentView addSubview:self.nameLabel];
        
        self.startTimeTF.inputView = self.startKV;
    }
    return self;
}
-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 26.5, 15.5, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}

- (UITextField *)startTimeTF
{
    if (!_startTimeTF)
    {
        CGFloat width = 120;
        _startTimeTF = [[UITextField alloc]initWithFrame:CGRectMake(self.arrowImageView.left - width - 10, 0, width, 43.0)];
        [self setTextFieldSetting:_startTimeTF];
    }
    return _startTimeTF;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( 19, 0, 70, 43.0)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(15.0);
    }
    return _nameLabel;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
 
    _arrowImageView.frame = CGRectMake(MSW - 26.5, (self.contentView.height - 12) / 2.0, 7.5, 12);
    
    _nameLabel.frame = CGRectMake( 19, 0, 70, self.contentView.height);
    
    _startTimeTF.frame = CGRectMake(self.arrowImageView.left - _startTimeTF.width - 10, 0, _startTimeTF.width, self.contentView.height);
    
    _startTimeTF.font = FontSizeFY(XFromCellHeightYF(self,40, 13));
    _nameLabel.font = FontSizeFY(XFromCellHeightYF(self,40, 13));

    
}

- (void)setTextFieldSetting:(UITextField *)textfield
{
    textfield.textColor = YFCellTitleColor;
    //        _startTimeTF.text = self.filter.startDate.length?self.filter.startDate:[df stringFromDate:[NSDate date]];
    
    textfield.delegate = self;
    
    textfield.backgroundColor = [UIColor clearColor];
    textfield.textAlignment = NSTextAlignmentRight;
    textfield.font = FontSizeFY(12.0);
    
    textfield.layer.cornerRadius = 4.0f;
    textfield.clipsToBounds = YES;
}


- (QCKeyboardView *)startKV
{
    if (!_startKV)
    {
        _startKV = [QCKeyboardView defaultKeboardView];
        
        _startKV.keyboard = self.startDP;
    }
    return _startKV;
}

-(UIDatePicker *)startDP
{
    if (!_startDP)
    {
        _startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        _startDP.datePickerMode = UIDatePickerModeDate;
    }
    return _startDP;
}

@end
