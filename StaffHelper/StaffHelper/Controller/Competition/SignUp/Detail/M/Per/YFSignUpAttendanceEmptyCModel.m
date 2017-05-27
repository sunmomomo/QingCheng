//
//  YFSignUpAttendanceEmptyCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpAttendanceEmptyCModel.h"

#import "YFSignUpAttendanceEmptyCell.h"

static NSString *yFSignUpAttendanceEmptyCell = @"YFSignUpAttendanceEmptyCell";


@implementation YFSignUpAttendanceEmptyCModel


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

- (void)setCell:(YFSignUpAttendanceEmptyCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.titleDesName.length)
    {
        baseCell.attendanceDesLabel.text = self.titleDesName;
    }
}
- (void)bindCell:(YFSignUpAttendanceEmptyCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if (self.days)
    {
        baseCell.dayLabel.text = [NSString stringWithFormat:@"比赛还未开始，%@天后再来吧",@(self.days)];
    }
}

- (void)cellSetting
{
    self.cellIdentifier = yFSignUpAttendanceEmptyCell;
    self.cellClass = [YFSignUpAttendanceEmptyCell class];
    self.cellHeight = 200;
}


@end
