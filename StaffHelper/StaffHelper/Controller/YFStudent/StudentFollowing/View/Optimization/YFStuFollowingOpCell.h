//
//  YFStuFollowingOpCell.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFCharView.h"


@interface YFStuFollowingOpCell : YFBaseCell

@property(nonatomic, strong)UILabel *nameLabel;


@property(nonatomic, strong)UILabel *todayCountLabel;
@property(nonatomic, strong)UILabel *sevenCountLabel;
@property(nonatomic, strong)UILabel *thirtyCountLabel;

@property(nonatomic, copy)void(^buttonActionBlock)(NSUInteger);

@property(nonatomic, strong)YFCharView *chartView;

@end
