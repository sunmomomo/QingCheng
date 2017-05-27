//
//  DistrictPickerView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "DistrictPickerView.h"

@interface DistrictPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

{
    
    NSInteger _provinceNum;
    
    NSInteger _cityNum;
    
    NSInteger _districtNum;
    
    UIPickerView *_pickerView;
    
    DistrictInfo *_districtInfo;
    
}

@end

@implementation DistrictPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _pickerView.dataSource = self;
        
        _pickerView.delegate = self;
        
        [self addSubview:_pickerView];
        
        _districtInfo = [DistrictInfo sharedDistrictInfo];
        
        District *district = ((City*)((Province*)_districtInfo.provinces[0]).cities[0]).districts[0];
        
        _district = district.name;
        
        _districtCode = district.districtCode;
        
    }
    return self;
}

+(instancetype)defaultPickerView
{
    
    DistrictPickerView *dpv = [[DistrictPickerView alloc]initWithFrame:CGRectMake(0, 0, MSW, 177)];
    
    return dpv;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return _districtInfo.provinces.count;
        
    }else if(component == 1)
    {
        
        Province *province = _districtInfo.provinces[_provinceNum];
        
        return province.cities.count;
        
    }else
    {
        
        City *city = ((Province*)_districtInfo.provinces[_provinceNum]).cities[_cityNum];
        
        if (_cityNum>=((Province*)_districtInfo.provinces[_provinceNum]).cities.count) {
            
            _cityNum = ((Province*)_districtInfo.provinces[_provinceNum]).cities.count-1;
            
        }
        
        return city.districts.count;
        
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        Province *province = _districtInfo.provinces[row];
        
        return province.name;
        
    }else if(component == 1)
    {
        
        City *city = ((Province*)_districtInfo.provinces[_provinceNum]).cities[row];
        
        return city.name;
        
    }else
    {
        
        District *district = ((City*)((Province*)_districtInfo.provinces[_provinceNum]).cities[_cityNum]).districts[row];
        
        return district.name;
        
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        _provinceNum = row;
        
        Province *province = _districtInfo.provinces[_provinceNum];
        
        if (_cityNum>=province.cities.count) {
            
            _cityNum = province.cities.count-1;
            
        }
        
        City *city = province.cities[_cityNum];
        
        if (_districtNum >= city.districts.count) {
            
            _districtNum = city.districts.count-1;
            
        }
        
        [_pickerView reloadAllComponents];
        
    }else if (component == 1){
        
        Province *province = _districtInfo.provinces[_provinceNum];
        
        City *city = province.cities[_cityNum];
        
        if (_districtNum>= city.districts.count) {
            
            _districtNum = city.districts.count-1;
            
        }
        
        _cityNum = row;
        
        [_pickerView reloadAllComponents];
        
    }else
    {
        
        _districtNum = row;
        
    }
    
    District *district = ((City*)((Province*)_districtInfo.provinces[_provinceNum]).cities[_cityNum]).districts[_districtNum];
    
    _districtCode = district.districtCode;
    
    _district = [DistrictInfo nameForDistrictCode:_districtCode];
    
}

-(void)setDistrictCode:(NSString *)districtCode
{
    
    _districtCode = districtCode;
    
    for (Province *province in _districtInfo.provinces) {
        
        for (City *city in province.cities) {
            
            for (District *district in city.districts) {
                
                if ([district.districtCode isEqualToString:_districtCode]) {
                    
                    [_pickerView selectRow:[_districtInfo.provinces indexOfObject:province] inComponent:0 animated:NO];
                    
                    [_pickerView selectRow:[province.cities indexOfObject:city] inComponent:1 animated:NO];
                    
                    [_pickerView selectRow:[city.districts indexOfObject:district] inComponent:2 animated:NO];
                    
                    [self pickerView:_pickerView didSelectRow:[_districtInfo.provinces indexOfObject:province] inComponent:0];
                    
                    [self pickerView:_pickerView didSelectRow:[province.cities indexOfObject:city] inComponent:1];
                    
                    [self pickerView:_pickerView didSelectRow:[city.districts indexOfObject:district] inComponent:2];
                    
                }
                
            }
            
        }
        
    }
    
}

@end
