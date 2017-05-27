//
//  UILabel+AutoSize.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "UILabel+AutoSize.h"

#import <objc/runtime.h>

@implementation UILabel (AutoSize)

static void * autoSizeTextKey = (void *)@"AutoSizeTextKey";

- (NSString *)autoSizeText
{
    return objc_getAssociatedObject(self, autoSizeTextKey);
}

- (void)setAutoSizeText:(NSString *)autoSizeText
{
    
    objc_setAssociatedObject(self, autoSizeTextKey, autoSizeText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CGSize size = [autoSizeText boundingRectWithSize:self.frame.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
    self.text = autoSizeText;
    
    self.numberOfLines = 0;
    
}

-(void)autoHeight
{
    
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.numberOfLines = 0;
    
    CGSize size = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)];
    
    [self changeHeight:size.height];
    
}

-(void)autoSize
{
    
    CGSize size = [self sizeThatFits:CGSizeMake(self.width, self.height)];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.width);
    
}


-(void)autoWidth
{
    
    self.numberOfLines = 1;
    
    CGSize size = [self sizeThatFits:CGSizeMake(MAXFLOAT, self.height)];
    
    [self changeWidth:size.width];
    
}

-(void)autoWidthWithMaxWidth:(CGFloat)width
{
    
    self.numberOfLines = 1;
    
    CGSize size = [self sizeThatFits:CGSizeMake(width, self.height)];
    
    if (width >= size.width) {
        width = size.width;
    }
    
    [self changeWidth:width];
    
}



-(void)autoHeightWithMaxSize:(CGSize)maxSize
{
    
    CGSize size = [self sizeThatFits:CGSizeMake(maxSize.width, self.height)];
    size.height  = ceil(size.height);
    //    if (maxSize.width <= size.width) {
    //        size.width = maxSize.width;
    //    }
    
    if (maxSize.height <= size.height) {
        size.height = maxSize.height;
    }
    
    [self changeHeight:size.height];
}

@end
