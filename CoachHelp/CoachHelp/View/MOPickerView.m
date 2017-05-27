//
//  MOPickerView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOPickerView.h"

@interface MOPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation MOPickerView

-(void)setTitleArray:(NSArray *)titleArray
{
    
    _titleArray = titleArray;
    
    self.dataSource = self;
    
    self.delegate = self;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return _titleArray.count;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 27)];
    
    label.backgroundColor = _labelColor;
    
    label.text = _titleArray[row];
    
    label.textColor = UIColorFromRGB(0x333333);
    
    label.font = STFont(14);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _currentRow = row;

    if ([self.pickerDelegate respondsToSelector:@selector(pickerView:didSelectRow:)]) {
        
        [self.pickerDelegate pickerView:self didSelectRow:row];
        
    }
    
}

-(void)setCurrentRow:(NSInteger)currentRow
{
    
    _currentRow = currentRow;
    
    [self selectRow:currentRow inComponent:0 animated:YES];
    
}

@end
