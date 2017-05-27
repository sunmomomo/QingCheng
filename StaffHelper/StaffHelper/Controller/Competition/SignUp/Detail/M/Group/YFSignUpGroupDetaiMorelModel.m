//
//  YFSignUpGroupDetaiMorelModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpGroupDetaiMorelModel.h"

#import "YFSignUpGroupDetaiMorelCell.h"

static NSString *yFSignUpGroupDetaiMorelCell = @"YFSignUpGroupDetaiMorelCell";




@implementation YFSignUpGroupDetaiMorelModel

- (void)cellSettingYF
{
    self.cellIdentifier = yFSignUpGroupDetaiMorelCell;
    self.cellClass = [YFSignUpGroupDetaiMorelCell class];
    self.cellHeight = 50;
}

@end
