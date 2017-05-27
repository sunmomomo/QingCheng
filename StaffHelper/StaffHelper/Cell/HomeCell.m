//
//  HomeCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "HomeCell.h"
#import "YFAppConfig.h"

@interface HomeCell ()

{
    
    UIImageView *_imageView;
    
    UILabel *_textLabel;
    
}

@end

@implementation HomeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(63), frame.size.width, Height320(14))];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(12);
        
        [self addSubview:_textLabel];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(20), Height320(20))];
        
        [self addSubview:_imageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-OnePX, 0, OnePX, frame.size.height)];
        
        lineView.backgroundColor = YFLineViewColor;
        [self addSubview:lineView];
        
    }
    return self;
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
