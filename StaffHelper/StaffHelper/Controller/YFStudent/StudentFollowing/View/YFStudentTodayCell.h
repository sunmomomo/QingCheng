//
//  YFStudentTodayCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFStudentTodayCell : YFBaseCell
@property(nonatomic, strong)UILabel *nameLabel;


@property(nonatomic, strong)UILabel *neRegisLabel;
@property(nonatomic, strong)UILabel *todayFollowLabel;
@property(nonatomic, strong)UILabel *neMemLabel;

@property(nonatomic, copy)void(^buttonActionBlock)(NSUInteger);

@end
