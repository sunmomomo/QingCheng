//
//  MOActionSheet.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/9.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOActionSheet.h"

#define kAnimationTime 0.2f

#define kActionHeight Height320(40)

#define kActionGap Height320(5)

#define kTitleHeight Height320(30)

#define kTitleFont AllFont(12)

#define kActionFont AllFont(17)

#define kDestructiveColor UIColorFromRGB(0xEA6161)

@interface MOActionSheet ()

{
    
    UIView *_bottomView;
    
    UIButton *_cancelButton;
    
    UIView *_backView;
    
}

@property(nonatomic,strong)NSArray<NSString*> *actions;

@property(nonatomic,copy)NSString *cancelTitle;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *destructiveTitle;

@end

@implementation MOActionSheet

+(nullable instancetype)actionSheetWithTitie:(nullable NSString*)title delegate:(nonnull id<MOActionSheetDelegate>)delegate destructiveButtonTitle:(nullable NSString *)destructiveTitle cancelButtonTitle:(nullable NSString *)cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    MOActionSheet *actionSheet = [[[self class]alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    NSMutableArray *titles = [NSMutableArray array];
    
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
    {
        
        [titles addObject:arg];
        
    }
    va_end(args);
    
    actionSheet.actions = titles;
    
    actionSheet.title = title;
    
    actionSheet.destructiveTitle = destructiveTitle;
    
    actionSheet.delegate = delegate;
    
    actionSheet.cancelTitle = cancelTitle;
    
    [actionSheet load];
    
    return actionSheet;
    
}

-(void)load
{
    
    _backView = [[UIView alloc]initWithFrame:self.frame];
    
    _backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.6];
    
    [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap)]];
    
    [self addSubview:_backView];
    
    CGFloat high = 0;
    
    high += self.title.length?kTitleHeight:0;
    
    high += self.destructiveTitle?kActionHeight:0;
    
    high += self.actions.count*kActionHeight;
    
    high += self.cancelTitle?kActionGap:0;
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, high)];
    
    _bottomView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    _bottomView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    _bottomView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self addSubview:_bottomView];
    
    if (self.title.length) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, kTitleHeight)];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.backgroundColor = UIColorFromRGB(0xffffff);
        
        label.text = self.title;
        
        label.textColor = UIColorFromRGB(0xbbbbbb);
        
        label.font = kTitleFont;
        
        [_bottomView addSubview:label];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, label.height-OnePX, MSW, OnePX)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_bottomView addSubview:sep];
        
    }
    
    if (self.destructiveTitle) {
        
        CGFloat top = self.title.length?kTitleHeight:0;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, top, MSW, kActionHeight)];
        
        button.backgroundColor = UIColorFromRGB(0xffffff);
        
        [button setTitle:self.destructiveTitle forState:UIControlStateNormal];
        
        [button setTitleColor:kDestructiveColor forState:UIControlStateNormal];
        
        button.titleLabel.font = kActionFont;
        
        button.tag = 0;
        
        [_bottomView addSubview:button];
        
        if (_actions.count) {
            
            UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, button.bottom-OnePX, MSW, OnePX)];
            
            sep.backgroundColor = UIColorFromRGB(0xdddddd);
            
            [_bottomView addSubview:sep];
            
        }
        
        [button addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    for (NSInteger i = 0;i<_actions.count;i++) {
        
        CGFloat top = self.title.length?kTitleHeight:0;
        
        if (self.destructiveTitle) {
            
            top += kActionHeight;
            
        }
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*kActionHeight+top, MSW, kActionHeight)];
        
        button.backgroundColor = UIColorFromRGB(0xffffff);
        
        [button setTitle:_actions[i] forState:UIControlStateNormal];
        
        [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        
        button.titleLabel.font = kActionFont;
        
        button.tag = i+1;
        
        [_bottomView addSubview:button];
        
        [button addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i<_actions.count-1) {
            
            UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, button.bottom-OnePX, MSW, OnePX)];
            
            sep.backgroundColor = UIColorFromRGB(0xdddddd);
            
            [_bottomView addSubview:sep];
            
        }
        
    }
    
    if (_cancelTitle.length) {
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, _bottomView.bottom, MSW, kActionHeight)];
        
        _cancelButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        _cancelButton.tag = -1;
        
        _cancelButton.titleLabel.font = kActionFont;
        
        [_cancelButton setTitle:_cancelTitle forState:UIControlStateNormal];
        
        [_cancelButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_cancelButton];
        
    }
    
}

-(void)backTap
{
    
    [self dismissWithIndex:-1];
    
}

-(void)actionClick:(UIButton*)button
{
    
    [self dismissWithIndex:button.tag];
    
}

-(void)dismissWithIndex:(NSInteger)index
{
    
    [self.delegate actionSheet:self didDismissWithButtonIndex:index];
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        
        [_bottomView changeTop:MSH];
        
        if (_cancelTitle.length) {
            
            [_cancelButton changeTop:_bottomView.bottom+kActionGap];
        
        }
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

-(void)show
{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        
        [_bottomView changeTop:_cancelTitle.length?MSH-_bottomView.height-kActionHeight:MSH-_bottomView.height];
        
        if (_cancelTitle.length) {
            
            [_cancelButton changeTop:MSH-kActionHeight];
        
        }
        
    }];
    
}

@end
