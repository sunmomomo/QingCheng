//
//  ManageTopCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ManageTopCell.h"

@interface ManageTopCell ()

{
    
    UIView *_topLine;
    
    UIView *_rightLine;
    
    UILabel *_textLabel;
    
    UIImageView *_imageView;
    
}

@end

@implementation ManageTopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, OnePX)];
        
        _topLine.backgroundColor = UIColorFromRGB(0xE8E8E8);
        
        _topLine.hidden = YES;
        
        [self addSubview:_topLine];
        
        _rightLine = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-OnePX,0, OnePX, frame.size.height)];
        
        _rightLine.backgroundColor = UIColorFromRGB(0xE8E8E8);
        
        _rightLine.hidden = YES;
        
        [self addSubview:_rightLine];
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-OnePX, frame.size.width, OnePX)];
        
        bottomLine.backgroundColor = UIColorFromRGB(0xE8E8E8);
        
        [self addSubview:bottomLine];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(63), frame.size.width, Height320(14))];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(12);
        
        [self addSubview:_textLabel];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(20), Height320(20))];
        
        [self addSubview:_imageView];
        
    }
    
    return self;
    
}

-(void)setHaveTopLine:(BOOL)haveTopLine
{
    
    _haveTopLine = haveTopLine;
    
    _topLine.hidden = !_haveTopLine;
    
}

-(void)setHaveRightLine:(BOOL)haveRightLine
{
    
    _haveRightLine = haveRightLine;
    
    _rightLine.hidden = !_haveRightLine;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
    _identifier = _title;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imageView.image = _image;
    
    _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    _imageView.center = CGPointMake(self.width/2, Height320(40));
    
}

@end
