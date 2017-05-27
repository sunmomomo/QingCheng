//
//  ChooseMemberGroupHeader.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChooseMemberGroupHeader.h"

@interface ChooseMemberGroupHeader ()

{
    
    UIImageView *_chooseImgView;
    
    UILabel *_titleLabel;
    
    UIImageView *_arrowImg;
    
    UIView *_topLine;
    
}

@end

@implementation ChooseMemberGroupHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIButton *chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Width(50), Height(50))];
        
        [chooseButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:chooseButton];
        
        _chooseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(20), Height(20))];
        
        _chooseImgView.layer.borderColor = UIColorFromRGB(0xc8c8c8).CGColor;
        
        _chooseImgView.layer.borderWidth = Width(1);
        
        _chooseImgView.layer.cornerRadius = _chooseImgView.width/2;
        
        _chooseImgView.layer.masksToBounds = YES;
        
        [chooseButton addSubview:_chooseImgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(chooseButton.right, 0, MSW-Width(42)-chooseButton.right, Height(50))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self addSubview:_titleLabel];
        
        UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(Width(50), 0, MSW-Width(50), Height(50))];
        
        [showButton addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:showButton];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(showButton.width-Width(27), Height(21), Width(12), Height(7))];
        
        _arrowImg.center = CGPointMake(_arrowImg.center.x, showButton.height/2);
        
        _arrowImg.image = [UIImage imageNamed:@"down_arrow"];
        
        [showButton addSubview:_arrowImg];
        
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, OnePX)];
        
        _topLine.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_topLine];
        
        UIView *botLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-OnePX, frame.size.width, OnePX)];
        
        botLine.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:botLine];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setNoTopLine:(BOOL)noTopLine
{
    
    _topLine.hidden = noTopLine;
    
}

-(void)setType:(ChooseMemberGroupHeaderChooseType)type
{
    
    _type = type;
    
    _chooseImgView.layer.borderWidth = _type != ChooseMemberGroupHeaderChooseTypeNone ?0:Width(1);
    
    _chooseImgView.image = _type == ChooseMemberGroupHeaderChooseTypeAll?[UIImage imageNamed:@"selected"]:_type == ChooseMemberGroupHeaderChooseTypePart?[UIImage imageNamed:@"part_select"]:nil;
    
}

-(void)setShowing:(BOOL)showing
{
    
    _showing = showing;
    
    _arrowImg.transform = _showing?CGAffineTransformMakeRotation(M_PI):CGAffineTransformMakeRotation(0);
    
}

-(void)show:(UIButton*)button
{
    
    if ([self.delegate respondsToSelector:@selector(groupHeaderShow:)]) {
        
        [self.delegate groupHeaderShow:self];
        
    }
    
}

-(void)choose:(UIButton*)button
{
    
    if ([self.delegate respondsToSelector:@selector(groupHeaderChoosed:)]) {
        
        [self.delegate groupHeaderChoosed:self];
        
    }
    
}

@end
