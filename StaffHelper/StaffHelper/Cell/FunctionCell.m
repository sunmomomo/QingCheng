//
//  FunctionCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "FunctionCell.h"

#import "YFAppConfig.h"

@interface FunctionCell ()

{
    
    UIImageView *_imageView;
    
    UILabel *_textLabel;
    
    UILabel *_proLabel;
    
}

@end

@implementation FunctionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(50), frame.size.width, Height320(14))];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(12);
        
        [self addSubview:_textLabel];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(24), Height320(24))];
        
        [self addSubview:_imageView];
        
        _proLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-Width320(24), Height320(4), Width320(20), Height320(12))];
        
        _proLabel.backgroundColor = kMainColor;
        
        _proLabel.layer.cornerRadius = _proLabel.height/2;
        
        _proLabel.layer.masksToBounds = YES;
        
        _proLabel.text = @"PRO";
        
        _proLabel.textColor = UIColorFromRGB(0xffffff);
        
        _proLabel.textAlignment = NSTextAlignmentCenter;
        
        _proLabel.font = AllFont(7);
        
        [self addSubview:_proLabel];
        
        _proLabel.hidden = YES;
        
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
    
    _imageView.center = CGPointMake(self.width/2, Height320(30));
    
}

-(void)setType:(FunctionCellType)type
{
    
    _type = type;
    
    _proLabel.hidden = _type == FunctionCellTypeFree;
    
}

@end
