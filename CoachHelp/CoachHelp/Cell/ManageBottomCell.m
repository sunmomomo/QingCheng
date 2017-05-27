//
//  ManageBottomCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ManageBottomCell.h"

@interface ManageBottomCell ()

{
    
    UIView *_bottomLine;
    
    UILabel *_textLabel;
    
    UIImageView *_imageView;
    
}

@end

@implementation ManageBottomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(Width320(14),frame.size.height-OnePX, frame.size.width-Width320(15), OnePX)];
        
        _bottomLine.backgroundColor = UIColorFromRGB(0xE8E8E8);
        
        _bottomLine.hidden = YES;
        
        [self addSubview:_bottomLine];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(51), 0, frame.size.width-Width320(60), frame.size.height)];
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(13);
        
        [self addSubview:_textLabel];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(16), Height320(16))];
        
        [self addSubview:_imageView];
        
    }
    
    return self;
    
}

-(void)setHaveLine:(BOOL)haveLine
{
    
    _haveLine = haveLine;
    
    _bottomLine.hidden = !_haveLine;
    
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
    
    _imageView.center = CGPointMake(Width320(24), self.height/2);
    
}

@end
