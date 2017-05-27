//
//  CourseCoachView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseCoachView.h"

#import "MOStarRateView.h"

@interface CourseCoachButton : UIButton

{
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
    MOStarRateView *_rateView;
    
}

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)float rate;

@end

@implementation CourseCoachButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _iconView.bottom+Height320(5), frame.size.width, Height320(13))];
        
        _nameLabel.textColor = UIColorFromRGB(0x666666);
        
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = AllFont(11);
        
        [self addSubview:_nameLabel];
        
        _rateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(22), _nameLabel.bottom+Height320(3), Width320(44), Height320(8))];
        
        _rateView.starColor = UIColorFromRGB(0xF9944E);
        
        [self addSubview:_rateView];
        
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
    
    _nameLabel.text = _name;
    
}

-(void)setRate:(float)rate
{
    
    _rate = rate;
    
    _rateView.scorePercent = _rate;
    
}

@end

@interface CourseCoachView ()

{
    
    UIScrollView *_mainView;
    
}

@end

@implementation CourseCoachView

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
        
        topLabel.text = @"课程教练";
        
        topLabel.textColor = UIColorFromRGB(0x666666);
        
        topLabel.font = AllFont(12);
        
        [self addSubview:topLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(10), Height320(26)-1/[UIScreen mainScreen].scale, MSW-Width320(20), 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:sep];
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, sep.bottom, frame.size.width, frame.size.height-sep.bottom)];
        
        [self addSubview:_mainView];
        
    }
    
    return self;
    
}

-(void)setCoaches:(NSArray *)coaches
{
    
    _coaches = coaches;
    
    [_mainView removeAllView];
    
    if (_coaches.count) {
        
        [_mainView changeHeight:Height320(118)];
        
        [self changeHeight:_mainView.bottom];
        
        for (NSInteger i = 0;i<_coaches.count;i++) {
            
            Coach *coach = _coaches[i];
            
            CourseCoachButton *button = [[CourseCoachButton alloc]initWithFrame:CGRectMake(Width320(12)+i*Width320(68), Height320(17), Width320(56), Height320(85))];
            
            button.tag = i;
            
            button.iconURL = coach.iconUrl;
            
            button.name = coach.name;
            
            button.rate = coach.rateScore;
            
            [_mainView addSubview:button];
            
            [button addTarget:self action:@selector(coachClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        _mainView.contentSize = CGSizeMake(Width320(12)+Width320(68)*_coaches.count, 0);
        
        _mainView.contentOffset = CGPointMake(0, 0);
        
    }else{
        
        [_mainView changeHeight:Height320(50)];
        
        [self changeHeight:_mainView.bottom];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _mainView.width, _mainView.height)];
        
        label.text = @"暂未安排教练";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = AllFont(12);
        
        [_mainView addSubview:label];
        
        _mainView.contentSize = CGSizeMake(0, 0);
        
        _mainView.contentOffset = CGPointMake(0, 0);
        
    }
    
}

-(void)coachClick:(UIButton*)button
{
    
    [self.delegate coachDidSelectedAtIndex:button.tag];
    
}

@end
