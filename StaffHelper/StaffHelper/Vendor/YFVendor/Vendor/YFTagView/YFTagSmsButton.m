//
//  YFTagSmsButton.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTagSmsButton.h"

@implementation YFTagSmsButton

{
    CGRect _imageFrame;
    
    CGRect _titleFrame;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (id)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect )titleFrame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _imageFrame=imageFrame;
        
        _titleFrame=titleFrame;
        
    }
    return self;
}



- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return _imageFrame;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return _titleFrame;
}


@end
