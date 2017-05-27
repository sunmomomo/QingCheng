//
//  YFHomeLineChartView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFHomeLineChartView.h"

#import "MOCycleView.h"

#import "YFCharView.h"
#import "YFAppConfig.h"
#import "YFStaticsModel.h"
#import "YFHomeLineChartModel.h"
#import "YFDateService.h"

#define YFTopClickHeight Height320(34)

@interface YFHomeLineChartView ()<MOCycleViewDatasource,MOCycleViewDelegate>

@property(nonatomic,strong)NSMutableArray *chartViewArray;

@property(nonatomic,strong)MOCycleView *cycleView;


@end


@implementation YFHomeLineChartView
{
    NSMutableArray *_dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self chartViewArray];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)detailAction:(UIButton *)button
{
    
    [self.delegate chartViewDidClickIndex:button.tag];
    
}

- (NSMutableArray *)chartViewArray
{
    if (!_chartViewArray)
    {
        _chartViewArray = [NSMutableArray array];
        
//        [_lineViewArray addObject:[self creatChartView]];
//        [_lineViewArray addObject:[self creatChartView]];
//        [_lineViewArray addObject:[self creatChartView]];
//        [_lineViewArray addObject:[self creatChartView]];
    }
    return _chartViewArray;
}
#pragma mark Custom Method
-(void)bindDataArray:(NSMutableArray *)dataArray
{
    if ([_dataArray isEqual:dataArray] == YES) {
        return;
    }
    _dataArray = dataArray;
    [_chartViewArray removeAllObjects];
    
    for (YFHomeLineChartModel *model in dataArray)
    {
        if ([model isKindOfClass:[YFHomeLineChartModel class]])
        {
            UIView *charView = [self creatChartViewWithModel:model atIndex:[dataArray indexOfObject:model]];
            
            [_chartViewArray addObject:charView];
        }
    }
    if (!_cycleView)
    {
        
        _cycleView = [[MOCycleView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.height)];
        _cycleView.shouldAutoScroll = NO;
        _cycleView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _cycleView.height - Height320(30), _cycleView.width, OnePX)];
        lineView.backgroundColor = YFLineViewColor;
        [_cycleView addSubview:lineView];
        [self addSubview:_cycleView];
    }
    if (_dataArray)
    {
        _cycleView.delegate = self;

        _cycleView.datasource = self;
        
        [_cycleView reload];

    }
    
}

#pragma mark Getter
- (UIView *)creatChartViewWithModel:(YFHomeLineChartModel *)model atIndex:(NSInteger)index
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.height)];
    
    UIButton *sellerView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, YFTopClickHeight)];
    
    sellerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    sellerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    sellerView.layer.borderWidth = OnePX;
    
    sellerView.tag = index;
    
    [view addSubview:sellerView];
    
    UILabel *sellerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, Width320(80), YFTopClickHeight)];
    
    sellerTitleLabel.text = model.chartDesStr;
    
    sellerTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    sellerTitleLabel.font = AllFont(13);
    
    [sellerView addSubview:sellerTitleLabel];
    
    UILabel *sellersLabel = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitleLabel.right, 0, MSW-Width320(29)-sellerTitleLabel.right, YFTopClickHeight)];
    
    sellersLabel.textColor = UIColorFromRGB(0x999999);
    
    sellersLabel.font = AllFont(13);
    
    sellersLabel.textAlignment = NSTextAlignmentRight;
    
    sellersLabel.text = @"详情";
    
    [sellerView addSubview:sellersLabel];
    
    [sellerView addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sellerArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), sellerView.height/2-6, Width320(7), 12)];
    
    sellerArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [sellerView addSubview:sellerArrow];
    
    YFCharView  *_chartView = [[YFCharView alloc] initWithFrame:CGRectMake(Width320(12), sellerView.bottom+Height320(14), MSW-Width320(12), view.height - sellerView.height)];
    
    _chartView.xxHeight = Height320(113);
    
    _chartView.desLabel.hidden = YES;
    _chartView.valueLabel.hidden = YES;
    _chartView.defaultColor = model.defaultColor;
    _chartView.xxGap = 40;
    
//    NSMutableArray *dateArray = [NSMutableArray array];
//    for (NSInteger i = 6; i >= 0; i --)
//    {
//        NSString *string = [YFDateService getDateFromDays:-i formating:nil];
//        [dateArray addObject:string];
//    }

    _chartView.staticModel = model.chartStaticModel;
    [_chartView drawChartLayer];
    
    [view addSubview:_chartView];
    
    return view;
}

#pragma mark MOCycleViewDelegate
- (NSInteger)numberOfPageWithView:(MOCycleView *)cView
{
    return self.chartViewArray.count;
}

- (UIView *)pageAtCView:(MOCycleView *)cView AtIndex:(NSInteger)index
{
    if (self.chartViewArray.count <= index)
    {
        return nil;
    }

    return self.chartViewArray[index];
}

- (void)didSelectImage:(MOCycleView *)cView AtIndex:(NSInteger)index
{
    
}

- (CGRect)setPageControlWithView:(MOCycleView *)cView
{
    return CGRectMake(0, cView.height - Height320(30), self.width, Height320(30));
}
- (UIColor *)setPageControlColorWithView:(MOCycleView *)cView
{
    return kMainColor;
}

- (UIColor *)setPageControlBackColorWithView:(MOCycleView *)cView
{
    return RGB_YF(200, 200, 200);
}
- (UIColor *)setPageControlBackGroundColorWithView:(MOCycleView *)cView
{
    return [UIColor clearColor];
}

@end
