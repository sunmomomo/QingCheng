//
//  YFSignUpAttendanceCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpAttendanceCell.h"

@implementation YFSignUpAttendanceCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.attenView];
        [self.contentView addSubview:self.checkinView];
        [self.contentView addSubview:self.groupView];
        [self.contentView addSubview:self.privateView];
    }
    return self;
}


- (YFAttendanceRankView *)attenView
{
    if (!_attenView) {
        
        YFAttendanceRankView *attRaView = [[YFAttendanceRankView alloc] initWithFrame:CGRectMake(0, 78, MSW / 2.0, Width(122))];
        
        attRaView.mainColor = RGB_YF(249, 148, 78);
        
        attRaView.midNumUnitLabel.text = @"出勤(天)";
        
        _attenView = attRaView;
    }
    return _attenView;
}



- (YFAttendanceRankView *)checkinView
{
    if (!_checkinView) {
        
        YFAttendanceRankView *attRaView = [[YFAttendanceRankView alloc] initWithFrame:CGRectMake(self.attenView.right, self.attenView.top, MSW - self.attenView.right, self.attenView.height)];
        
        attRaView.mainColor = RGB_YF(140, 181, 186);
        
        attRaView.midNumUnitLabel.text = @"签到(次)";
        
        _checkinView = attRaView;
    }
    return _checkinView;
}


- (YFAttendanceRankView *)groupView
{
    if (!_groupView) {
        
        YFAttendanceRankView *attRaView = [[YFAttendanceRankView alloc] initWithFrame:CGRectMake(self.attenView.left, self.attenView.bottom + Width(24), self.attenView.width, self.attenView.height)];
        
        attRaView.mainColor = RGB_YF(28, 165, 230);
        
        attRaView.midNumUnitLabel.text = @"团课(节)";
        
        _groupView = attRaView;
    }
    return _groupView;
}


- (YFAttendanceRankView *)privateView
{
    if (!_privateView) {
        
        YFAttendanceRankView *attRaView = [[YFAttendanceRankView alloc] initWithFrame:CGRectMake(self.checkinView.left, self.groupView.top, self.checkinView.width, self.groupView.height)];
        
        attRaView.mainColor = RGB_YF(121, 134, 204);
        
        attRaView.midNumUnitLabel.text = @"私教(节)";

        
        _privateView = attRaView;
    }
    return _privateView;
}




@end
