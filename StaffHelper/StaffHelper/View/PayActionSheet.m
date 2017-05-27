//
//  PayActionSheet.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "PayActionSheet.h"

#define kShowTime 0.3f

@interface PayWayCell : UIButton

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UIImageView *_chooseImg;
    
}

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,assign)PayWay payWay;

@end

@implementation PayWayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(9), Width320(24), Height320(24))];
        
        [self addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(8), 0, Width320(150), Height320(40))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self addSubview:_titleLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(32), Height320(14), Width320(16), Height320(12))];
        
        _chooseImg.image = [UIImage imageNamed:@"green_check"];
        
        [self addSubview:_chooseImg];
        
        _chooseImg.hidden = YES;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width320(48), frame.size.height-1, MSW-Width320(48), 1)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:line];
        
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
    
    _titleLabel.text = _title;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !_choosed;
    
}

@end

@interface PayActionSheet ()

{
    
    UIView *_payView;
    
    NSMutableArray *_cellArray;
    
}

@end

@implementation PayActionSheet

+(instancetype)defaultActionSheet
{
    
    PayActionSheet *sheet = [[PayActionSheet alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH) withPermission:YES];
    
    return sheet;
    
}

+(instancetype)noPermissionActionSheet
{
    
    PayActionSheet *sheet = [[PayActionSheet alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH) withPermission:NO];
    
    return sheet;
    
}

-(void)showInView:(UIView *)view
{
    
    [view addSubview:self];
    
    [view bringSubviewToFront:self];
    
    [UIView animateWithDuration:kShowTime animations:^{
        
        [_payView changeTop:MSH-_payView.height];
        
    }];
    
}

- (instancetype)initWithFrame:(CGRect)frame withPermission:(BOOL)permission
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _cellArray = [NSMutableArray array];
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        back.backgroundColor = [UIColorFromRGB(0x000000)colorWithAlphaComponent:0.4];
        
        [self addSubview:back];
        
        [back addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap)]];
        
        _payView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, permission?Height320(304):Height320(110))];
        
        _payView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:_payView];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(10), Width320(200), Height320(14))];
        
        topLabel.text = @"在线支付";
        
        topLabel.textColor = UIColorFromRGB(0x999999);
        
        topLabel.font = AllFont(12);
        
        [_payView addSubview:topLabel];
        
        PayWayCell *codeCell = [[PayWayCell alloc]initWithFrame:CGRectMake(0, Height320(30), MSW, Height320(40))];
        
        codeCell.image = [UIImage imageNamed:@"pay_code"];
        
        codeCell.title = @"微信扫码支付";
        
        codeCell.payWay = PayWayQRCode;
        
        [codeCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_payView addSubview:codeCell];
        
        [_cellArray addObject:codeCell];
        
        PayWayCell *wechatCell = [[PayWayCell alloc]initWithFrame:CGRectMake(0, Height320(70), MSW, Height320(40))];
        
        wechatCell.image = [UIImage imageNamed:@"pay_wechat"];
        
        wechatCell.title = @"微信支付";
        
        wechatCell.payWay = PayWayWeChat;
        
        [wechatCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_payView addSubview:wechatCell];
        
        [_cellArray addObject:wechatCell];
        
        if (permission) {
            
            UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(125), Width320(200), Height320(14))];
            
            secLabel.text = @"线下支付";
            
            secLabel.textColor = UIColorFromRGB(0x999999);
            
            secLabel.font = AllFont(12);
            
            [_payView addSubview:secLabel];
            
            PayWayCell *cashCell = [[PayWayCell alloc]initWithFrame:CGRectMake(0, Height320(145), MSW, Height320(40))];
            
            cashCell.image = [UIImage imageNamed:@"pay_cash"];
            
            cashCell.title = @"现金支付";
            
            cashCell.payWay = PayWayCash;
            
            [cashCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_payView addSubview:cashCell];
            
            [_cellArray addObject:cashCell];
            
            PayWayCell *cardCell = [[PayWayCell alloc]initWithFrame:CGRectMake(0, Height320(185), MSW, Height320(40))];
            
            cardCell.image = [UIImage imageNamed:@"pay_card"];
            
            cardCell.title = @"刷卡支付";
            
            cardCell.payWay = PayWayCard;
            
            [cardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_payView addSubview:cardCell];
            
            [_cellArray addObject:cardCell];
            
            PayWayCell *transferCell = [[PayWayCell alloc]initWithFrame:CGRectMake(0, Height320(225), MSW, Height320(40))];
            
            transferCell.image = [UIImage imageNamed:@"pay_transfer"];
            
            transferCell.title = @"转账支付";
            
            transferCell.payWay = PayWayTransfer;
            
            [transferCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_payView addSubview:transferCell];
            
            [_cellArray addObject:transferCell];
            
            PayWayCell *otherCell = [[PayWayCell alloc]initWithFrame:CGRectMake(0, Height320(265), MSW, Height320(40))];
            
            otherCell.image = [UIImage imageNamed:@"pay_other"];
            
            otherCell.title = @"其他支付";
            
            otherCell.payWay = PayWayOther;
            
            [otherCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_payView addSubview:otherCell];
            
            [_cellArray addObject:otherCell];
            
        }
        
    }
    return self;
}

-(void)backTap
{
    
    [self dismissWithPayWay:self.payWay];
    
}

-(void)dismissWithPayWay:(PayWay)payWay
{
    
    [UIView animateWithDuration:kShowTime animations:^{
        
        [_payView changeTop:MSH];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if ([self.delegate respondsToSelector:@selector(payActionSheetDismissWithPayWay:)]) {
            
            [self.delegate payActionSheetDismissWithPayWay:payWay];
            
        }
        
    }];
    
}

-(void)setPayWay:(PayWay)payWay
{
    
    _payWay = payWay;
    
    for (PayWayCell *cell in _cellArray) {
        
        cell.choosed = cell.payWay == _payWay;
        
    }
    
}

-(void)cellClick:(PayWayCell*)cell
{
    
    [self dismissWithPayWay:cell.payWay];
    
}

@end
