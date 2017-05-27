//
//  YFSmsRecipentCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFSmsRecipentCell : YFBaseCell

@property(nonatomic, weak)YFBaseCModel *baseModel;

@property(nonatomic, strong)UILabel *nameDesLabel;

@property(nonatomic, strong)UILabel *nameAllLabel;

@property(nonatomic, strong)UIButton *showDetaiButton;

@property(nonatomic ,strong)NSMutableArray *nameAtriStringArray;

@property(nonatomic, assign)CGFloat showHeight;

- (void)setSubStyle;

@end
