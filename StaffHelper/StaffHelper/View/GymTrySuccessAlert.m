//
//  GymTrySuccessAlert.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymTrySuccessAlert.h"

@interface GymTrySuccessAlert ()

{
    
    UILabel *_contentLabel;
    
}

@end

@implementation GymTrySuccessAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColorFromRGB(0x000000)colorWithAlphaComponent:0.4];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(129), Height320(200), Width320(258), Height320(154))];
        
        contentView.layer.cornerRadius = Width320(2);
        
        contentView.layer.masksToBounds = YES;
        
        contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:contentView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(17), contentView.width, Height320(20))];
        
        titleLabel.text = @"升级成功";
        
        titleLabel.textColor = UIColorFromRGB(0x333333);
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        titleLabel.font = AllFont(16);
        
        [contentView addSubview:titleLabel];
        
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:Height320(6)];
        
        CGSize size = [@"成功升级到高级版\n有效期至：\n快去探索高级版的强大功能吧！" boundingRectWithSize:CGSizeMake(contentView.width,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+Height320(10), contentView.width, size.height)];
        
        _contentLabel.textColor = UIColorFromRGB(0x999999);
        
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        
        _contentLabel.font = AllFont(13);
        
        _contentLabel.numberOfLines = 0;
        
        [contentView addSubview:_contentLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, contentView.height-Height320(40)-OnePX, contentView.width, OnePX)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [contentView addSubview:sep];
        
        UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(0, sep.bottom, contentView.width, Height320(40))];
        
        [startButton setTitle:@"开始" forState:UIControlStateNormal];
        
        [startButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        startButton.titleLabel.font = AllFont(16);
        
        [contentView addSubview:startButton];
        
        [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)startClick
{
    
    [self close];
    
    [self.delegate trySuccessAlertStart];
    
}

-(void)close
{
    
    self.hidden = YES;
    
    [self removeFromSuperview];
    
}

+(instancetype)defaultAlert
{
    
    return [[self alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
}

-(void)setGymName:(NSString *)gymName
{
    
    _gymName = gymName;
    
    if (_systemEnd) {
        
        [self loadContent];
        
    }
    
}

-(void)setSystemEnd:(NSString *)systemEnd
{
    
    _systemEnd = systemEnd;
    
    if (_gymName) {
        
        [self loadContent];
        
    }
    
}

-(void)loadContent
{
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@成功升级到高级版\n有效期至：%@\n快去探索高级版的强大功能吧！",_gymName,_systemEnd]];
    
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    
    attach.image = [[UIImage imageNamed:@"gym_pro_img"]imageWithTintColor:UIColorFromRGB(0x999999)];
    
    attach.bounds = CGRectMake(0, 0, Width320(18), Height320(10));
    
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attach];
    
    [astr insertAttributedString:str atIndex:_gymName.length+8];
    
    [astr insertAttributedString:str atIndex:astr.length-7];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:Height320(6)];
    
    [astr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [astr length])];
    
    _contentLabel.attributedText = astr;
    
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void)showInView:(UIView *)view
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
}

@end
