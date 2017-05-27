//
//  UIView+Frame.m
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/7/17.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "UIView+Frame.h"

#import <objc/runtime.h>

static void * IndexPathKey = (void *)@"IndexPathKey";

static void * IdentifierKey = (void*)@"IdentifierKey";

@implementation UIView (Frame)

@dynamic indexPath;

- (NSIndexPath*)indexPath
{
    return objc_getAssociatedObject(self, IndexPathKey);
}

- (void)setIndexPath:(NSIndexPath*)indexPath
{
    objc_setAssociatedObject(self, IndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)viewIdentifier
{
    
    return [objc_getAssociatedObject(self, IdentifierKey) integerValue];
    
}

-(void)setViewIdentifier:(NSInteger)viewIdentifier
{
    
    objc_setAssociatedObject(self, IdentifierKey, [NSNumber numberWithInteger:viewIdentifier], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(CGFloat)bottom
{
    return self.frame.origin.y+self.frame.size.height;
}

-(CGFloat)right
{
    return self.frame.origin.x+self.frame.size.width;
}

-(CGFloat)left
{
    return self.frame.origin.x;
}

-(CGFloat)top
{
    return self.frame.origin.y;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)changeLeft:(CGFloat)left
{
    
    self.frame = CGRectMake(left, self.top, self.width, self.height);
    
}

-(void)changeTop:(CGFloat)top
{
    
    self.frame = CGRectMake(self.left, top, self.width, self.height);
    
}

-(void)changeWidth:(CGFloat)width
{
    
    self.frame = CGRectMake(self.left, self.top,width, self.height);
    
}

-(void)changeHeight:(CGFloat)height
{
    
    self.frame = CGRectMake(self.left, self.top, self.width, height);
    
}

-(void)changeSize:(CGSize)size
{
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    
}

-(void)changeOrigin:(CGPoint)origin
{
    
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
    
}

-(void)removeAllView
{
    if (self.subviews.count) {
        for (UIView *view in self.subviews) {
            
            [view removeFromSuperview];
            
        }
    }
}

@end
