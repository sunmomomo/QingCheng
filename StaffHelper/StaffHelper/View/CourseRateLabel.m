//
//  CourseRateLabel.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseRateLabel.h"

@interface CourseRateLabel ()

{
    
    UILabel *_label;
    
}

@end

@implementation CourseRateLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = LabelBackColor;
        
        self.layer.cornerRadius = 4;
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, frame.size.width-Width320(32), frame.size.height)];
        
        _label.font = AllFont(12);
        
        _label.textColor = UIColorFromRGB(0x666666);
        
        [self addSubview:_label];
        
    }
    
    return self;
    
}

-(void)setText:(NSString *)text
{
    
    _text = text;
    
    _label.autoSizeText = _text;
    
    [self changeWidth:_label.width+Width320(32)];
    
    _label.center = CGPointMake(self.width/2, self.height/2);
    
}

-(void)setTextColor:(UIColor *)textColor
{
    
    _textColor = textColor;
    
    _label.textColor = _textColor;
    
}

@end
