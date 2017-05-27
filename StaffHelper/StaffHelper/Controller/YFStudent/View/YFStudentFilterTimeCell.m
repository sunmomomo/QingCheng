//
//  YFStudentFilterTimeCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterTimeCell.h"
#import "YFAppConfig.h"
#import "YFDateService.h"

#define YFCellBeginGap XFrom6YF(14.0)

#define YFCellTextFBeginGap XFrom6YF(30)

#import "YFStudentFilterStateCell.h"

@interface YFStudentFilterTimeCell ()<UITextFieldDelegate>

@end

@implementation YFStudentFilterTimeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.timeStateDesLabel];
        [self.contentView addSubview:self.startTimeTF];
        [self.contentView addSubview:self.endTimeTF];
        
        self.startTimeTF.inputView = self.startKV;
        self.endTimeTF.inputView = self.endKV;
        
        
        CGFloat lineWidth = XFrom6YF(10.0);
        
        CGFloat xxx = MSW * StudentRightShowScale / 2.0 - lineWidth / 2.0;
        
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(xxx, self.startTimeTF.top + self.startTimeTF.height / 2.0 - 0.5, lineWidth, 1.5)];
        lineView1.backgroundColor = YFLineViewColor;
        [self.contentView addSubview:lineView1];
        
        [self.contentView addSubview:self.inputView];
        
        
        
        
        
        
        NSArray *titleArray = @[@"今日",@"最近7天",@"最近30天"];
        
        CGFloat buttonWidth = (MSW * StudentRightShowScale - (YFCellBeginGap + YFCellButtonsGap) *2) / 3.0;
        
        for (NSUInteger i = 0; i < 3; i ++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(YFCellBeginGap + (buttonWidth + YFCellButtonsGap) * i, self.startTimeTF.bottom + 8, buttonWidth, XFrom6YF(30));
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:YFCellTitleColor forState:UIControlStateNormal];
            
            [button setTitleColor:YFSelectedButtonColor forState:UIControlStateSelected
             ];
            [button setBackgroundColor:YFCellButtonBaColor];
            button.layer.cornerRadius = 3.0f;
            button.clipsToBounds = YES;
            [button.titleLabel setFont:FontSizeFY(XFrom5YF(12.0))];
            [button setImage:[UIImage imageNamed:@"FillCond"] forState:UIControlStateSelected];
            
            if (i == 0)
            {
                self.todayButton = button;
            }else if (i == 1){
                self.sevenDayButton = button;
            }else
            {
                self.thirtyDayButton = button;
            }
        }
        
        [self.contentView addSubview:self.todayButton];
        [self.contentView addSubview:self.sevenDayButton];
        [self.contentView addSubview:self.thirtyDayButton];

        
        
    }
    return self;
}


-(UILabel *)timeStateDesLabel
{
    if (!_timeStateDesLabel)
    {
        _timeStateDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(YFCellBeginGap, XFrom6YF(23.0), 80, XFrom6YF(15.0))];
        _timeStateDesLabel.font = FontSizeFY(XFrom6YF(15.0));
        _timeStateDesLabel.textColor = YFCellTitleColor;
        _timeStateDesLabel.text = @"注册日期";
    }
    return _timeStateDesLabel;
}


- (UITextField *)startTimeTF
{
    if (!_startTimeTF)
    {
        CGFloat width = (MSW * StudentRightShowScale - (YFCellBeginGap  + 15) *2) / 2.0;
        
        
        _startTimeTF = [[UITextField alloc]initWithFrame:CGRectMake(YFCellBeginGap, self.timeStateDesLabel.bottom + 8, width, XFrom6YF(31.0))];
        _startTimeTF.placeholder = @"开始日期";
        
        [self setTextFieldSetting:_startTimeTF];
    }
    return _startTimeTF;
}

- (UITextField *)endTimeTF
{
    if (!_endTimeTF)
    {
        CGFloat width = (MSW * StudentRightShowScale - (YFCellBeginGap) *2 - YFCellTextFBeginGap) / 2.0;
        
        _endTimeTF = [[UITextField alloc]initWithFrame:CGRectMake(YFCellBeginGap + width + YFCellTextFBeginGap, self.timeStateDesLabel.bottom + 8, width, XFrom6YF(31.0))];
        
        _endTimeTF.placeholder = @"结束日期";
        
        [self setTextFieldSetting:_endTimeTF];
    }
    return _endTimeTF;
}


- (void)setTextFieldSetting:(UITextField *)textfield
{
    textfield.textColor = YFCellTitleColor;
    //        _startTimeTF.text = self.filter.startDate.length?self.filter.startDate:[df stringFromDate:[NSDate date]];
    
    textfield.delegate = self;
    
    textfield.backgroundColor = RGB_YF(244, 244, 244);
    textfield.textAlignment = NSTextAlignmentCenter;
    textfield.font = FontSizeFY(12.0);
    
    textfield.layer.cornerRadius = 4.0f;
    textfield.clipsToBounds = YES;
}


- (QCKeyboardView *)startKV
{
    if (!_startKV)
    {
        _startKV = [QCKeyboardView defaultKeboardView];
        
        _startKV.keyboard = self.startDP;
    }
    return _startKV;
}

-(UIDatePicker *)startDP
{
    if (!_startDP)
    {
        _startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        _startDP.datePickerMode = UIDatePickerModeDate;
    }
    return _startDP;
}

- (QCKeyboardView *)endKV
{
    if (!_endKV)
    {
        _endKV = [QCKeyboardView defaultKeboardView];
        
        _endKV.keyboard = self.endDP;
    }
    return _endKV;
}

-(UIDatePicker *)endDP
{
    if (!_endDP)
    {
        _endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        _endDP.datePickerMode = UIDatePickerModeDate;
    }
    return _endDP;
}

- (PTXDatePickerView *)startMonthDatePickerView
{
    if (_startMonthDatePickerView == nil)
    {
        _startMonthDatePickerView = [[PTXDatePickerView alloc]initWithFrame:CGRectMake(0, 0, MSW, 246.0)];
        _startMonthDatePickerView.datePickerViewShowModel = PTXDatePickerViewShowModelMonthDay;
    }
    return _startMonthDatePickerView;
}

- (PTXDatePickerView *)endMonthDatePickerView
{
    if (_endMonthDatePickerView == nil)
    {
        _endMonthDatePickerView = [[PTXDatePickerView alloc]initWithFrame:CGRectMake(0, 0, MSW, 246.0)];
        _endMonthDatePickerView.datePickerViewShowModel = PTXDatePickerViewShowModelMonthDay;
        
    }
    return _endMonthDatePickerView;
}


@end


