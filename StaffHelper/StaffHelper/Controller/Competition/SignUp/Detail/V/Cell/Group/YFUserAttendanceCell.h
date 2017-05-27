//
//  YFUserAttendanceCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFThreeLabel.h"

@interface YFUserAttendanceCell : YFBaseCell

@property(nonatomic, strong)YFThreeLabel *rightView;
@property(nonatomic, strong)YFThreeLabel *firstView;
@property(nonatomic, strong)YFThreeLabel *secondView;
@property(nonatomic, strong)YFThreeLabel *thirdView;

@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;

@end
