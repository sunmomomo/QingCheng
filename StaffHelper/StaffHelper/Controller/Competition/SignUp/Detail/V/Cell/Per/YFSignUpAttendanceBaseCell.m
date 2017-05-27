//
//  YFSignUpAttendanceBaseCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpAttendanceBaseCell.h"

@implementation YFSignUpAttendanceBaseCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.attendanceDesLabel];
        [self.contentView addSubview:self.attendanceDesTimeLabel];

    }
    return self;
}




- (UILabel *)attendanceDesLabel
{
    if (!_attendanceDesLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 90 , 22)];
        
        label.textColor = YFCellTitleColor;
        
        label.font = BoldFontSizeFY(16.0);
        
        label.text = @"TA的出勤";
        
        _attendanceDesLabel = label;
    }
    return _attendanceDesLabel;
}

-(UILabel *)attendanceDesTimeLabel
{
    if (!_attendanceDesTimeLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, self.attendanceDesLabel.bottom + 1, 150 , 22)];
        
        label.textColor = YFCellSubHintGrayTitleColor;
        
        label.font = FontSizeFY(12);
        
        label.text = @"(每天00:00更新数据)";
        
        _attendanceDesTimeLabel = label;
    }
    return _attendanceDesTimeLabel;

}

@end
