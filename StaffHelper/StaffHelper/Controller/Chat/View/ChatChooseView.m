//
//  ChatChooseView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChooseView.h"

@interface ChatChooseView ()

{
    
    UILabel *_numberLabel;
    
}

@end

@implementation ChatChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        self.layer.shadowOpacity =0.06;
        
        self.layer.shadowOffset = CGSizeMake(0, -2);
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(12), Width(26), Height(26))];
        
        _numberLabel.layer.cornerRadius = _numberLabel.width/2;
        
        _numberLabel.layer.masksToBounds = YES;
        
        _numberLabel.backgroundColor = kMainColor;
        
        _numberLabel.textColor = UIColorFromRGB(0xffffff);
        
        _numberLabel.font = AllFont(13);
        
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_numberLabel];
        
        CGSize size = [@"已选择" boundingRectWithSize:CGSizeMake(MAXFLOAT,Height(20)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
        
        UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(_numberLabel.right+Width(6), 0, size.width+Width(6)+Width(12), self.frame.size.height)];
        
        [showButton addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:showButton];
        
        UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(_numberLabel.right+Width(8), Height(15), size.width, Height(20))];
        
        chooseLabel.text = @"已选择";
        
        chooseLabel.textColor = UIColorFromRGB(0x333333);
        
        chooseLabel.font = AllFont(13);
        
        [self addSubview:chooseLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(chooseLabel.right+Width(6), Height(21), Width(12), Height(7))];
        
        arrowImg.image = [UIImage imageNamed:@"down_arrow"];
        
        arrowImg.transform = CGAffineTransformMakeRotation(M_PI);
        
        [self addSubview:arrowImg];
        
        UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width(85), Height(8), Width(70), Height(34))];
        
        confirmButton.layer.cornerRadius = Width(2);
        
        confirmButton.backgroundColor = kMainColor;
        
        confirmButton.titleLabel.font = AllFont(14);
        
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:confirmButton];
        
    }
    
    return self;
    
}

-(void)setChooseNumber:(NSInteger)chooseNumber
{
    
    _chooseNumber = chooseNumber;
    
    _numberLabel.text = [NSString stringWithInteger:_chooseNumber];
    
}

-(void)show
{
    
    if ([self.delegate  respondsToSelector:@selector(showChooseView)]) {
        
        [self.delegate showChooseView];
        
    }
    
}

-(void)confirm
{
    
    if ([self.delegate respondsToSelector:@selector(chooseViewConfirm)]) {
        
        [self.delegate chooseViewConfirm];
        
    }
    
}

@end
