//
//  ShareActionSheet.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ShareActionSheet.h"

#import "SensorsAnalyticsSDK.h"

#define kAnimationTime 0.2f

@interface ShareButton ()

{
    
    UIImageView *_imgView;
    
    UILabel *_label;
    
}

@end

@implementation ShareButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, Height320(29.3))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.userInteractionEnabled = NO;
        
        [self addSubview:_imgView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.bottom+Height320(7.5), self.width, Height320(17.3))];
        
        _label.textColor = UIColorFromRGB(0x666666);
        
        _label.font = STFont(14);
        
        _label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_label];
        
    }
    
    return self;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imgView.image = _image;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _label.text = _title;
    
}

@end

@interface ShareActionSheet ()

{
    
    UIView *_bottomView;
    
}

@end

@implementation ShareActionSheet

-(instancetype)init
{
    
    if (self = [super init]) {

        self.frame = CGRectMake(0, 0, MSW, MSH);
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        topView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [self addSubview:topView];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height320(164)+1)];
        
        _bottomView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:_bottomView];
        
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(120))];
        
        buttonView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [_bottomView addSubview:buttonView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(33), Height320(15), Width320(200), Height320(17))];
        
        label.textColor = UIColorFromRGB(0x666666);
        
        label.text = @"分享到";
        
        label.font = STFont(14);
        
        [buttonView addSubview:label];
        
        ShareButton *wechatBtn = [[ShareButton alloc]initWithFrame:CGRectMake(Width320(27), label.bottom+Height320(21.7), Width320(60), Height320(55))];
        
        wechatBtn.image = [UIImage imageNamed:@"wechat"];
        
        wechatBtn.title = @"微信";
        
        wechatBtn.tag = 1;
        
        [wechatBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:wechatBtn];
        
        ShareButton *friendBtn = [[ShareButton alloc]initWithFrame:CGRectMake(wechatBtn.right+Width320(48), wechatBtn.top, wechatBtn.width, wechatBtn.height)];
        
        friendBtn.image = [UIImage imageNamed:@"friend"];
        
        friendBtn.title = @"朋友圈";
        
        friendBtn.tag = 2;
        
        [friendBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:friendBtn];
        
        ShareButton *linkBtn = [[ShareButton alloc]initWithFrame:CGRectMake(friendBtn.right+Width320(48),wechatBtn.top, wechatBtn.width, wechatBtn.height)];
        
        linkBtn.image = [UIImage imageNamed:@"copy_link"];
        
        linkBtn.title = @"复制链接";
        
        linkBtn.tag = 3;
        
        [linkBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:linkBtn];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, buttonView.bottom, MSW, 1)];
        
        sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [_bottomView addSubview:sep];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        cancelButton.frame = CGRectMake(0, buttonView.bottom+1, MSW, Height320(44));
        
        cancelButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [cancelButton setTitle:@"取  消" forState:UIControlStateNormal];
        
        [cancelButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:cancelButton];
        
    }
    
    return self;
    
}

-(void)show
{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        
        [_bottomView changeTop:_bottomView.top-Height320(164)-1];
        
    }];
    
}

-(void)dismiss
{
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        
        [_bottomView changeTop:_bottomView.top+Height320(164)+1];
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        
    }];
        
}

-(void)btnClick:(UIButton*)btn
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:self.content forKey:@"content"];
    
    [dict setValue:self.title forKey:@"title"];
    
    if (self.imageName) {
        
        [dict setValue:self.imageName forKey:@"imageName"];
        
    }
    
    if (self.imgURL) {
        
        [dict setValue:self.imgURL forKey:@"imgURL"];
        
    }
    
    [dict setValue:self.url forKey:@"link"];
    
    [WXAPIManager sharedManager].delegate = self.delegate;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.title forKey:@"qc_page_title"];
    
    [para setParameter:self.url forKey:@"qc_page_url"];
    
    [para setParameter:@"0" forKey:@"qc_sharesuccess"];
    
    if (btn.tag == 1) {
        
        [para setParameter:@"qc_sharetofriends" forKey:@"qc_share_channel"];
        
        if (![WXApi isWXAppInstalled]) {
            
            [[[UIAlertView alloc]initWithTitle:@"尚未安装微信" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        [[SensorsAnalyticsSDK sharedInstance]track:@"page_share" withProperties:para.data];
        
        [[WXAPIManager sharedManager]shareWithParameters:dict andScene:0];
        
    }else if (btn.tag == 2)
    {
        
        [para setParameter:@"qc_moments" forKey:@"qc_share_channel"];
        
        if (![WXApi isWXAppInstalled]) {
            
            [[[UIAlertView alloc]initWithTitle:@"尚未安装微信" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        [[SensorsAnalyticsSDK sharedInstance]track:@"page_share" withProperties:para.data];
        
        [[WXAPIManager sharedManager]shareWithParameters:dict andScene:1];
        
    }else if (btn.tag == 3){
        
        [para setParameter:@"qc_copyurl" forKey:@"qc_share_channel"];
        
        [[SensorsAnalyticsSDK sharedInstance]track:@"page_share" withProperties:para.data];
        
        if (self.url.length) {
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
            pasteboard.string = self.url;
            
            [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
        [para setParameter:@"1" forKey:@"qc_sharesuccess"];
        
        [[SensorsAnalyticsSDK sharedInstance]track:@"page_share" withProperties:para.data];
        
    }
    
    [self dismiss];
    
}




@end
