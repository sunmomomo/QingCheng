//
//  CornerLabel.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CornerLabel.h"

@implementation CornerLabel


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setNeedsDisplay];
        
    }
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    
    CGRect rect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x = bounds.origin.x+rect.size.width/2;
    
    rect.origin.y = bounds.origin.y+bounds.size.height-rect.size.height-3;
    
    return  rect;
    
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
