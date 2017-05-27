//
//  MOChatImageView.m
//  测试用Demo
//
//  Created by 馍馍帝😈 on 2017/3/17.
//  Copyright © 2017年 馍馍帝. All rights reserved.
//

#import "MOChatImageView.h"

@interface MOChatImageView ()

{
    
    UIImage *_image;
    
}

@end

@implementation MOChatImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
}

-(void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, OnePX);
    //边框颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]colorWithAlphaComponent:0.08].CGColor);
    
    [[UIColor colorWithPatternImage:_image]setFill];
    
    [[UIColor clearColor]setStroke];
    
    if (!_isMine) {
        
        CGContextMoveToPoint(context,0, 0);  // 开始坐标左边开始
        
        CGContextAddLineToPoint(context, Width(8), Height(7));
        
        
        CGContextAddArcToPoint(context, Width(8), rect.size.height, Width(8)+Height(2), rect.size.height, Width(1));  // 左下角角度
        CGContextAddArcToPoint(context, rect.size.width, rect.size.height, rect.size.width, rect.size.height-Height(2), Height(1)); // 右下角角度
        CGContextAddArcToPoint(context, rect.size.width, 0, rect.size.width-Width(2), 0 , Width(1)); // 右上角
        CGContextAddLineToPoint(context, 0, 0); // 右上角
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        
    }else{
        
        CGContextMoveToPoint(context, rect.size.width, 0);  // 开始坐标右边开始
        
        CGContextAddLineToPoint(context, rect.size.width-Width(8), Height(7));
        
        
        CGContextAddArcToPoint(context, rect.size.width-Width(8), rect.size.height, rect.size.width-Width(8)-Height(2), rect.size.height, Width(1));  // 右下角角度
        CGContextAddArcToPoint(context, 0, rect.size.height, 0, rect.size.height-Height(2), Height(1)); // 左下角角度
        CGContextAddArcToPoint(context, 0, 0, Width(2), 0 , Width(1)); // 左上角
        CGContextAddLineToPoint(context, rect.size.width, 0); // 右上角
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        
    }
    
}

@end
