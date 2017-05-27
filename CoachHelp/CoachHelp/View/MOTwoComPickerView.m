//
//  MOTwoComPickerView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOTwoComPickerView.h"

@interface MOTwoComPickerView ()<MOPickerViewDelegate>

{
    
    MOPickerView *_firstPV;
    
    MOPickerView *_secondPV;
    
}

@end

@implementation MOTwoComPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _firstPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        
        _firstPV.pickerDelegate = self;
        
        [self addSubview:_firstPV];
        
        _secondPV = [[MOPickerView alloc]initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        
        _secondPV.pickerDelegate = self;
        
        [self addSubview:_secondPV];
        
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray
{
    
    _dataArray = dataArray;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in dataArray) {
        
        [array addObject:dict[@"title"]];
        
    }
    
    _firstPV.titleArray = array;
    
    _secondPV.titleArray = _dataArray[_selectCompoment][@"data"];
    
}

-(void)pickerView:(MOPickerView *)pickerView didSelectRow:(NSInteger)row
{
    
    if (pickerView == _firstPV) {
        
        _selectCompoment = row;
        
        _secondPV.titleArray = _dataArray[_selectCompoment][@"data"];
        
    }else{
        
        _selectRow = row;
        
    }
    
}



@end
