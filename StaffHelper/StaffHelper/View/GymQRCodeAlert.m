//
//  GymQRCodeAlert.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/20.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymQRCodeAlert.h"

@interface GymQRCodeAlert ()

{
    
    UIImageView *_qrcodeImgView;
    
    UILabel *_gymLabel;
    
    UIImage *_qrcodeImg;
    
    UILabel *_topLabel;
    
}

@end

@implementation GymQRCodeAlert
{
    UIButton *_saveButton;
    UIView *_contentView;
}
+(instancetype)defaultAlert
{
    
    return [[self alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColorFromRGB(0x000000)colorWithAlphaComponent:0.4];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(129), Height320(143), Width320(258), Height320(300))];
        
        _contentView = contentView;
        
        contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        contentView.layer.cornerRadius = Width320(2);
        
        contentView.layer.masksToBounds = YES;
        
        [self addSubview:contentView];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(16), contentView.width, Height320(20))];
        
        _topLabel = topLabel;
        
        topLabel.text = @"会员端页面二维码";
        
        topLabel.textColor = UIColorFromRGB(0x333333);
        
        topLabel.textAlignment = NSTextAlignmentCenter;
        
        topLabel.font = AllFont(16);
        
        [contentView addSubview:topLabel];
        
        UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(contentView.width-Width320(31), 0, Width320(31), Height320(31))];
        
        [contentView addSubview:closeButton];
        
        [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *closeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(11), Height320(11))];
        
        closeImg.image = [UIImage imageNamed:@"black_close"];
        
        [closeButton addSubview:closeImg];
        
        UIView *qrcodeBack = [[UIView alloc]initWithFrame:CGRectMake(contentView.width/2-Width320(75), topLabel.bottom+Height320(20), Width320(150), Height320(150))];
        
        qrcodeBack.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        qrcodeBack.layer.borderWidth = OnePX;
        
        [contentView addSubview:qrcodeBack];
        
        _qrcodeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(130), Height320(130))];
        
        [qrcodeBack addSubview:_qrcodeImgView];
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, qrcodeBack.bottom+Height320(12), contentView.width, Height320(16))];
        
        _gymLabel.textColor = UIColorFromRGB(0x999999);
        
        _gymLabel.textAlignment = NSTextAlignmentCenter;
        
        _gymLabel.font = AllFont(13);
        
        [contentView addSubview:_gymLabel];
        
        UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(0, contentView.height-Height320(40), contentView.width, Height320(40))];
        
        saveButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        saveButton.layer.borderWidth = OnePX;
        
        saveButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        [saveButton setTitle:@"保存到系统相册" forState:UIControlStateNormal];
        
        [saveButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        saveButton.titleLabel.font = AllFont(16);
        
        _saveButton = saveButton;
        
        [contentView addSubview:saveButton];
        
        [saveButton addTarget:self action:@selector(saveCode) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)setUrlString:(NSString *)urlString
{
    
    _urlString = urlString;
    
    _qrcodeImg = [UIImage qrImageForString:urlString imageSize:Width320(130) logoImageSize:0];
    
    _qrcodeImgView.image = _qrcodeImg;
    
}

-(void)setGymName:(NSString *)gymName
{
    if (gymName.length)
    {
        _gymLabel.hidden = NO;
        
        [_contentView changeHeight:Width320(290)];
    }else
    {
        _gymLabel.hidden = YES;
        
        [_contentView changeHeight:Width320(274)];
    }
    
    _gymName = gymName;
    _gymLabel.text = _gymName;
    
    
    
    _saveButton.frame = CGRectMake(0, _contentView.height-Height320(40), _contentView.width, Height320(40));
    

}

- (void)setTopTitleName:(NSString *)topTitleName
{
    _topTitleName = topTitleName;
    
    _topLabel.text = _topTitleName;
}

-(void)saveCode
{
    
    [self close];
    
    UIImageWriteToSavedPhotosAlbum(_qrcodeImg, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (!error) {
        
        [[[UIAlertView alloc]initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",error] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)show
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
}

-(void)close
{
    
    [self removeFromSuperview];
    
}

@end
