//
//  YFHomeLineChartView.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YFHomeHeaderLineChartHeight Height320(210)

@protocol YFHomeLineChartViewDelegate <NSObject>

-(void)chartViewDidClickIndex:(NSInteger)index;

@end

@interface YFHomeLineChartView : UIView

@property(nonatomic,weak)id<YFHomeLineChartViewDelegate>delegate;

- (void)bindDataArray:(NSMutableArray *)dataArray;

@end
