//
//  MOScrollView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOScrollView.h"

#define kLJItemWidth MSW/8

@interface MOScrollView ()

{
    
    UIScrollView *scrollview;
    
}

@end

@implementation MOScrollView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        scrollview = ({
            
            UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 0, kLJItemWidth, frame.size.height)];
            
            scroll.pagingEnabled = YES;
            
            scroll.clipsToBounds = NO;
            
            scroll;
            
        });
        [self addSubview:scrollview];
        
        self.clipsToBounds = YES;
        
    }
    
    return self;
    
}

-(void)loadImages:(NSArray *)array
{
    
    int index = 0;
    
    [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(NSString * name in array){
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        
        iv.contentMode = UIViewContentModeScaleToFill;
        
        CGRect fra = iv.frame;
        
        fra.size.width = kLJItemWidth;
        
        fra.origin.x = index * kLJItemWidth;
        
        iv.frame = fra;
        
        [scrollview addSubview:iv];
        
        index++;
    
    }
    
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width*index, scrollview.frame.size.height);
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    if ([view isEqual:self]) {
        
        for (UIView *subview in scrollview.subviews)
        {
            
            CGPoint offset = CGPointMake(point.x - scrollview.frame.origin.x + scrollview.contentOffset.x - subview.frame.origin.x,point.y - scrollview.frame.origin.y + scrollview.contentOffset.y - subview.frame.origin.y);
            
            if ((view = [subview hitTest:offset withEvent:event]))
            {
                
                return view;
                
            }
            
        }
        
        return scrollview;
        
    }
    
    return view;
    
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    
    _contentOffset = contentOffset;
    
    scrollview.contentOffset = _contentOffset;
    
}

@end