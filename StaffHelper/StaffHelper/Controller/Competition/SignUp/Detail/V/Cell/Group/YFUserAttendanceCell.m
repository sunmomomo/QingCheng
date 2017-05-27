//
//  YFUserAttendanceCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFUserAttendanceCell.h"

@implementation YFUserAttendanceCell
{
    CGFloat _viewWidth;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _viewWidth = 46;
        
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        


        _headImageView.backgroundColor = YFMainBackColor;
        
        [self.contentView addSubview:self.rightView];
        
        [self.contentView addSubview:self.firstView];
        [self.contentView addSubview:self.secondView];
        [self.contentView addSubview:self.thirdView];
        
    }
    return self;
}


- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:YFRectSixMake(40, 12, 40, 40)];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.width / 2.0;
    }
    return _headImageView;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:YFRectSixMake(90, 0, 90, 64)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(Width(15));
    }
    return _nameLabel;
}


- (YFThreeLabel *)rightView
{
    if (_rightView == nil) {
        _rightView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(_nameLabel.right, Width(15), Width(_viewWidth), Width(34))];
        [_rightView setSignUpAttendanceStyle];
        
        _rightView.rightTopLabel.text = @"天";
        _rightView.desDownLabel.text = @"出勤";
    }
    return _rightView;
}


- (YFThreeLabel *)firstView
{
    if (_firstView == nil) {
        _firstView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(self.rightView.right, Width(15), Width(_viewWidth), Width(34))];
        [_firstView setSignUpAttendanceStyle];
        
        _firstView.rightTopLabel.text = @"次";
        _firstView.desDownLabel.text = @"签到";
    }
    return _firstView;
}
- (YFThreeLabel *)secondView
{
    if (_secondView == nil) {
        _secondView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(self.firstView.right, Width(15), Width(_viewWidth), Width(34))];
        [_secondView setSignUpAttendanceStyle];
        _secondView.rightTopLabel.text = @"节";
        _secondView.desDownLabel.text = @"团课";
    }
    return _secondView;
}

- (YFThreeLabel *)thirdView
{
    if (_thirdView == nil) {
        _thirdView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(self.secondView.right, Width(15), Width(_viewWidth), Width(34))];
        [_thirdView setSignUpAttendanceStyle];
        _thirdView.rightTopLabel.text = @"节";
        _thirdView.desDownLabel.text = @"私教";
        
    }
    return _thirdView;
}



@end
