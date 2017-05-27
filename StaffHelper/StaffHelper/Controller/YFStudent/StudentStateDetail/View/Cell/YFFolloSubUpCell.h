//
//  YFFolloSubUpCell.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFCharView.h"

#import "GTWSelectOperationView.h"

@interface YFFolloSubUpCell : YFBaseCell

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UIImageView *stateImageView;
@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)YFCharView *chartView;

@property(nonatomic, strong)UIButton *buttonOfSeller;

@property(nonatomic, strong)UIButton *buttonOfTime;

- (void)creatCharViewWithDateCount:(NSUInteger )count defaultColor:(UIColor *)defaultColor;

-(void)setDefaultView;
- (void)setContentOffsetWithXX:(CGFloat)xx;

@end
