//
//  QCKeyboardView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "QCKeyboardView.h"

@interface QCKeyboardView ()

@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,strong)UIButton *confirmBtn;

@end

@implementation QCKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if(self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 39)];
        
        topView.backgroundColor = UIColorFromRGB(0xe6e6e6);
        
        [self addSubview:topView];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.cancelBtn.frame = CGRectMake(0, 0, 85, topView.height);
        
        self.cancelBtn.backgroundColor = [UIColor clearColor];
        
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        self.cancelBtn.layer.cornerRadius = 1;
        
        self.cancelBtn.layer.masksToBounds = YES;
        
        [self.cancelBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        
        self.cancelBtn.hidden = YES;
        
        [self.cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
        self.cancelBtn.titleLabel.font = STFont(15);
        
        [topView addSubview:self.cancelBtn];
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.confirmBtn.frame = CGRectMake(MSW-self.cancelBtn.width, 0, self.cancelBtn.width, self.cancelBtn.height);
        
        self.confirmBtn.backgroundColor = self.cancelBtn.backgroundColor;
        
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        self.confirmBtn.layer.cornerRadius = 1;
        
        self.confirmBtn.layer.masksToBounds = YES;
        
        [self.confirmBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        
        [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        
        self.confirmBtn.titleLabel.font = STFont(15);
        
        [topView addSubview:self.confirmBtn];
        
    }
    
    return self;
    
}

-(void)setHaveCancel:(BOOL)haveCancel
{
    
    self.cancelBtn.hidden = !haveCancel;
    
}

-(void)setKeyboard:(UIView *)keyboard
{
    
    [keyboard changeTop:39];
    
    [self addSubview:keyboard];
    
}

-(void)confirm:(UIButton*)btn
{
    
    if ([self.delegate respondsToSelector:@selector(keyboardConfirm:)]) {
        
        [self.delegate keyboardConfirm:self];
        
    }
    
}

-(void)cancel:(UIButton*)btn
{
    
    [self.delegate keyboardCancel:self];
    
}

+(QCKeyboardView *)defaultKeboardView
{
    
    return [[[self class]alloc]initWithFrame:CGRectMake(0, 0, MSW, 216)];
    
}

@end
