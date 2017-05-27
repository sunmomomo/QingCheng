//
//  MOMenuView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/6.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOMenuView.h"

#define kAnimationTime 0.2f

#define kActionHeight Height320(44)

#define kActionGap Height320(5)

#define kTitleHeight Height320(20)

#define kTitleFont AllFont(14)

#define kActionFont AllFont(14)

#define kCancelFont AllFont(16)

#define kDestructiveColor UIColorFromRGB(0xEA6161)

@interface MOMenuView ()

{
    
    UIView *_bottomView;
    
    UIButton *_cancelButton;
    
    UIView *_backView;
    
    NSMutableArray *_buttons;
    
}

@property(nonatomic,strong)NSArray<NSString*> *actions;

@property(nonatomic,copy)NSString *cancelTitle;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *destructiveTitle;

@end

@implementation MOMenuView

+(nullable instancetype)menuWithTitie:(nullable NSString*)title delegate:(nonnull id<MOMenuDelegate>)delegate destructiveButtonTitle:(nullable NSString *)destructiveTitle cancelButtonTitle:(nullable NSString *)cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    MOMenuView *actionSheet = [[[self class]alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
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
    
    _buttons = [NSMutableArray array];
    
    [self addSubview:_backView];
    
    CGFloat high = 0;
    
    high += self.title.length?kTitleHeight:0;
    
    high += self.destructiveTitle?kActionHeight:0;
    
    high += self.actions.count*kActionHeight;
    
    high += self.cancelTitle?kActionGap:0;
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, high)];
    
    _bottomView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _bottomView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    _bottomView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self addSubview:_bottomView];
    
    if (self.title.length) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, kTitleHeight)];
        
        label.backgroundColor = UIColorFromRGB(0xffffff);
        
        label.text = self.title;
        
        label.textColor = UIColorFromRGB(0x222222);
        
        label.font = kTitleFont;
        
        [_bottomView addSubview:label];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, label.height-1, MSW, 1)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_bottomView addSubview:sep];
        
    }
    
    if (self.destructiveTitle) {
        
        CGFloat top = self.title.length?kTitleHeight:0;
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), top, MSW-Width320(24), kActionHeight)];
        
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
        
        [_buttons addObject:button];
        
    }
    
    for (NSInteger i = 0;i<_actions.count;i++) {
        
        CGFloat top = self.title.length?kTitleHeight:0;
        
        if (self.destructiveTitle) {
            
            top += kActionHeight;
            
        }
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), i*kActionHeight+top, MSW-Width320(24), kActionHeight)];
        
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
        
        [_buttons addObject:button];
        
    }
    
    if (_cancelTitle.length) {
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, _bottomView.bottom, MSW, kActionHeight)];
        
        _cancelButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        _cancelButton.tag = -1;
        
        _cancelButton.titleLabel.font = kCancelFont;
        
        [_cancelButton setTitle:_cancelTitle forState:UIControlStateNormal];
        
        [_cancelButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_cancelButton];
        
    }
    
}

-(void)backTap
{
    
    [self close];
    
}

-(void)actionClick:(UIButton*)button
{
    
    [self dismissWithIndex:button.tag];
    
    [self close];
    
}

-(void)dismissWithIndex:(NSInteger)index
{
    
    [self.delegate actionSheet:self didDismissWithButtonIndex:index];
    
}

-(void)close
{
    
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

-(void)setTextAlignment:(UIControlContentHorizontalAlignment)textAlignment
{
    
    _textAlignment = textAlignment;
    
    for (UIButton *button in _buttons) {
        
        button.contentHorizontalAlignment = textAlignment;
        
    }
    
    _cancelButton.contentHorizontalAlignment = textAlignment;
    
}

@end
