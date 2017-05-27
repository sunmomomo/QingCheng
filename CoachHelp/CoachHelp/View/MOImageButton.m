//
//  MOImageButton.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOImageButton.h"

@interface MOImageButton ()

{
    
    UIImageView *_imageView;
    
}

@end

@implementation MOImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_imageView];
        
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imageView.image = _image;
    
}

-(void)setImageURL:(NSURL *)imageURL
{
    
    _imageURL = imageURL;
    
    [_imageView sd_setImageWithURL:_imageURL];
    
}

-(void)setContentMode:(UIViewContentMode)contentMode
{
    
    _imageView.contentMode = contentMode;
    
}

@end
