//
//  FunctionNoneCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "FunctionNoneCell.h"

@interface FunctionNoneCell ()

{
    
    UILabel *_titleLabel;
    
}

@end

@implementation FunctionNoneCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        
        _titleLabel.font = AllFont(11);
        
        [self addSubview:_titleLabel];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

@end
