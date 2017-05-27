//
//  GymProHintView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymProHintView.h"

#import "GymDetailInfo.h"

@interface GymProHintView ()

{
    
    UILabel *_titleLabel;
    
    UIButton *_lookButton;
    
    UIButton *_tryButton;
    
    UIView *_view;
    
}

@end

@implementation GymProHintView

+(instancetype)defaultView
{
    
    return [[self alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        tapView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [self addSubview:tapView];
        
        [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(129), Height320(143), Width320(258), Height320(300))];
        
        contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        contentView.layer.cornerRadius = Width320(2);
        
        contentView.layer.masksToBounds = YES;
        
        [self addSubview:contentView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(20), Height320(17), contentView.width-Width320(40), Height320(20))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(16);
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [contentView addSubview:_titleLabel];
        
        UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(contentView.width-Width320(31), 0, Width320(31), Height320(31))];
        
        [contentView addSubview:closeButton];
        
        [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *closeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(11), Height320(11))];
        
        closeImg.image = [UIImage imageNamed:@"black_close"];
        
        [closeButton addSubview:closeImg];
        
        UIImageView *proImg = [[UIImageView alloc]initWithFrame:CGRectMake(contentView.width/2-Width320(71), Height320(64), Width320(142), Height320(120))];
        
        proImg.image = [UIImage imageNamed:@"gym_pro_pay_success"];
        
        [contentView addSubview:proImg];
        
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:Height320(6)];
        
        CGSize size = [@"升级到健身房管理高级版\n解锁全部功能" boundingRectWithSize:CGSizeMake(contentView.width,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
        
        UILabel *proLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, proImg.bottom+Height320(20), contentView.width, size.height)];
        
        proLabel.textColor = UIColorFromRGB(0x999999);
        
        proLabel.font = AllFont(13);
        
        proLabel.numberOfLines = 0;
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:@"升级到健身房管理高级版\n解锁全部功能"];
        
        NSTextAttachment *attach = [[NSTextAttachment alloc]init];
        
        attach.image = [UIImage imageNamed:@"gym_pro_img"];
        
        attach.bounds = CGRectMake(0, 0, Width320(18), Height320(10));
        
        NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attach];
        
        [astr insertAttributedString:str atIndex:11];
        
        [astr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [astr length])];
        
        proLabel.attributedText = astr;
        
        proLabel.textAlignment = NSTextAlignmentCenter;
        
        [contentView addSubview:proLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, contentView.height-Height320(40)-OnePX, contentView.width, OnePX)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [contentView addSubview:sep];
        
        _lookButton = [[UIButton alloc]initWithFrame:CGRectMake(0, sep.bottom, contentView.width/2, Height320(40))];
        
        _lookButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        _lookButton.tag = 0;
        
        [_lookButton setTitle:@"查看高级版价格" forState:UIControlStateNormal];
        
        [_lookButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        
        _lookButton.titleLabel.font = AllFont(14);
        
        [contentView addSubview:_lookButton];
        
        [_lookButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _tryButton = [[UIButton alloc]initWithFrame:CGRectMake(contentView.width/2, _lookButton.top, contentView.width/2, Height320(40))];
        
        _tryButton.backgroundColor = kMainColor;
        
        _tryButton.tag = 1;
        
        [_tryButton setTitle:@"免费试用15天" forState:UIControlStateNormal];
        
        [_tryButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        _tryButton.titleLabel.font = AllFont(14);
        
        [contentView addSubview:_tryButton];
        
        [_tryButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)buttonClick:(UIButton*)button
{
    
    [self close];
    
    if (button.tag == 0) {
        
        GymProController *svc = [[GymProController alloc]init];
        
        [[MOAppDelegate getCurrentVC] presentViewController:[[UINavigationController alloc]initWithRootViewController:svc] animated:YES completion:nil];
        
    }else{
        
        GymProInfo *info = [[GymProInfo alloc]init];
        
        [info tryGymResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                AppGym.pro = YES;
                
                if ([[MOAppDelegate getCurrentVC] isKindOfClass:[UINavigationController class]]) {
                    
                    for (MOViewController *vc in ((UINavigationController*)[MOAppDelegate getCurrentVC]).viewControllers) {
                        
                        if ([NSStringFromClass([vc class])isEqualToString:@"GymDetailController"]||[NSStringFromClass([vc class])isEqualToString:@"AllFunctionController"]) {
                            
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                }
                
                [self showTrySuccessAlert];
                
            }else{
                
                [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        }];
        
    }
    
}

-(void)showTrySuccessAlert
{
    
    GymTrySuccessAlert *alert = [GymTrySuccessAlert defaultAlert];
    
    alert.systemEnd = AppGym.systemEnd;
    
    alert.gymName = [AppGym.brand.name stringByAppendingString:AppGym.name];
    
    alert.delegate = self.delegate;
    
    [alert showInView:_view];
    
}

-(void)close
{
    
    self.hidden = YES;
    
    [self removeFromSuperview];
    
}

-(void)showInView:(UIView *)view
{
    
    _view = view;
    
    [view addSubview:self];
    
    [view bringSubviewToFront:self];
    
}

-(void)setCanTry:(BOOL)canTry
{
    
    _canTry = canTry;
    
    [_lookButton changeWidth:_canTry?Width320(129):Width320(258)];
    
    _tryButton.hidden = !_canTry;
    
    _lookButton.backgroundColor = _canTry?UIColorFromRGB(0xffffff):kMainColor;
    
    [_lookButton setTitleColor:_canTry?UIColorFromRGB(0x333333):UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
}

@end
