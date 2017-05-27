//
//  GymProController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymProController.h"

#import "GymProButton.h"

#import "GymPay.h"

#import "GymPayHistoryController.h"

#import "GymProInfo.h"

#import "WebViewController.h"

#import "GymPaySuccessController.h"

#import "GymDetailInfo.h"

@interface GymProController ()

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *buttons;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UIImageView *showArrow;

@property(nonatomic,strong)UILabel *privilegeLabel;

@property(nonatomic,strong)UIView *privilegeView;

@property(nonatomic,strong)NSArray *pays;

@property(nonatomic,strong)GymPay *choosePay;

@property(nonatomic,strong)UIView *secView;

@end

@implementation GymProController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

-(void)createData
{
    
    GymProInfo *info = [[GymProInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.pays = info.pays;
        
        [self createProView];
        
        for (GymPay *pay in info.pays) {
            
            if (pay.choosed) {
                
                self.choosePay = pay;
                
            }
            
        }
        
        [self reloadPriceView];
        
    }];
    
}

-(void)createUI
{
    
    self.leftType = MONaviLeftTypeBlackClose;
    
    self.shadowType = MONaviShadowTypeLine;
    
    self.rightTitle = @"付费记录";
    
    self.title = @"高级版";
    
    self.navigationTitleColor = UIColorFromRGB(0x333333);
    
    self.rightColor = UIColorFromRGB(0x333333);
    
    self.navi.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(40))];
    
    self.scrollView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.scrollView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(68))];
    
    topView.backgroundColor = UIColorFromRGB(0x4E4E4E);
    
    [self.scrollView addSubview:topView];
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(17), Width320(34), Height320(34))];
    
    topImg.image = [UIImage imageNamed:@"gym_pro_update"];
    
    [topView addSubview:topImg];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(topImg.right+Width320(12), 0, MSW-Width320(24)-topImg.right, Height320(68))];
    
    topLabel.textColor = UIColorFromRGB(0xffffff);
    
    topLabel.font = AllFont(14);
    
    NSMutableAttributedString *topAstr = [[NSMutableAttributedString alloc]initWithString:@"升级到高级版，即可解锁以下功能"];
    
    NSTextAttachment *topAttch = [[NSTextAttachment alloc] init];
    
    topAttch.image = [UIImage imageNamed:@"gym_pro_img_white"];
    
    topAttch.bounds = CGRectMake(0, 0, Width320(18), Height320(10));
    
    NSAttributedString *topString = [NSAttributedString attributedStringWithAttachment:topAttch];
    
    [topAstr insertAttributedString:topString atIndex:6];
    
    topLabel.attributedText = topAstr;
    
    [topView addSubview:topLabel];
    
    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, Height320(284))];
    
    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.secView.layer.borderWidth = OnePX;
    
    self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.scrollView addSubview:self.secView];
    
    UIImageView *cardImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(15), Width320(26), Height320(26))];
    
    cardImg.contentMode = UIViewContentModeScaleAspectFit;
    
    cardImg.image = [UIImage imageNamed:@"func_card_manager"];
    
    [self.secView addSubview:cardImg];
    
    UILabel *cardTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(60), Height320(10), MSW-Width320(72), Height320(18))];
    
    cardTitleLabel.text = @"会员卡";
    
    cardTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    cardTitleLabel.font = AllFont(14);
    
    [self.secView addSubview:cardTitleLabel];
    
    UILabel *cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.left, cardTitleLabel.bottom+Height320(2), cardTitleLabel.width, Height320(15))];
    
    cardLabel.text = @"在线购卡、充值，支持会员卡结算";
    
    cardLabel.textColor = UIColorFromRGB(0x999999);
    
    cardLabel.font = AllFont(12);
    
    [self.secView addSubview:cardLabel];
    
    UIImageView *marketImg = [[UIImageView alloc]initWithFrame:CGRectMake(cardImg.left, cardLabel.bottom+Height320(25), cardImg.width, cardImg.height)];
    
    marketImg.contentMode = UIViewContentModeScaleAspectFit;
    
    marketImg.image = [UIImage imageNamed:@"func_marketing_activity"];
    
    [self.secView addSubview:marketImg];
    
    UILabel *marketTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.left, cardLabel.bottom+Height320(20), MSW-Width320(72), Height320(18))];
    
    marketTitleLabel.text = @"运营推广";
    
    marketTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    marketTitleLabel.font = AllFont(14);
    
    [self.secView addSubview:marketTitleLabel];
    
    NSString *marketStr = @"丰富的运营推广功能，包括会员积分、活动、会员端页面广告、接入口碑网、注册送卡、场馆公告等，以及后续开发的更多功能";
    
    CGSize marketSize = [marketStr boundingRectWithSize:CGSizeMake(cardTitleLabel.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    UILabel *marketLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.left, marketTitleLabel.bottom+Height320(2), cardTitleLabel.width, marketSize.height)];
    
    marketLabel.numberOfLines = 0;
    
    marketLabel.text = marketStr;
    
    marketLabel.textColor = UIColorFromRGB(0x999999);
    
    marketLabel.font = AllFont(12);
    
    [self.secView addSubview:marketLabel];
    
    UIImageView *staffImg = [[UIImageView alloc]initWithFrame:CGRectMake(cardImg.left, marketLabel.bottom+Height320(25), cardImg.width, cardImg.height)];
    
    staffImg.contentMode = UIViewContentModeScaleAspectFit;
    
    staffImg.image = [UIImage imageNamed:@"func_staff_manager"];
    
    [self.secView addSubview:staffImg];
    
    UILabel *staffTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.left, marketLabel.bottom+Height320(20), MSW-Width320(72), Height320(18))];
    
    staffTitleLabel.text = @"工作人员管理";
    
    staffTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    staffTitleLabel.font = AllFont(14);
    
    [self.secView addSubview:staffTitleLabel];
    
    UILabel *staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.left, staffTitleLabel.bottom+Height320(2), cardTitleLabel.width, Height320(15))];
    
    staffLabel.text = @"管理工作人员并分配权限";
    
    staffLabel.textColor = UIColorFromRGB(0x999999);
    
    staffLabel.font = AllFont(12);
    
    [self.secView addSubview:staffLabel];
    
    UILabel *reportTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.left, staffLabel.bottom+Height320(20), MSW-Width320(72), Height320(18))];
    
    reportTitleLabel.text = @"完整报表";
    
    reportTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    reportTitleLabel.font = AllFont(14);
    
    [self.secView addSubview:reportTitleLabel];
    
    UIImageView *reportImg = [[UIImageView alloc]initWithFrame:CGRectMake(cardImg.left, staffLabel.bottom+Height320(25), cardImg.width, cardImg.height)];
    
    reportImg.contentMode = UIViewContentModeScaleAspectFit;
    
    reportImg.image = [UIImage imageNamed:@"func_data_report"];
    
    [self.secView addSubview:reportImg];
    
    NSString *reportStr = @"可查看全部报表，包括销售报表、评分报表、会员卡报表、签到报表等";
    
    CGSize reportSize = [reportStr boundingRectWithSize:CGSizeMake(cardTitleLabel.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    UILabel *reportLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.left, reportTitleLabel.bottom+Height320(2), cardTitleLabel.width, reportSize.height)];
    
    reportLabel.numberOfLines = 0;
    
    reportLabel.text = reportStr;
    
    reportLabel.textColor = UIColorFromRGB(0x999999);
    
    reportLabel.font = AllFont(12);
    
    [self.secView addSubview:reportLabel];
    
    [self.secView changeHeight:reportLabel.bottom+Height320(10)];
    
    self.buttons = [NSMutableArray array];
    
    UIView *priceView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH-Height320(40), MSW, Height320(40))];
    
    priceView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    priceView.layer.borderWidth = OnePX;
    
    priceView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:priceView];
    
    UILabel *priceGymLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(5), Width320(180), Height320(14))];
    
    priceGymLabel.text = AppGym.name;
    
    priceGymLabel.textColor = UIColorFromRGB(0x999999);
    
    priceGymLabel.font = AllFont(10);
    
    [priceView addSubview:priceGymLabel];
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), priceGymLabel.bottom, Width320(180), Height320(20))];
    
    self.priceLabel.textColor = UIColorFromRGB(0x999999);
    
    self.priceLabel.font = AllFont(12);
    
    [priceView addSubview:self.priceLabel];
    
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(100), 0, Width320(100), Height320(40))];
    
    payButton.backgroundColor = kMainColor;
    
    [payButton setTitle:@"去支付" forState:UIControlStateNormal];
    
    [payButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    payButton.titleLabel.font = AllFont(16);
    
    [priceView addSubview:payButton];
    
    [self reloadPriceView];
    
    [payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)pay:(UIButton*)button
{
    
    GymProInfo *info = [[GymProInfo alloc]init];
    
    [info proGymWithGymPay:self.choosePay result:^(BOOL success, NSString *error) {
        
        if (success && info.payURL.absoluteString.length) {
            
            NSURL *url = info.payURL;
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            svc.url = url;
            
            __weak typeof(self)weakS = self;
            
            __weak typeof(Gym*)weakGym = AppGym;
            
            NSString *systemEnd = info.systemEnd;
            
            svc.paySuccess = ^{
                
                [weakS.navigationController popToViewController:weakS animated:NO];
                
                weakGym.systemEnd = systemEnd;
                
                GymDetailInfo *gymInfo = [[GymDetailInfo alloc]init];
                
                [gymInfo requestWithGym:AppGym result:^(BOOL success, NSString *error, NSInteger errorCode) {}];
                
                GymPaySuccessController *vc = [[GymPaySuccessController alloc]init];
                
                [weakS.navigationController pushViewController:vc animated:YES];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"获取订单信息失败，请稍后重试" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }];
    
}

-(void)showPrice
{
    
    self.privilegeView.hidden = !self.privilegeView.hidden;
    
    self.privilegeLabel.hidden = self.privilegeView.hidden;
    
    self.scrollView.contentSize = CGSizeMake(0, self.privilegeView.hidden?self.privilegeLabel?self.privilegeLabel.top+Height320(12):self.privilegeView.top+Height320(12):self.privilegeView.bottom+Height320(18));
    
    self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height-self.scrollView.height);
    
    self.showArrow.transform = self.privilegeView.hidden?CGAffineTransformMakeRotation(0):CGAffineTransformMakeRotation(M_PI);
    
}

-(void)createProView
{
    
    if (!AppGym.havePrivilege) {
        
        UILabel *proLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(16)+self.secView.bottom, Width320(100), Height320(18))];
        
        proLabel.textColor = UIColorFromRGB(0x333333);
        
        proLabel.font = AllFont(14);
        
        NSMutableAttributedString *proAstr = [[NSMutableAttributedString alloc]initWithString:@"高级版 "];
        
        NSTextAttachment *proAttch = [[NSTextAttachment alloc] init];
        
        proAttch.image = [UIImage imageNamed:@"gym_pro_img"];
        
        proAttch.bounds = CGRectMake(0, 0, Width320(18), Height320(10));
        
        NSAttributedString *proString = [NSAttributedString attributedStringWithAttachment:proAttch];
        
        [proAstr insertAttributedString:proString atIndex:proAstr.length];
        
        proLabel.attributedText = proAstr;
        
        [self.scrollView addSubview:proLabel];
        
        UIView *priceView = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), proLabel.bottom+Height320(8), MSW-Width320(32), Height320(77))];
        
        priceView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        priceView.layer.borderWidth = OnePX;
        
        [self.scrollView addSubview:priceView];
        
        for (NSInteger i = 0; i<3; i++) {
            
            GymProButton *button = [[GymProButton alloc]initWithFrame:CGRectMake(i*priceView.width/3, 0, priceView.width/3, priceView.height)];
            
            GymPay *pay = self.pays[i];
            
            button.month = pay.month;
            
            button.price = pay.price;
            
            button.choosed = pay.choosed;
            
            button.userInteractionEnabled = pay.canUsed;
            
            button.tag = i;
            
            [priceView addSubview:button];
            
            [self.buttons addObject:button];
            
            [button addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), priceView.bottom+Height320(15), Width320(100), Height320(21))];
        
        [self.scrollView addSubview:showButton];
        
        [showButton addTarget:self action:@selector(showPrice) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *showTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(27), Height320(21))];
        
        showTitleLabel.text = @"优惠";
        
        showTitleLabel.textColor = UIColorFromRGB(0x333333);
        
        showTitleLabel.font = AllFont(14);
        
        [showButton addSubview:showTitleLabel];
        
        self.showArrow = [[UIImageView alloc]initWithFrame:CGRectMake(showTitleLabel.right+Width320(5), Height320(8), Width320(12), Height320(7))];
        
        self.showArrow.image = [UIImage imageNamed:@"down_arrow"];
        
        [showButton addSubview:self.showArrow];
        
        self.scrollView.contentSize = CGSizeMake(0, showButton.bottom+Height320(18));
        
        self.privilegeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), showButton.bottom+Height320(4), MSW-Width320(32), Height320(30))];
        
        self.privilegeLabel.text = @"单场馆累计付费12个月以上，同品牌下场馆即可享受以下优惠";
        
        self.privilegeLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        self.privilegeLabel.numberOfLines = 0;
        
        self.privilegeLabel.font = AllFont(12);
        
        [self.scrollView addSubview:self.privilegeLabel];
        
        self.privilegeLabel.hidden = YES;
        
        self.privilegeView = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), self.privilegeLabel.bottom+Height320(6), MSW-Width320(32), Height320(77))];
        
        self.privilegeView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.privilegeView.layer.borderWidth = OnePX;
        
        [self.scrollView addSubview:self.privilegeView];
        
        for (NSInteger i = 0; i<3; i++) {
            
            GymProButton *button = [[GymProButton alloc]initWithFrame:CGRectMake(i*self.privilegeView.width/3, 0, self.privilegeView.width/3, self.privilegeView.height)];
            
            GymPay *pay = self.pays[i+3];
            
            button.month = pay.month;
            
            button.price = pay.price;
            
            button.discardedPrice = pay.discardedPrice;
            
            button.choosed = pay.choosed;
            
            button.userInteractionEnabled = pay.canUsed;
            
            button.tag = i+3;
            
            [self.privilegeView addSubview:button];
            
            [self.buttons addObject:button];
            
            [button addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        self.privilegeView.hidden = YES;
        
    }else{
        
        UILabel *PFLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.secView.bottom+Height320(16), Width320(150), Height320(18))];
        
        PFLabel.text = @"您可以享受以下优惠";
        
        PFLabel.textColor = UIColorFromRGB(0x333333);
        
        PFLabel.font = AllFont(14);
        
        [self.scrollView addSubview:PFLabel];
        
        UILabel *PSLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), PFLabel.bottom+Height320(4), MSW-Width320(32), Height320(30))];
        
        PSLabel.text = @"您已满足优惠条件：单场馆累计付费12个月以上。同品牌下场馆可享受以下优惠";
        
        PSLabel.textColor = UIColorFromRGB(0x999999);
        
        PSLabel.numberOfLines = 0;
        
        PSLabel.font = AllFont(12);
        
        [self.scrollView addSubview:PSLabel];
        
        UIView *priceView = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), PSLabel.bottom+Height320(8), MSW-Width320(32), Height320(77))];
        
        priceView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        priceView.layer.borderWidth = OnePX;
        
        [self.scrollView addSubview:priceView];
        
        for (NSInteger i = 0; i<3; i++) {
            
            GymProButton *button = [[GymProButton alloc]initWithFrame:CGRectMake(i*priceView.width/3, 0, priceView.width/3, priceView.height)];
            
            GymPay *pay = self.pays[i];
            
            button.month = pay.month;
            
            button.price = pay.price;
            
            button.discardedPrice = pay.discardedPrice;
            
            button.choosed = pay.choosed;
            
            button.userInteractionEnabled = pay.canUsed;
            
            button.tag = i;
            
            [priceView addSubview:button];
            
            [self.buttons addObject:button];
            
            [button addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), priceView.bottom+Height320(15), Width320(100), Height320(21))];
        
        [self.scrollView addSubview:showButton];
        
        [showButton addTarget:self action:@selector(showPrice) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *showTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(27), Height320(21))];
        
        showTitleLabel.text = @"原价";
        
        showTitleLabel.textColor = UIColorFromRGB(0x333333);
        
        showTitleLabel.font = AllFont(14);
        
        [showButton addSubview:showTitleLabel];
        
        self.showArrow = [[UIImageView alloc]initWithFrame:CGRectMake(showTitleLabel.right+Width320(5), Height320(8), Width320(12), Height320(7))];
        
        self.showArrow.image = [UIImage imageNamed:@"down_arrow"];
        
        [showButton addSubview:self.showArrow];
        
        self.scrollView.contentSize = CGSizeMake(0, showButton.bottom+Height320(18));
        
        self.privilegeView = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), showButton.bottom+Height320(6), MSW-Width320(32), Height320(77))];
        
        self.privilegeView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.privilegeView.layer.borderWidth = OnePX;
        
        [self.scrollView addSubview:self.privilegeView];
        
        for (NSInteger i = 0; i<3; i++) {
            
            GymProButton *button = [[GymProButton alloc]initWithFrame:CGRectMake(i*self.privilegeView.width/3, 0, self.privilegeView.width/3, self.privilegeView.height)];
            
            GymPay *pay = self.pays[i+3];
            
            button.month = pay.month;
            
            button.price = pay.price;
            
            button.choosed = pay.choosed;
            
            button.userInteractionEnabled = pay.canUsed;
            
            button.tag = i+3;
            
            [self.privilegeView addSubview:button];
            
            [self.buttons addObject:button];
            
            [button addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        self.privilegeView.hidden = YES;
        
    }
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)payButtonClick:(GymProButton*)button
{
    
    self.choosePay = self.pays[button.tag];
    
    for (GymProButton *tempButton in self.buttons) {
        
        tempButton.choosed = button.tag == tempButton.tag;
        
    }
    
    [self reloadPriceView];
    
}

-(void)reloadPriceView
{
    
    NSString *lstr = [NSString stringWithFormat:@"%ld个月",(long)self.choosePay.month];
    
    NSString *str = [NSString stringWithFormat:@"%@    %ld元",lstr,(long)self.choosePay.price];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [astr addAttribute:NSForegroundColorAttributeName value:kMainColor range:NSMakeRange(lstr.length+4, astr.length-lstr.length-4)];
    
    [astr addAttribute:NSFontAttributeName value:AllFont(16) range:NSMakeRange(lstr.length+4, astr.length-lstr.length-4)];
    
    self.priceLabel.attributedText = astr;
    
}

-(void)naviRightClick
{
    
    GymPayHistoryController *svc = [[GymPayHistoryController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
