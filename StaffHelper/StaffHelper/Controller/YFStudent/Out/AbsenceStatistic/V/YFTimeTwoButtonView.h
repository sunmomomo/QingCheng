//
//  YFTimeTwoButtonView.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTimeTwoButtonView : UIView

@property(nonatomic ,assign)CGFloat inputWidth;
@property(nonatomic ,assign)CGFloat inputHeight;
@property(nonatomic ,copy)NSString *desName;

@property(nonatomic, strong)UITextField *leftTextField;
@property(nonatomic, strong)UITextField *rightTextField;

@property(nonatomic, strong)UIButton *leftButton;
@property(nonatomic, strong)UIButton *rightButton;

@property(nonatomic, strong)UILabel *desNameLabel;

- (void)creatView;

@end
