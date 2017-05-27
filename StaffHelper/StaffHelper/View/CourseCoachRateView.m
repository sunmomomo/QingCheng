//
//  CourseCoachRateView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseCoachRateView.h"

@interface CourseCoachTriangleView : UIView

@end

@implementation CourseCoachTriangleView

-(void)drawRect:(CGRect)rect
{
    
    [[UIColor whiteColor]set];
    
    UIRectFill([self bounds]);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint sPoint[3];
    
    sPoint[0] = CGPointMake(0, self.height);
    
    sPoint[1] = CGPointMake(self.width/2, 0);
    
    sPoint[2] = CGPointMake(self.width, self.height);
    
    CGContextAddLines(context, sPoint, 3);
    
    CGContextSetLineWidth(context,1/[UIScreen mainScreen].scale);
    
    CGContextClosePath(context);
    
    [UIColorFromRGB(0xf4f4f4) setFill];
    
    [UIColorFromRGB(0xdddddd) setStroke];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end

@interface CourseCoachRateButton : UIButton

{
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
}

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)BOOL choosed;

@end

@implementation CourseCoachRateButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _iconView.bottom+Height320(5), frame.size.width, frame.size.height-_iconView.bottom-Height320(5))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = AllFont(11);
        
        [self addSubview:_nameLabel];
        
    }
    
    return self;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = name;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    self.alpha = _choosed?1:0.4;
    
}

@end

@interface CourseCoachRateView ()

{
    
    UIScrollView *_mainView;
    
    CourseCoachTriangleView *_arrowView;
    
}

@end

@implementation CourseCoachRateView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _mainView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_mainView];
        
        _arrowView = [[CourseCoachTriangleView alloc]initWithFrame:CGRectMake(Width320(12)+Width320(56)/2-Width320(6), frame.size.height-Height320(7), Width320(12), Height320(7)+1/[UIScreen mainScreen].scale)];
        
        [_mainView addSubview:_arrowView];
        
    }
    
    return self;
    
}

-(void)setCoaches:(NSArray *)coaches
{
    
    _coaches = coaches;
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[CourseCoachRateButton class]]) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
    for (NSInteger i = 0;i<_coaches.count;i++) {
        
        CourseCoachRateButton *button = [[CourseCoachRateButton alloc]initWithFrame:CGRectMake(Width320(10)+i*Width320(68), Height320(12.5), Width320(56), Height320(75))];
        
        Coach *coach = _coaches[i];
        
        button.iconURL = coach.iconUrl;
        
        button.name = coach.name;
        
        button.tag = i;
     
        button.choosed = i == 0;
        
        [_mainView addSubview:button];
        
        [button addTarget:self action:@selector(coachButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    _mainView.contentOffset = CGPointMake(0, 0);
    
    _mainView.contentSize = CGSizeMake(Width320(8)+Width320(68)*_coaches.count, 0);
    
    _arrowView.center = CGPointMake(Width320(12)+Width320(56)/2, _arrowView.center.y);
    
}

-(void)coachButtonClick:(CourseCoachRateButton *)button
{
    
    if (button.left-_mainView.contentOffset.x<Width320(10)) {
        
        [_mainView setContentOffset:CGPointMake(button.left-Width320(12), 0) animated:YES];
        
    }else if (button.right-_mainView.contentOffset.x>MSW-Width320(10)){
        
        [_mainView setContentOffset:CGPointMake(button.right-MSW+Width320(10), 0) animated:YES];
        
    }
    
    for (UIView *subView in _mainView.subviews) {
        
        if ([subView isKindOfClass:[CourseCoachRateButton class]]) {
            
            ((CourseCoachRateButton*)subView).choosed = subView.tag == button.tag;
            
        }
        
    }
    
    _arrowView.center = CGPointMake(button.center.x, _arrowView.center.y);
    
    [self.delegate rateViewDidSelectedCoachAtIndex:button.tag];
    
}

@end
