//
//  CheckSuccessView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckSuccessView.h"

@interface CheckSuccessView ()

{
    
    CGFloat _top;
    
    UIImageView *_checkImg;
    
    UILabel *_titleLabel;
    
}

@end

@implementation CheckSuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _top = frame.origin.y;
        
        self.backgroundColor = UIColorFromRGB(0xF9944E);
        
        self.alpha = 0.88;
        
        _checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(12), Width320(20), Height320(20))];
        
        _checkImg.image = [UIImage imageNamed:@"check_success"];
        
        [self addSubview:_checkImg];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(44))];
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.font = AllFont(14);
        
        [self addSubview:_titleLabel];
        
        self.hidden = YES;
        
    }
    return self;
}

+(instancetype)defaultSuccessView
{
    
    CheckSuccessView *view = [[CheckSuccessView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(44))];
    
    return view;
    
}

-(void)show
{
    
    [self changeTop:_top-self.frame.size.height];
    
    self.hidden = NO;
    
    [self.superview bringSubviewToFront:self];
    
    for (UIView *subView in self.superview.subviews) {
        
        if ([NSStringFromClass([subView class]) isEqualToString:@"MONaviView"]) {
            
            [self.superview bringSubviewToFront:subView];
            
        }
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self changeTop:_top];
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self close];
            
        });
        
    }];
    
}

-(void)close
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self changeTop:_top-self.frame.size.height];
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        
        [self removeFromSuperview];
        
    }];
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MSW, Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    [_titleLabel changeWidth:size.width];
    
    [_checkImg changeLeft:MSW/2-(size.width+Width320(30))/2];
    
    [_titleLabel changeLeft:_checkImg.right+Width320(10)];
    
}

@end
