//
//  ChooseCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChooseCell.h"

@interface ChooseCell ()

{
    
    UILabel *_textLabel;
    
    UIImageView *_chooseImg;
    
    UIView *_lineView;
    
}

@end

@implementation ChooseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(200), Height320(40))];
        
        _textLabel.textColor = UIColorFromRGB(0x666666);
        
        _textLabel.font = AllFont(14);
        
        [self addSubview:_textLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(18), Height320(13), Width320(20), Height320(14))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        [self addSubview:_chooseImg];
        
        _chooseImg.hidden = YES;
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_lineView];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !choosed;
    
}

-(void)setNoLine:(BOOL)noLine
{
    
    _noLine = noLine;
    
    _lineView.hidden = noLine;
    
}

@end
