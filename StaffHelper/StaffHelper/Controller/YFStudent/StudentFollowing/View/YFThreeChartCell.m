//
//  YFThreeChartCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFThreeChartCell.h"


#import "YFThreeChartModel.h"
#define YFChartHeight 232.0

@interface YFThreeChartCell ()<UIScrollViewDelegate>


@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UIPageControl *pageControl;


@end

@implementation YFThreeChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MSW, YFChartHeight + 20)];
        _scrollView.backgroundColor = [UIColor whiteColor];

        _scrollView.delegate = self;
        // 设置内容大小
        _scrollView.contentSize = CGSizeMake(MSW * 3, YFChartHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];
        
        [self.scrollView addSubview:self.charFirstView];
        [self.scrollView addSubview:self.charSecondView];
        [self.scrollView addSubview:self.charThreeView];
        
        
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.bottom - 0.5, MSW, 0.5)];
        linView.backgroundColor = YFLineViewColor;
        [self.contentView addSubview:linView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,self.scrollView.bottom, _scrollView.width - IPhone4_5_6_6P(0, 0, 50, 85), YFYFThreeChartCellHeight - self.scrollView.bottom)];
        
        _pageControl.numberOfPages = 3;
    
        _pageControl.pageIndicatorTintColor = RGB_YF(221, 221, 221);
        _pageControl.currentPageIndicatorTintColor = RGB_YF(11, 177, 75);
        _pageControl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_pageControl];

        
    }
    return self;
}


- (YFCharView *)charFirstView
{
    if (!_charFirstView)
    {
//        // 创建实例数据2，随机数
//      NSMutableDictionary *_dic1 = [[NSMutableDictionary alloc] init];
//        for (int i=1; i<=7; i++) {
//            int y = (arc4random() % 10) + 20;
//            [_dic1 setObject:[NSString stringWithFormat:@"%d", y*y]  forKey:[NSString stringWithFormat:@"%d", i]];
//        }
        // 创建绘图组件
    YFCharView  *_chartView = [[YFCharView alloc] initWithFrame:CGRectMake(0, 20, MSW, YFChartHeight)];

    _chartView.desLabel.text = @"最近7天新增注册共计";
    _chartView.valueLabel.text = @"98";
    _chartView.defaultColor = YFFirstChartDeColor;
    _charFirstView = _chartView;
    }
    return _charFirstView;
}

- (YFCharView *)charSecondView
{
    if (!_charSecondView)
    {

        // 创建绘图组件
        YFCharView  *_chartView = [[YFCharView alloc] initWithFrame:CGRectMake(MSW, 20, MSW, YFChartHeight)];
        _chartView.defaultColor = YFSecondChartDeColor;
        _chartView.desLabel.text = @"最近7天跟进会员共计";
        _chartView.valueLabel.text = @"98";
        _charSecondView = _chartView;
        }
    return _charSecondView;
}

- (YFCharView *)charThreeView
{
    if (!_charThreeView)
    {
//        // 创建实例数据2，随机数
//        NSMutableDictionary *_dic1 = [[NSMutableDictionary alloc] init];
//        for (int i=1; i<=7; i++) {
//            int y = (arc4random() % 10) + 20;
//            [_dic1 setObject:[NSString stringWithFormat:@"%d", y*y]  forKey:[NSString stringWithFormat:@"%d", i]];
//        }
        // 创建绘图组件
        YFCharView  *_chartView = [[YFCharView alloc] initWithFrame:CGRectMake(MSW * 2, 20, MSW, YFChartHeight) ];
        _chartView.defaultColor = YFThreeChartDeColor;
        _chartView.desLabel.text = @"最近7天新增会员共计";
        _chartView.valueLabel.text = @"98";
        _charThreeView = _chartView;
    }
    return _charThreeView;
}





-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setPataCurrentYF];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        [self setPataCurrentYF];
    }
}

-(void)setPataCurrentYF
{
    _pageControl.currentPage = (NSInteger)self.scrollView.contentOffset.x / (NSInteger)self.scrollView.width;
}

@end
