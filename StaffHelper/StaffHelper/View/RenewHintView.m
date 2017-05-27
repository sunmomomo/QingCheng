//
//  RenewHintView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "RenewHintView.h"

@interface RenewHintView ()

{
    
    UILabel *_contentLabel;
    
}

@end

@implementation RenewHintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.5];
        
        UIView *touchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [touchView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentHide)]];
        
        [self addSubview:touchView];
        
        [self load];
        
    }
    return self;
}

-(void)load
{
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(136), MSH/2-Height320(140), Width320(272), Height320(142))];
    
    contentView.layer.cornerRadius = Width320(2);
    
    contentView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self addSubview:contentView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(17), contentView.width, Height320(20))];
    
    titleLabel.textColor = UIColorFromRGB(0x333333);
    
    titleLabel.font = AllFont(16);
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:@"高级版即将到期"];
    
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    
    attach.image = [UIImage imageNamed:@"gym_pro_img"];
    
    attach.bounds = CGRectMake(0, 0, Width320(20), Height320(12));
    
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attach];
    
    [astr insertAttributedString:str atIndex:3];
    
    titleLabel.attributedText = astr;
    
    [contentView addSubview:titleLabel];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:Height320(6)];
    
    CGSize size = [@"高级版将于到期\n请及时续费以免影响使用" boundingRectWithSize:CGSizeMake(contentView.width,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+Height320(10), contentView.width, size.height)];
    
    _contentLabel.textColor = UIColorFromRGB(0x999999);
    
    _contentLabel.font = AllFont(13);
    
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    
    _contentLabel.numberOfLines = 0;
    
    [contentView addSubview:_contentLabel];
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, contentView.height-Height320(40), contentView.width/2, Height320(40))];
    
    closeButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    closeButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    closeButton.layer.borderWidth = OnePX;
    
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    
    [closeButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    
    closeButton.titleLabel.font = AllFont(14);
    
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [contentView addSubview:closeButton];
    
    UIButton *renewButton = [[UIButton alloc]initWithFrame:CGRectMake(contentView.width/2, contentView.height-Height320(40), contentView.width/2, Height320(40))];
    
    renewButton.backgroundColor = kMainColor;
    
    [renewButton setTitle:@"续费" forState:UIControlStateNormal];
    
    [renewButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    renewButton.titleLabel.font = AllFont(14);
    
    [renewButton addTarget:self.delegate action:@selector(renewConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    [contentView addSubview:renewButton];
    
}

-(void)renewConfirm
{
    
    [self.delegate renewConfirm];
    
}

-(void)contentHide
{
    
    self.hidden = YES;
    
}

-(void)setSystemEnd:(NSString *)systemEnd
{
    
    _systemEnd = systemEnd;
    
    NSMutableAttributedString *contentAstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"高级版将于%@到期\n请及时续费以免影响使用",self.systemEnd]];
    
    NSTextAttachment *contentAttach = [[NSTextAttachment alloc]init];
    
    contentAttach.image = [[UIImage imageNamed:@"gym_pro_img"]imageWithTintColor:UIColorFromRGB(0x999999)];
    
    contentAttach.bounds = CGRectMake(0, 0, Width320(18), Height320(10));
    
    NSAttributedString *contentStr = [NSAttributedString attributedStringWithAttachment:contentAttach];
    
    [contentAstr insertAttributedString:contentStr atIndex:3];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:Height320(6)];
    
    [contentAstr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentAstr length])];
    
    _contentLabel.attributedText = contentAstr;
    
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void)close
{
    
    self.hidden = YES;
    
}

@end
