//
//  MONumberPickerView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MONumberPickerView.h"

@interface MONumberPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSString *_max;
    
    NSString *_min;
    
}

@end

@implementation MONumberPickerView

-(void)setMinNumber:(NSInteger)minNumber
{
    
    _minNumber = minNumber;
    
    _min = [NSString stringWithInteger:_minNumber];
    
    _currentNumber = _minNumber;
    
    if (_min.length && _max.length) {
        
        self.dataSource = self;
        
        self.delegate = self;
        
    }
    
}

-(void)setMaxNumber:(NSInteger)maxNumber
{
    
    _maxNumber = maxNumber;
    
    _max = [NSString stringWithInteger:_maxNumber];
    
    if (_min.length && _max.length) {
        
        self.dataSource = self;
        
        self.delegate = self;
        
    }
    
}

-(void)setCurrentNumber:(NSInteger)currentNumber
{
    
    _currentNumber = currentNumber;
    
    NSInteger index = _currentNumber - _minNumber;
    
    if (index>0 && index<_maxNumber-_minNumber+1) {
        
        [self selectRow:index inComponent:0 animated:NO];
        
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return _maxNumber-_minNumber+1;
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 27)];
    
    label.backgroundColor = _labelColor;
    
    label.text = [NSString stringWithInteger:_minNumber+row];
    
    label.textColor = UIColorFromRGB(0x333333);
    
    label.font = STFont(14);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _currentNumber = _minNumber+row;
    
}

@end
