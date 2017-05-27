//
//  YFAttendanceRankView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAttendanceRankView.h"

#define pi 3.14159265359

#define YF_DEGREES_TO_RADIANS(degress) ((pi * degress)/180)


@implementation YFAttendanceRankView
{
    CGFloat _beginXX;
    CGFloat _LabelWidth;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _beginXX = self.width - self.height + Width(3);
        
        _LabelWidth = self.width - 2 * _beginXX;
        
        
        [self addSubview:self.midNumLabel];
        [self addSubview:self.midNumUnitLabel];
        [self addSubview:self.rankLabel];
        
        [self bringSubviewToFront:self.midNumUnitLabel];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setMainColor:(UIColor *)mainColor
{
    _mainColor = mainColor;
    
    self.midNumLabel.textColor = mainColor;
    
    self.midNumUnitLabel.textColor = mainColor;

    
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.0, self.height / 2.0) radius:Width(54) startAngle:YF_DEGREES_TO_RADIANS(100) endAngle:YF_DEGREES_TO_RADIANS(440) clockwise:YES];
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    solidLine.lineWidth = 3.0f ;
    solidLine.strokeColor = _mainColor.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;

    
    solidLine.path = thePath.CGPath;

    
//    [self.layer addSublayer:solidLine];
    
    [self.layer insertSublayer:solidLine atIndex:0];
    
    
}

- (UILabel *)midNumLabel
{
    if (!_midNumLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_beginXX, Width(20), _LabelWidth , Width(67))];
        
        label.font = [UIFont boldSystemFontOfSize:Width(48)];
        
        label.backgroundColor = [UIColor clearColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.adjustsFontSizeToFitWidth = YES;
        
        _midNumLabel = label;
    }
    return _midNumLabel;
}

- (UILabel *)midNumUnitLabel
{
    if (!_midNumUnitLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_beginXX, self.midNumLabel.bottom - 1, _LabelWidth , Width(22))];
        
        label.font = FontSizeFY(Width(13));
        
        label.backgroundColor = [UIColor clearColor];

        label.textAlignment = NSTextAlignmentCenter;
        
        _midNumUnitLabel = label;
    }
    return _midNumUnitLabel;
}




- (UILabel *)rankLabel
{
    if (!_rankLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, self.midNumUnitLabel.bottom - Width(7) , self.width - 15 , Width(44))];
        
        label.font = FontSizeFY(13);
        
        label.textColor = YFCellSubGrayTitleColor;
        
        label.backgroundColor = [UIColor whiteColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.adjustsFontSizeToFitWidth = YES;
        
        _rankLabel = label;
    }
    return _rankLabel;
}


- (void)setMidNum:(NSString *)midNum RankInCoun:(NSString *)numInC rankInGym:(NSString *)numInGym
{
    self.midNumLabel.text = midNum;
    self.rankLabel.text = [NSString stringWithFormat:@"总排名%@ 场馆内排名%@",numInC,numInGym];
}
@end
