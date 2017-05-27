//
//  YFSignUpAttendanceCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpAttendanceBaseCell.h"

#import "YFAttendanceRankView.h"

@interface YFSignUpAttendanceCell : YFSignUpAttendanceBaseCell

@property(nonatomic, strong)YFAttendanceRankView *attenView;

@property(nonatomic, strong)YFAttendanceRankView *checkinView;

@property(nonatomic, strong)YFAttendanceRankView *groupView;

@property(nonatomic, strong)YFAttendanceRankView *privateView;

@end
