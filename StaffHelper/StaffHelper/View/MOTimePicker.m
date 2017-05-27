//
//  MOTimePicker.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/22.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOTimePicker.h"

@interface MOTimePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>

{
    
    NSMutableArray *_hourArray;
    
    NSMutableArray *_minuteArray;
    
}

@end

@implementation MOTimePicker

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _hourArray = [NSMutableArray array];
        
        _minuteArray = [NSMutableArray array];
        
        self.hour = @"00";
        
        self.minute = @"00";
        
        for (NSInteger i = 0 ; i<24; i++) {
            
            NSString *str = [NSString stringWithFormat:i<10?@"0%ld":@"%ld",(long)i];
            
            [_hourArray addObject:str];
            
        }
        
        for (NSInteger i = 0; i<60; i++) {
            
            NSString *str = [NSString stringWithFormat:i<10?@"0%ld":@"%ld",(long)i];
            
            [_minuteArray addObject:str];
            
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(20), Height320(20))];
        
        label.font = STFont(18);
        
        label.textColor = UIColorFromRGB(0x222222);
        
        label.text = @":";
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.center = CGPointMake(self.width/2, self.height/2);
        
        [self addSubview:label];
        
        self.dataSource = self;
        
        self.delegate = self;
        
    }
    
    return self;
    
}

-(void)setTimeGap:(NSInteger)timeGap
{
    
    _timeGap = timeGap;
    
    _minuteArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i<(60/timeGap); i++) {
        
        NSString *str = [NSString stringWithFormat:i*_timeGap<10?@"0%ld":@"%ld",(long)i*_timeGap];
        
        [_minuteArray addObject:str];
        
    }
    
    self.dataSource = self;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return _hourArray.count;
        
    }else
    {
        
        return _minuteArray.count;
        
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 2;
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return _hourArray[row];
        
    }else
    {
        
        return _minuteArray[row];
        
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        if (_hourArray.count) {
            
            self.hour = _hourArray[row];
            
        }
        
    }else
    {
        
        if (_minuteArray.count) {
            
            self.minute = _minuteArray[row];
            
        }
        
    }
    
}

-(void)setHour:(NSString *)hour
{
    
    _hour = hour;
    
    NSInteger index = 0;
    
    for (NSString *hourStr in _hourArray) {
        
        if ([_hour isEqualToString:hourStr]) {
            
            index = [_hourArray indexOfObject:hourStr];
            
        }
        
    }
    
    _time = [NSString stringWithFormat:@"%@:%@",_hour,_minute];
    
    [self selectRow:index inComponent:0 animated:NO];
    
}

-(void)setMinute:(NSString *)minute
{
    
    _minute = minute;
    
    NSInteger index = 0;
    
    for (NSString *minuteStr in _minuteArray) {
        
        if ([_minute isEqualToString:minuteStr]) {
            
            index = [_minuteArray indexOfObject:minuteStr];
            
        }
        
    }
    
    _time = [NSString stringWithFormat:@"%@:%@",_hour,_minute];
    
    [self selectRow:index inComponent:1 animated:NO];
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _hour = [[_time componentsSeparatedByString:@":"]firstObject];
    
    _minute = [[_time componentsSeparatedByString:@":"] lastObject];
    
    self.hour = _hour;
    
    self.minute = _minute;
    
}

-(void)reload
{

    [self selectRow:0 inComponent:0 animated:NO];
    
    [self selectRow:0 inComponent:1 animated:NO];
    
    [self pickerView:self didSelectRow:0 inComponent:0];
    
    [self pickerView:self didSelectRow:0 inComponent:1];
    
}

@end
