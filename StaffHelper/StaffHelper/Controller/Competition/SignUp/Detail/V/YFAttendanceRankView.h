//
//  YFAttendanceRankView.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFAttendanceRankView : UIView

@property(nonatomic, strong)UILabel *midNumLabel;
@property(nonatomic, strong)UILabel *midNumUnitLabel;
@property(nonatomic, strong)UILabel *rankLabel;

@property(nonatomic, strong)UIColor *mainColor;

- (void)setMidNum:(NSString *)midNum RankInCoun:(NSString *)numInC rankInGym:(NSString *)numInGym;

@end
