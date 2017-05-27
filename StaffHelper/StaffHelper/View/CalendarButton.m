//
//  CalendarButton.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CalendarButton.h"

@interface CalendarButton ()

{
    
    UIView *_nodeView;
    
    UIView *_circle;
    
    UILabel *_title;
    
}


@end

@implementation CalendarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _circle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(24), Height320(24))];
        
        _circle.backgroundColor = kMainColor;
        
        _circle.layer.cornerRadius = _circle.width/2;
        
        _circle.layer.masksToBounds = YES;
        
        _circle.center = CGPointMake(self.width/2, self.height/2);
        
        [self addSubview:_circle];
        
        _nodeView = [[UIView alloc]initWithFrame:CGRectMake(0,_circle.bottom-Height320(4.5), Width320(3.5), Height320(3.5))];
        
        _nodeView.layer.cornerRadius = _nodeView.width/2;
        
        _nodeView.layer.masksToBounds = YES;
        
        _nodeView.center = CGPointMake(self.width/2, _nodeView.center.y);
        
        [self addSubview:_nodeView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        _title.font = AllFont(14);
        
        _title.textColor = UIColorFromRGB(0x333333);
        
        _title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_title];
        
        _circle.userInteractionEnabled = NO;
        
        _nodeView.userInteractionEnabled = NO;
        
        _title.userInteractionEnabled = NO;
        
    }
    
    return self;
    
}

-(void)setDate:(NSDate *)date
{
    
    _date = date;
    
    if (!date) {
        
        _title.text = @"";
        
        return;
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [df setDateFormat:@"dd"];
    
    NSString *title = [df stringFromDate:_date];
    
    _title.text = title;
    
}

-(void)setType:(CalendarButtonType)type
{
    
    _type = type;
    
    switch (type) {
        case CalendarButtonTypeToday:
            
            _circle.hidden = NO;
            
            _nodeView.backgroundColor = [UIColor clearColor];
            
            _title.textColor = UIColorFromRGB(0xffffff);
            
            break;
        case CalendarButtonTypeTodayPro:
            
            _circle.hidden = NO;
            
            _nodeView.backgroundColor = UIColorFromRGB(0xffffff);
            
            _title.textColor = UIColorFromRGB(0xffffff);
            
            break;
        case CalendarButtonTypeFuture:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = UIColorFromRGB(0xff0000);
            
            _title.textColor = UIColorFromRGB(0x333333);
            
            break;
        case CalendarButtonTypePast:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = UIColorFromRGB(0xcccccc);
            
            _title.textColor = UIColorFromRGB(0x333333);
            
            break;
        case CalendarButtonTypeNoProgramme:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = [UIColor clearColor];
            
            _title.textColor = UIColorFromRGB(0x333333);
            
            break;
        case CalendarButtonTypeNoDate:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = [UIColor clearColor];
            
            _title.textColor = UIColorFromRGB(0x333333);
            
        default:
            break;
    }
    
}

@end
