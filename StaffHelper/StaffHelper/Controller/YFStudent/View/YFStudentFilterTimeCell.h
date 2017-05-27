//
//  YFStudentFilterTimeCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "QCKeyboardView.h"

#import "PTXDatePickerView.h"

@interface YFStudentFilterTimeCell : YFBaseCell

@property(nonatomic,strong)UILabel *timeStateDesLabel;

@property(nonatomic,strong)UITextField *startTimeTF;

@property(nonatomic,strong)UITextField *endTimeTF;

@property(nonatomic,strong)QCKeyboardView *startKV;
@property(nonatomic,strong)QCKeyboardView *endKV;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property (nonatomic, strong) PTXDatePickerView *startMonthDatePickerView;

@property (nonatomic, strong) PTXDatePickerView *endMonthDatePickerView;

@property(nonatomic,strong)UIButton *todayButton;
@property(nonatomic,strong)UIButton *sevenDayButton;
@property(nonatomic,strong)UIButton *thirtyDayButton;

@end
