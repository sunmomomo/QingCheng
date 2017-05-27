//
//  CourseRateView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseRateView.h"

#import "MOStarRateView.h"

#import "CourseRateLabel.h"

@interface CourseRateView ()

{
    
    UILabel *_coachGradeLabel;
    
    UILabel *_courseGradeLabel;
    
    UILabel *_serviceGradeLabel;
    
    MOStarRateView *_coachRateView;
    
    MOStarRateView *_courseRateView;
    
    MOStarRateView *_serviceRateView;
    
    UIButton *_moreButton;
    
}

@end

@implementation CourseRateView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(6), Width320(3), Height320(14))];
        
        greenView.backgroundColor = UIColorFromRGB(0x0DB14B);
        
        [self addSubview:greenView];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), 0, Width320(100), Height320(26))];
        
        topLabel.text = @"评分评价";
        
        topLabel.textColor = UIColorFromRGB(0x666666);
        
        topLabel.font = AllFont(12);
        
        [self addSubview:topLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(10), Height320(26)-1/[UIScreen mainScreen].scale, MSW-Width320(20), 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:sep];
        
        UILabel *coachLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(22), Height320(37), Width320(72), Height320(16))];
        
        coachLabel.text = @"教练评分";
        
        coachLabel.textColor = UIColorFromRGB(0x666666);
        
        coachLabel.textAlignment = NSTextAlignmentCenter;
        
        coachLabel.font = AllFont(12);
        
        [self addSubview:coachLabel];
        
        _coachGradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(coachLabel.left, coachLabel.bottom+Height320(7), coachLabel.width, Height320(27))];
        
        _coachGradeLabel.textColor = UIColorFromRGB(0xF9944E);
        
        _coachGradeLabel.textAlignment = NSTextAlignmentCenter;
        
        _coachGradeLabel.font = AllFont(24);
        
        [self addSubview:_coachGradeLabel];
        
        _coachRateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(Width320(32), _coachGradeLabel.bottom+Height320(6), Width320(44), Height320(8))];
        
        _coachRateView.starColor = UIColorFromRGB(0xF9944E);
        
        _coachRateView.center = CGPointMake(_coachGradeLabel.center.x, _coachRateView.center.y);
        
        [self addSubview:_coachRateView];
        
        UILabel *courseLabel = [[UILabel alloc]initWithFrame:CGRectMake(coachLabel.right+Width320(30), coachLabel.top, Width320(72), Height320(16))];
        
        courseLabel.text = @"课程评分";
        
        courseLabel.textColor = UIColorFromRGB(0x666666);
        
        courseLabel.textAlignment = NSTextAlignmentCenter;
        
        courseLabel.font = AllFont(12);
        
        [self addSubview:courseLabel];
        
        _courseGradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(courseLabel.left, courseLabel.bottom+Height320(7), courseLabel.width, Height320(27))];
        
        _courseGradeLabel.textColor = UIColorFromRGB(0xF9944E);
        
        _courseGradeLabel.textAlignment = NSTextAlignmentCenter;
        
        _courseGradeLabel.font = AllFont(24);
        
        [self addSubview:_courseGradeLabel];
        
        _courseRateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(Width320(32), _courseGradeLabel.bottom+Height320(6), Width320(44), Height320(8))];
        
        _courseRateView.starColor = UIColorFromRGB(0xF9944E);
        
        _courseRateView.center = CGPointMake(_courseGradeLabel.center.x, _courseRateView.center.y);
        
        [self addSubview:_courseRateView];
        
        UILabel *serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(courseLabel.right+Width320(30), courseLabel.top, Width320(72), Height320(16))];
        
        serviceLabel.text = @"服务评分";
        
        serviceLabel.textColor = UIColorFromRGB(0x666666);
        
        serviceLabel.textAlignment = NSTextAlignmentCenter;
        
        serviceLabel.font = AllFont(12);
        
        [self addSubview:serviceLabel];
        
        _serviceGradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(serviceLabel.left, serviceLabel.bottom+Height320(7), serviceLabel.width, Height320(27))];
        
        _serviceGradeLabel.textColor = UIColorFromRGB(0xF9944E);
        
        _serviceGradeLabel.textAlignment = NSTextAlignmentCenter;
        
        _serviceGradeLabel.font = AllFont(24);
        
        [self addSubview:_serviceGradeLabel];
        
        _serviceRateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(Width320(32), _serviceGradeLabel.bottom+Height320(6), Width320(44), Height320(8))];
        
        _serviceRateView.center = CGPointMake(_serviceGradeLabel.center.x, _serviceRateView.center.y);
        
        _serviceRateView.starColor = UIColorFromRGB(0xF9944E);
        
        [self addSubview:_serviceRateView];
        
        _moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height320(182), MSW, Height320(37))];
        
        [self addSubview:_moreButton];
        
        UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2-Width320(48.5), 0, Width320(80), Height320(37))];
        
        moreLabel.text = @"查看评价详情";
        
        moreLabel.textColor = UIColorFromRGB(0x999999);
        
        moreLabel.font = AllFont(12);
        
        moreLabel.textAlignment = NSTextAlignmentCenter;
        
        [_moreButton addSubview:moreLabel];
        
        UIImageView *moreImg = [[UIImageView alloc]initWithFrame:CGRectMake(moreLabel.right, Height320(12), Width320(7), Height320(12))];
        
        moreImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [_moreButton addSubview:moreImg];
        
        [self changeHeight:_moreButton.bottom];
        
    }
    
    return self;
    
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    
    [_moreButton addTarget:target action:action forControlEvents:controlEvents];
    
}

-(void)setGrades:(NSArray *)grades
{
    
    _grades = grades;
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[CourseRateLabel class]]) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
    if (_grades.count) {
        
        float top = Height320(116);
        
        float right = Width320(30);
        
        for (NSInteger i = 0; i<_grades.count; i++) {
            
            CourseRateLabel *label = [[CourseRateLabel alloc]initWithFrame:CGRectMake(right, top, MAXFLOAT, Height320(26))];
            
            label.text = _grades[i];
            
            [label changeLeft:right];
            
            right += label.width+Width320(10);
            
            if (label.right>MSW-Width320(30)) {
                
                right = Width320(30);
                
                top = top+Height320(36);
                
                [label changeLeft:right];
                
                right += label.width+Width320(10);
                
                [label changeTop:top];
                
            }
            
            [self addSubview:label];
            
        }
        
        [_moreButton changeTop:top+Height320(30)];
        
        [self changeHeight:_moreButton.bottom];
        
    }else{
        
        CourseRateLabel *label = [[CourseRateLabel alloc]initWithFrame:CGRectMake(Width320(150), Height320(116), MAXFLOAT, Height320(26))];
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        label.text = @"暂无印象";
        
        [label changeLeft:MSW/2-label.width/2];
        
        [self addSubview:label];
        
        [_moreButton changeTop:label.bottom+Height320(4)];
        
        [self changeHeight:_moreButton.bottom];
        
    }
    
}

-(void)setCoachGrade:(float)coachGrade andCourseGrade:(float)courseGrade andServiceGrade:(float)serviceGrade
{
    
    _coachGradeLabel.text = [NSString stringWithFormat:@"%.1f",coachGrade];
    
    _coachRateView.scorePercent = coachGrade;
    
    _courseGradeLabel.text = [NSString stringWithFormat:@"%.1f",courseGrade];
    
    _courseRateView.scorePercent = courseGrade;
    
    _serviceGradeLabel.text = [NSString stringWithFormat:@"%.1f",serviceGrade];
    
    _serviceRateView.scorePercent = serviceGrade;
    
}

@end
