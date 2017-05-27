//
//  YFQrCodePopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFQrCodePopView.h"

#import "UIView+lineViewYF.h"

@implementation YFQrCodePopView
{
    UIImageView *_qrcodeImgView;
    
    UIImage *_qrcodeImg;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(Width(36), Height(173), Width(303), Height(322))];
        
        contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        contentView.layer.cornerRadius = Width320(2);
        
        contentView.layer.masksToBounds = YES;
        
        [self addSubview:contentView];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height(20), contentView.width, Height(24))];
        
        topLabel.text = @"报名二维码";
        
        topLabel.textColor = YFCellTitleColor;
        
        topLabel.textAlignment = NSTextAlignmentCenter;
        
        topLabel.font = FontSizeFY(Width(17));
        
        [contentView addSubview:topLabel];

        
        
        UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(Width(98), Height(241), Width(180), Height(180))];
        
        borderView.backgroundColor = UIColorFromRGB(0xffffff);
        
        borderView.layer.borderWidth = OnePX;
        
        borderView.layer.borderColor = YFLineViewColor.CGColor;
        
        [self addSubview:borderView];

        
        UIImageView *qcCodeIV = [[UIImageView alloc]initWithFrame:CGRectMake(Width(107), Height(250), Width(162), Height(162))];
        

        _qrcodeImgView = qcCodeIV;
        
        [self addSubview:qcCodeIV];
        
        CGFloat bH = Height(50);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(0, contentView.height - bH, contentView.width, bH);

        button.backgroundColor = [UIColor whiteColor];

        [button setTitle:@"保存到系统相册" forState:UIControlStateNormal];
        
        [button setTitleColor:YFThreeChartDeColor forState:UIControlStateNormal];

        [button.titleLabel setFont:FontSizeFY(Width(17))];
        
        [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [contentView addSubview:button];
        
        [button addLinewViewToTop];
    }
    return self;
}

-(void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    
    _qrcodeImg = [UIImage qrImageForString:urlString imageSize:Width320(130) logoImageSize:0];
    
    _qrcodeImgView.image = _qrcodeImg;
}

- (void)saveAction:(id)sender
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


@end
