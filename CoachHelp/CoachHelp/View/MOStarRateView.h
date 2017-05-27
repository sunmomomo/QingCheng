//
//  MOStarRateView.h
//
//
//  Created by 馍馍帝😈 on 15/8/31.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOStarRateView;
@protocol MOStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(MOStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface MOStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--5，默认为5
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property(nonatomic,strong)UIColor *starColor;

@property(nonatomic,assign)BOOL canChange;

@property (nonatomic, weak) id<MOStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
