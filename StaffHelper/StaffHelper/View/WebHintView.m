//
//  WebHintView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "WebHintView.h"

@interface WebHintView ()

{
    
}

@end

@implementation WebHintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.5];
        
    }
    
    return self;
    
}

-(void)contentHide
{
    
    self.hidden = YES;
    
}

-(void)setHintURL:(NSURL *)hintURL
{
    
    _hintURL = hintURL;
    
    [self load];
    
}

-(void)load
{
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(24, MSH/2-Height320(176), MSW-48, Height320(366))];
    
    contentView.layer.cornerRadius = 2;
    
    contentView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self addSubview:contentView];
    
    UILabel *contentTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, contentView.width, Height320(52))];
    
    contentTop.text = @"微信约课";
    
    contentTop.textColor = kMainColor;
    
    contentTop.textAlignment = NSTextAlignmentCenter;
    
    contentTop.font = AllFont(14);
    
    contentTop.userInteractionEnabled = YES;
    
    contentTop.backgroundColor = [kMainColor colorWithAlphaComponent:0.09];
    
    [contentView addSubview:contentTop];
    
    UIImageView *firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(14), contentTop.bottom+Height320(8), Width320(18), Height320(36))];
    
    firstImg.image = [UIImage imageNamed:@"web_hint_1"];
    
    [contentView addSubview:firstImg];
    
    NSString *str = [NSString stringWithFormat:@"复制会员端页面链接 %@",self.hintURL.absoluteString];
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(contentView.width-firstImg.left-Width320(16), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstImg.right+Width320(8), contentTop.bottom+Width320(15), contentView.width-firstImg.right-Width320(16), size.height)];
    
    firstLabel.numberOfLines = 0;
    
    firstLabel.textColor = UIColorFromRGB(0x666666);
    
    firstLabel.font = AllFont(13);
    
    firstLabel.text = str;
    
    [contentView addSubview:firstLabel];
    
    NSString *buttonStr = @"复制链接到剪贴板";
    
    CGSize buttonSize = [buttonStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    UIButton *copyButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(26), firstLabel.bottom+Height320(6), buttonSize.width+Width320(24), Height320(20))];
    
    [copyButton setTitle:@"复制链接到剪贴板" forState:UIControlStateNormal];
    
    [copyButton setTitleColor:UIColorFromRGB(0x6EB8F1) forState:UIControlStateNormal];
    
    copyButton.titleLabel.font = AllFont(13);
    
    [contentView addSubview:copyButton];
    
    [copyButton addTarget:self action:@selector(copyLink) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *firstSep = [[UIView alloc]initWithFrame:CGRectMake(0, copyButton.bottom+Height320(18), contentView.width, 1/[UIScreen mainScreen].scale)];
    
    firstSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [contentView addSubview:firstSep];
    
    UIImageView *secondImg = [[UIImageView alloc]initWithFrame:CGRectMake(firstImg.left, copyButton.bottom+Height320(27), Width320(18), Height320(36))];
    
    secondImg.image = [UIImage imageNamed:@"web_hint_2"];
    
    [contentView addSubview:secondImg];
    
    NSString *secStr = @"将链接添加到健身房微信公众号的菜单栏";
    
    CGSize secSize = [secStr boundingRectWithSize:CGSizeMake(contentView.width-firstImg.left-Width320(16), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, copyButton.bottom+Height320(37), firstLabel.width, secSize.height)];
    
    secondLabel.text = secStr;
    
    secondLabel.numberOfLines = 0;
    
    secondLabel.textColor = UIColorFromRGB(0x666666);
    
    secondLabel.font = AllFont(13);
    
    [contentView addSubview:secondLabel];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(42), secondLabel.bottom+Height320(10), contentView.width-Width320(58), Height320(59))];
    
    image.image = [UIImage imageNamed:@"hint_image"];
    
    [contentView addSubview:image];
    
    UIView *secondSep = [[UIView alloc]initWithFrame:CGRectMake(0, image.bottom+Height320(18), contentView.width, 1/[UIScreen mainScreen].scale)];
    
    secondSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [contentView addSubview:secondSep];
    
    UIImageView *thirdImg = [[UIImageView alloc]initWithFrame:CGRectMake(firstImg.left, image.bottom+Height320(27), Width320(18), Height320(36))];
    
    thirdImg.image = [UIImage imageNamed:@"web_hint_3"];
    
    [contentView addSubview:thirdImg];
    
    NSString *thirdStr = @"会员关注健身房的微信公众号，即可购买会员卡、预约课程";
    
    CGSize thirdSize = [thirdStr boundingRectWithSize:CGSizeMake(contentView.width-firstImg.left-Width320(16), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, image.bottom+Height320(37), firstLabel.width, thirdSize.height)];
    
    thirdLabel.text = thirdStr;
    
    thirdLabel.numberOfLines = 0;
    
    thirdLabel.textColor = UIColorFromRGB(0x666666);
    
    thirdLabel.font = AllFont(13);
    
    [contentView addSubview:thirdLabel];
    
    UIView *thirdSep = [[UIView alloc]initWithFrame:CGRectMake(0, thirdLabel.bottom+Height320(18), contentView.width, 1/[UIScreen mainScreen].scale)];
    
    thirdSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [contentView addSubview:thirdSep];
    
    UIButton *detailButton = [[UIButton alloc]initWithFrame:CGRectMake(contentView.width/2-Width320(40), thirdSep.bottom+Height320(8), Width320(80), Height320(20))];
    
    [detailButton setTitle:@"详细教程  >>" forState:UIControlStateNormal];
    
    [detailButton setTitleColor:UIColorFromRGB(0x6EB8F1) forState:UIControlStateNormal];
    
    detailButton.titleLabel.font = AllFont(14);
    
    [contentView addSubview:detailButton];
    
    [detailButton addTarget:self.delegate action:@selector(showDetailHint) forControlEvents:UIControlEventTouchUpInside];
    
    [contentView changeHeight:detailButton.bottom+Height320(10)];
    
    [contentView changeTop:MSH/2-contentView.height/2];
    
    UIButton *hintCloseButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-52, 30, 30, 30)];
    
    hintCloseButton.layer.cornerRadius = hintCloseButton.width/2;
    
    hintCloseButton.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.9];
    
    [self addSubview:hintCloseButton];
    
    [hintCloseButton addTarget:self action:@selector(contentHide) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *buttonImg = [[UIImageView alloc]initWithFrame:CGRectMake(9, 9, 12, 12)];
    
    buttonImg.image = [UIImage imageNamed:@"hint_close"];
    
    [hintCloseButton addSubview:buttonImg];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(hintCloseButton.center.x, hintCloseButton.bottom, 1, contentView.top-hintCloseButton.bottom)];
    
    line.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self addSubview:line];
    
}

-(void)copyLink
{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = self.hintURL.absoluteString;
    
    [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}

@end
