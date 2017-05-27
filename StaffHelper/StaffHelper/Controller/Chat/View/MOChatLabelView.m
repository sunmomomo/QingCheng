//
//  MOChatLabelView.m
//  测试用Demo
//
//  Created by 馍馍帝😈 on 2017/3/17.
//  Copyright © 2017年 馍馍帝. All rights reserved.
//

#import "MOChatLabelView.h"

@implementation MOChatLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    //边框颜色
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    if (!_isMine) {
        
        [UIColorFromRGB(0xEEEEEE)setFill];
        
        CGContextMoveToPoint(context,0, 0);  // 开始坐标左边开始
        
        CGContextAddLineToPoint(context, Width(8), Height(7));
        
        
        CGContextAddArcToPoint(context, Width(8), rect.size.height, Width(8)+Height(10), rect.size.height, Width(5));  // 左下角角度
        CGContextAddArcToPoint(context, rect.size.width, rect.size.height, rect.size.width, rect.size.height-Height(10), Height(5)); // 右下角角度
        CGContextAddArcToPoint(context, rect.size.width, 0, rect.size.width-Width(10), 0 , Width(5)); // 右上角
        CGContextAddLineToPoint(context, 0, 0); // 右上角
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        
    }else{
        
        [UIColorFromRGB(0x0DB14B) setFill];
        
        CGContextMoveToPoint(context, rect.size.width, 0);  // 开始坐标右边开始
        
        CGContextAddLineToPoint(context, rect.size.width-Width(8), Height(7));
        
        
        CGContextAddArcToPoint(context, rect.size.width-Width(8), rect.size.height, rect.size.width-Width(8)-Height(10), rect.size.height, Width(5));  // 右下角角度
        CGContextAddArcToPoint(context, 0, rect.size.height, 0, rect.size.height-Height(10), Height(5)); // 左下角角度
        CGContextAddArcToPoint(context, 0, 0, Width(10), 0 , Width(5)); // 左上角
        CGContextAddLineToPoint(context, rect.size.width, 0); // 右上角
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        
    }
    
}

@end
