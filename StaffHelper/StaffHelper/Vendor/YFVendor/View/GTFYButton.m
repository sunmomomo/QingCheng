//
//  GTFYButton.m
//  FYRrefresh
//
//  Created by FYWCQ on 16/4/2.
//  Copyright © 2016年 FYWCQ. All rights reserved.
//

#import "GTFYButton.h"

@implementation GTFYButton
{
    CGRect _titleFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect )titleFrame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageFrame = imageFrame;
        
        _titleFrame=titleFrame;
//        $8 = (origin = (x = 14.5, y = 0), size = (width = 51, height = 47))

    }
    return self;
}



- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return _imageFrame;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return _titleFrame;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
