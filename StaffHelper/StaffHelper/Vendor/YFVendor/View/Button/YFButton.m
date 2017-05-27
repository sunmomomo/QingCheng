//
//  YFButton.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFButton.h"

@implementation YFButton

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
