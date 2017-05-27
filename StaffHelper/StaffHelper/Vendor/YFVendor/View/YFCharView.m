//
//  YFCharView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFCharView.h"
#import "YFAppConfig.h"
#import "YFStaticsSubModel.h"


#define YFLabelYY 198.0

@interface YFCharView ()<CYChartViewDelegate>

@end

@implementation YFCharView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _totalCount = 7;
        _maxValue = 0;
        _minValue = 0;
        _selelctIndex = 7;
        _xxGap = 50;
        _xxHeight = 160;
        self.isCanTapToSelect = YES;
        [self addSubview:self.desLabel];
        [self addSubview:self.valueLabel];
        
    }
    return self;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, YFLabelYY, MSW - 61 - 10, 15.5)];
        _desLabel.font = FontSizeFY(15.0);
        _desLabel.textAlignment = NSTextAlignmentRight;
        
        _desLabel.textColor  = [UIColor blackColor];
    }
    return _desLabel;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.desLabel.right, self.desLabel.bottom - 22.0 + 2, 42.0, 22)];
        _valueLabel.font = FontSizeFY(21.5);
        _valueLabel.textColor  = RGB_YF(113, 185, 240);
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLabel;
}

- (CYChartView *)charView
{
    if (!_charView)
    {
        // 创建实例数据2，随机数
        //        _dic = [[NSMutableDictionary alloc] init];
        //        for (int i=1; i<=7; i++) {
        //            int y = (arc4random() % 10) + 20;
        //            [_dic setObject:[NSString stringWithFormat:@"%@", @(y*y)]  forKey:[NSString stringWithFormat:@"%@", @(i)]];
        //
        //
        //            if (y*y>_maxValue) {
        //                _maxValue = y*y;
        //            }
        //            if (y*y<_minValue) {
        //                _minValue = y*y;
        //            }
        //
        //        }
        
        
        
        CGFloat xxGap = self.xxGap;
        
        // 创建绘图组件
        CYChartView  *chartView = [[CYChartView alloc] initWithFrame:CGRectMake(xxGap, 0, self.frame.size.width - xxGap, _xxHeight) withBeginAfterGap:10.0];
        
        chartView.xxExtionGap =self.xxExtionGap;
        chartView.xxBackExtionGap =self.xxBackExtionGap;
        chartView.backgroundColor = [UIColor clearColor];
        chartView.delegate = self; // 指定代理
        chartView.chartType = @"line"; // 图形类型为折线or圆柱
        chartView.needReferenceLine = NO; // 是否开启最大、最小值参考线
        chartView.defaultColor = self.defaultColor;
        chartView.isCanTapToSelect = self.isCanTapToSelect;
        _charView = chartView;
    }
    return _charView;
}



#pragma CYChartViewDelegate

/**
 *  本实例有两组图形数据
 *
 *  @return 图形组数
 */
- (NSInteger)numberOfChartGroup{
    return 1; // 暂时只显示一组吧，另一组隐藏了
}

/**
 *  设置图形属性
 *
 *  @param chartView 绘图组件对象
 *  @param group     图形是第几组的索引
 *
 *  @return 图形属性对象
 */
- (CYGraphAttribute *)chartView:(CYChartView *)chartView graphAttributeForGroup:(NSInteger)group
{
    CYGraphAttribute* model = [[CYGraphAttribute alloc] init];
    model.maxValue = _maxValue; // 用于计算y轴最大值
    model.minValue = _minValue;
    model.pointsCount = _totalCount; // 用于计算x轴各点的间距
    
    if (group == 1) { // 设置第二组图形颜色为蓝色，第一组的group值为0，颜色默认为浅绿色
        model.graphColor = [UIColor colorWithRed:30.0/255.0f green:176.0/255.0f blue:255.0/255.0f alpha:1.0f];
    }
    return model;
}

/**
 *  设置在第几组图形中，第几个点的属性
 *
 *  @param chartView  组件对象
 *  @param pointIndex 点的位置索引
 *  @param chartGroup 图形组的索引
 *
 *  @return 点对象
 */
- (CYPoint*)chartView:(CYChartView *)chartView pointIndex:(NSInteger)pointIndex chartGroup:(NSInteger)chartGroup
{
    CYPoint* point = [[CYPoint alloc] initWithX:0 andY:0];
    
    // x/yvalue为真实值，会被用来转换计算坐标值；x/ylabeltext用于显示x/y轴和选中点后的提示层文字
    point.xValue = [NSString stringWithFormat:@"%@", @(pointIndex+1)];
    if (chartGroup == 1) {
        point.yValue = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
        point.xLabelText = [NSString stringWithFormat:@"%@", @(pointIndex+1)];
        point.yLabelText = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
        
        if (chartGroup==1) {
            point.xValue = [NSString stringWithFormat:@"%@", @(pointIndex+1+20)];
            point.yValue = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
            point.xLabelText = [NSString stringWithFormat:@"%@", @(pointIndex+1)];
            point.yLabelText = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
        }
    }else{
        
        YFStaticsSubModel *model = [_staticModel.arrayModels objectAtIndex:pointIndex];
        
        point.yValue = model.countValue;
        
        point.xValue = model.date;
       
        point.xLabelText = model.monthDay;

        
        point.yLabelText = [NSString stringWithFormat:@"%@%@",model.count,self.ylabelUnit];
        
        //        point.yValue = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
        //        point.xLabelText = [NSString stringWithFormat:@"%@", @(pointIndex+1)];
        //        point.yLabelText = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
        //        point.xLabelText = [NSString stringWithFormat:@"%@", @"2012-03-12"];
        
        if (chartGroup==1) {
            point.xValue = [NSString stringWithFormat:@"%@", @(pointIndex+1+20)];
            point.yValue = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
            point.xLabelText = [NSString stringWithFormat:@"%@", @(pointIndex+1)];
            point.yLabelText = [_dic objectForKey:[NSString stringWithFormat:@"%@", @(pointIndex+1)]];
        }
    }
    return point;
}

- (void)drawChartLayer
{
    [self addSubview:self.charView];
    
    [self.charView drawChartLayer];
    
    [self.charView setSelectButtonAtIndex:_selelctIndex];
}

- (void)setDefaultColor:(UIColor *)defaultColor
{
    _defaultColor = defaultColor;
    
    self.valueLabel.textColor = defaultColor;
}


-(void)setStaticModel:(YFStaticsModel *)staticModel
{
    if ([staticModel isEqual:_staticModel])
    {
        return;
    }
    _staticModel = staticModel;
    _totalCount = staticModel.arrayModels.count;
    _maxValue = staticModel.maxValue;
    _minValue = staticModel.minValue;
    if (staticModel.count) {
        self.valueLabel.text = [NSString stringWithFormat:@"%@",staticModel.count];
    }
    
    [self drawChartLayer];
    
    self.beginSelelctOffsetIndex = self.charView.beginSelelctOffsetIndex;
}

- (void)setXXOffsetToPromtView:(CGFloat)xx scrollView:(UIScrollView *)scrollView
{
    [self.charView setXXOffsetToPromtView:xx scrollView:scrollView];
}

- (NSString *)ylabelUnit
{
    if (!_ylabelUnit) {
        _ylabelUnit = @"";
    }
    return _ylabelUnit;
}

@end
