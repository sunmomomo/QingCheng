//
//  QCLoadingHUD.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QCLoadingHUD.h"

@interface QCLoadingHUD ()

{
    
    UIImageView *_outsideImage;
    
    UIImageView *_pointerImage;
    
    BOOL _animation;
    
}

@end

@implementation QCLoadingHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.8];
        
        _outsideImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(32), frame.size.height/2-Height320(32), Height320(64), Width320(64))];
        
        _outsideImage.image = [UIImage imageNamed:@"ic_loading_outside"];
        
        [self addSubview:_outsideImage];
        
        _pointerImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(13.5), frame.size.height/2-Height320(9), Width320(27), Height320(27))];
        
        _pointerImage.image = [UIImage imageNamed:@"ic_loading_pointer"];
        
        [self addSubview:_pointerImage];
        
    }
    return self;
}

+(QCLoadingHUD *)defaultHUDInView:(UIView *)view
{
    
    QCLoadingHUD *hud = [[QCLoadingHUD alloc]initWithFrame:CGRectMake(view.frame.size.width/2-Width320(50), view.frame.size.height/2-Height320(50), Width320(100), Height320(100))];
    
    hud.hidden = YES;
    
    return hud;
    
}

-(void)loading
{
    
    _animation = YES;
    
    [self.superview bringSubviewToFront:self];
    
    [self startAnimation];
    
    self.hidden = NO;
    
}

-(void)startAnimation
{
    
    if (_animation) {
        
        CABasicAnimation *animation = [CABasicAnimation
                                       animationWithKeyPath:@"transform"];
        
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        
        animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI*(179.0f/180.0f), 0, 0, 1.0) ];
        animation.duration = 0.4;
        
        animation.cumulative = YES;
        animation.repeatCount = 2;
        
        [_pointerImage.layer addAnimation:animation forKey:@"transform"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self startAnimation];
            
        });
        
    }else{
        
        [_pointerImage.layer removeAnimationForKey:@"transform"];
        
    }
    
}

-(void)stopLoading
{
    
    _animation = NO;
    
    [_pointerImage.layer removeAnimationForKey:@"transform"];
    
    self.hidden = YES;
    
}

-(void)dealloc
{
    
    _animation = NO;
    
    [UIView beginAnimations:@"QCLoadingHUDAnimation" context:nil];
    
    [UIView setAnimationDelegate:nil];
    
    [UIView setAnimationDidStopSelector:nil];
    
    [UIView commitAnimations];
    
}

@end
