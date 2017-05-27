//
//  YFSignUpAttendanceModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpAttendanceModel.h"

#import "YFSignUpAttendanceCell.h"

static NSString *yFSignUpAttendanceCell = @"YFSignUpAttendanceCell";


@implementation YFSignUpAttendanceModel
{
    NSMutableArray *_viewArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cellSetting];
    }
    return self;
}

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        [self cellSetting];
    }
    return self;
}

- (void)cellSetting
{
    _viewArray = [NSMutableArray array];
    self.cellIdentifier = yFSignUpAttendanceCell;
    self.cellClass = [YFSignUpAttendanceCell class];
    self.cellHeight = Width(296) + 78;

}

- (void)setCell:(YFSignUpAttendanceCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.titleDesName.length)
    {
        baseCell.attendanceDesLabel.text = self.titleDesName;
    }
}


- (void)bindCell:(YFSignUpAttendanceCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    
    [_viewArray removeAllObjects];// 四种 Frame，
    
    if (self.days.count)
    {
        [baseCell.attenView setMidNum:self.days.count RankInCoun:self.days.rank_country rankInGym:self.days.rank_gym];
        baseCell.attenView.hidden = NO;
        
        
        [_viewArray addObject:baseCell.attenView];
    }
    else
    {
        baseCell.attenView.hidden = YES;

    }

    if (self.checkin.count)
    {
        [baseCell.checkinView setMidNum:self.checkin.count RankInCoun:self.checkin.rank_country rankInGym:self.checkin.rank_gym];
        baseCell.checkinView.hidden = NO;
        
        
        [_viewArray addObject:baseCell.checkinView];
    }else
    {
        baseCell.checkinView.hidden = YES;
    }
    if (self.group_course.count)
    {
        [baseCell.groupView setMidNum:self.group_course.count RankInCoun:self.group_course.rank_country rankInGym:self.group_course.rank_gym];
        
        baseCell.groupView.hidden = NO;
        
        [_viewArray addObject:baseCell.groupView];

    }else
    {
        baseCell.groupView.hidden = YES;
    }
    
    if (self.private_course.count)
    {
        [baseCell.privateView setMidNum:self.private_course.count RankInCoun:self.private_course.rank_country rankInGym:self.private_course.rank_gym];
        baseCell.privateView.hidden = NO;
        
        [_viewArray addObject:baseCell.privateView];
    }else
    {
        baseCell.privateView.hidden = YES;
    }
    
    if (_viewArray.count <= 2)
    {
        self.cellHeight = Width(148) + 78;
    }else
    {
        self.cellHeight = Width(296) + 78;
    }
    
    
    // 设置 Frame
    
    if (_viewArray.count == 1)
    {
        UIView *firstView = _viewArray.firstObject;
        
        firstView.frame = CGRectMake(MSW / 4.0 , 78, MSW / 2.0, Width(122));
    }
    else if (_viewArray.count == 2)
    {
        UIView *firstView = _viewArray.firstObject;
        UIView *secondView = _viewArray[1];

        firstView.frame = CGRectMake(0 , 78, MSW / 2.0, Width(122));
        secondView.frame = CGRectMake(MSW / 2.0 , 78, MSW / 2.0, Width(122));
    }
    else if (_viewArray.count == 3)
    {
        UIView *firstView = _viewArray.firstObject;
        UIView *secondView = _viewArray[1];
        UIView *thirdView = _viewArray[2];
        
        firstView.frame = CGRectMake(MSW / 4.0 , 78, MSW / 2.0, Width(122));
        secondView.frame = CGRectMake(0 , firstView.bottom + Width(24), MSW / 2.0, Width(122));
        thirdView.frame = CGRectMake(MSW / 2.0 , secondView.top, MSW / 2.0, Width(122));

    }

    else if (_viewArray.count == 4)
    {
        UIView *firstView = _viewArray.firstObject;
        UIView *secondView = _viewArray[1];
        UIView *thirdView = _viewArray[2];
        UIView *fourView = _viewArray[3];
        
        firstView.frame = CGRectMake(0 , 78, MSW / 2.0, Width(122));
        
        secondView.frame = CGRectMake(MSW / 2.0 , 78, MSW / 2.0, Width(122));
        
        thirdView.frame = CGRectMake(0 , firstView.bottom + Width(24), MSW / 2.0, Width(122));
        fourView.frame = CGRectMake(MSW / 2.0 , thirdView.top, MSW / 2.0, Width(122));

    }else
    {
        self.cellHeight = 0.0;
    }
    
    
}

- (CGRect)nextFrameFromFrame:(CGRect)frame
{
    if (frame.size.height == 0)
    {
        return CGRectMake(0, 78, MSW / 2.0, Width(122));
    }else if(frame.origin.x == 0)
    {
        return CGRectMake(MSW/2.0, frame.origin.y, MSW / 2.0, Width(122));
    }else
    {
        return CGRectMake(0, frame.origin.y + Width(122) + Width(24), MSW / 2.0, Width(122));
    }
}


@end
