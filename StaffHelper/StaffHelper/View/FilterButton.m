//
//  FilterButton.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "FilterButton.h"

#import "UIImage+Category.h"

@interface FilterButton ()

{
    
    UILabel *_label;
    
    UIImageView *_imageView;
    
}

@end

@implementation FilterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(9), 0, Width320(30), Height320(40))];
        
        _label.textColor = UIColorFromRGB(0x999999);
        
        _label.font = AllFont(14);
        
        [self addSubview:_label];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_label.right+Width320(2), Height320(14), Width320(12), Height320(12))];
        
        [self addSubview:_imageView];
        
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imageView.image = _image;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _label.text = _title;
    
}

-(void)setFiltered:(BOOL)filtered
{
    
    _filtered = filtered;
    
    if (_filtered) {
        
        _label.textColor = kMainColor;
        
        _imageView.image = [_image imageWithTintColor:kMainColor];
        
    }else
    {
        
        _label.textColor = UIColorFromRGB(0x999999);
        
        _imageView.image = _image;
        
    }
    
}


@end
