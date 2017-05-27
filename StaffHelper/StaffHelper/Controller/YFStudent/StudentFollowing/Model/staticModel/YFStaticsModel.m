//
//  YFStaticsModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStaticsModel.h"

#import "YFStaticsSubModel.h"
#import "NSObject+YFExtension.h"

#import "NSObject+YFExtension.h"

#import "YYModel.h"

@interface YFStaticsModel ()<YYModel>

@end

@implementation YFStaticsModel

-(instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.count = [self.count guardStringYF];
    }
    return self;
}

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.count = [self.count guardStringYF];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"date_counts"])
    {
        
        
        [self resultArray:value];
    }else
        [super setValue:value forKey:key];
}
- (void)resultArray:(NSArray *)array
{
    _minValue  = 0;
    
    array = [array guardArrayYF];

    
    
    _dateDicForModel = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dic in array)
    {
        YFStaticsSubModel *model = [YFStaticsSubModel defaultWithDic:dic];
        
        //            model.count = @"-3";
        
        model.count = [model.count guardStringYF];
        
        if (model.count.length == 0) {
            model.count = @"0";
        }
        
        if (![model.count isKindOfClass:[NSString class]]) {
            
            model.count = [NSString stringWithFormat:@"%@",model.count];
            
        }
//        model.count  = @"-0.3";
//        model.countValue  = @"-0.3";
        [_dateDicForModel setObject:model forKey:model.date];
        
        if (_maxValue < model.count.floatValue)
        {
            _maxValue = model.count.floatValue;
        }
        
        if (_minValue > model.count.floatValue || _minValue == 0)
        {
            _minValue = model.count.floatValue;
        }
        
        //            [self.arrayModels addObject:model];
        
    }
    // 小数时 转为 比它大的 最小的整数
    _maxValue = ceil(_maxValue);
    // 小数时 转为 比它小的 最小的整数
    _minValue = floor(_minValue);
    
    if (_maxValue - _minValue < 2)
    {
        _maxValue = _minValue + 2;
    }
    
//    _maxValue = 1;
//    _minValue = -1;
}



- (void)fullEmptyArrayWithDateArray:(NSArray *)dateArray
{
    for (NSString *dateStr in dateArray)
    {
        YFStaticsSubModel *model =   [_dateDicForModel objectForKey:dateStr];
        
        if (!model)
        {
            model = [YFStaticsSubModel defaultWithDic:@{@"count":@"0",@"date":dateStr}];
        }
        [self.arrayModels addObject:model];
    }
}

- (NSMutableArray *)arrayModels
{
    if (!_arrayModels)
    {
        _arrayModels = [NSMutableArray array];
    }
    return _arrayModels;
}

@end
