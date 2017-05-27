//
//  GymHomePageController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/19.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymHomePageController.h"

#import "MOCell.h"

#import "UIWebView+Cache.h"

#import "WebViewController.h"

#import "ShareActionSheet.h"

#import "WXAPIManager.h"

#import "GymQRCodeAlert.h"

#import "JoinWeChatController.h"

#import "FunctionHintController.h"

#import "GymDetailInfo.h"

#define MoreURL @"http://cloud.qingchengfit.cn/mobile/urls/eeb0e361a378428fa1a862c949495e0d/"

@interface GymHomePageController ()<UIWebViewDelegate,WXApiManagerDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UIView *actionSheetView;

@property(nonatomic,strong)UIView *actionSheet;

@property(nonatomic,strong)MOCell *cell;

@property(nonatomic,strong)UILabel *joinedLabel;

@property(nonatomic,assign)BOOL currentLoad;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation GymHomePageController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    if (self.url) {
        
        self.currentLoad = YES;
        
        [UIWebView setCache];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        
    }
    
    [self reloadGymData];
    
}

-(void)reloadData
{
    
    self.currentLoad = YES;
    
    [self.hud showAnimated:YES];
    
    [self.webView reload];
    
    [self reloadGymData];
    
}

-(void)reloadGymData
{
    
    GymDetailInfo *info = [[GymDetailInfo alloc]init];
    
    [info requestWechatResult:^(BOOL success, NSString *error) {
        
        AppGym.wechatSuccess = info.gym.wechatSuccess;
        
        AppGym.wechatImg = info.gym.wechatImg;
        
        AppGym.wechatName = info.gym.wechatName;
        
        self.joinedLabel.text = info.gym.wechatSuccess?@"已对接":@"未对接";
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"会员端页面";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(40))];
    
    self.webView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.webView.scrollView.mj_header = header;
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.webView.bottom, MSW, Height320(40))];
    
    bottomView.backgroundColor = UIColorFromRGB(0xffffff);
    
    bottomView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    bottomView.layer.borderWidth = OnePX;
    
    [self.view addSubview:bottomView];
    
    UIButton *helpButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW/3, Height320(40))];
    
    [bottomView addSubview:helpButton];
    
    [helpButton addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *helpImg = [[UIImageView alloc]initWithFrame:CGRectMake(helpButton.width/2-Width320(8), Height320(5), Width320(16), Height320(16))];
    
    helpImg.image = [UIImage imageNamed:@"homepage_help"];
    
    [helpButton addSubview:helpImg];
    
    UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, helpImg.bottom+Height320(2), helpButton.width, Height320(14))];
    
    helpLabel.text = @"帮助";
    
    helpLabel.textColor = UIColorFromRGB(0x333333);
    
    helpLabel.textAlignment = NSTextAlignmentCenter;
    
    helpLabel.font = AllFont(11);
    
    [helpButton addSubview:helpLabel];
    
    UIButton *settingButton = [[UIButton alloc]initWithFrame:CGRectMake(helpButton.right, 0, MSW/3, Height320(40))];
    
    settingButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    settingButton.layer.borderWidth = OnePX;
    
    [bottomView addSubview:settingButton];
    
    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *settingImg = [[UIImageView alloc]initWithFrame:CGRectMake(settingButton.width/2-Width320(8), Height320(5), Width320(16), Height320(16))];
    
    settingImg.image = [UIImage imageNamed:@"homepage_setting"];
    
    [settingButton addSubview:settingImg];
    
    UILabel *settingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, settingImg.bottom+Height320(2), settingButton.width, Height320(14))];
    
    settingLabel.text = @"配置页面";
    
    settingLabel.textColor = UIColorFromRGB(0x333333);
    
    settingLabel.textAlignment = NSTextAlignmentCenter;
    
    settingLabel.font = AllFont(11);
    
    [settingButton addSubview:settingLabel];
    
    UIButton *popButton = [[UIButton alloc]initWithFrame:CGRectMake(settingButton.right, 0, MSW/3, Height320(40))];
    
    [bottomView addSubview:popButton];
    
    [popButton addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *popImg = [[UIImageView alloc]initWithFrame:CGRectMake(popButton.width/2-Width320(8), Height320(5), Width320(16), Height320(16))];
    
    popImg.image = [UIImage imageNamed:@"homepage_pop"];
    
    [popButton addSubview:popImg];
    
    UILabel *popLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, popImg.bottom+Height320(2), popButton.width, Height320(14))];
    
    popLabel.text = @"推广";
    
    popLabel.textColor = UIColorFromRGB(0x333333);
    
    popLabel.textAlignment = NSTextAlignmentCenter;
    
    popLabel.font = AllFont(11);
    
    [popButton addSubview:popLabel];
    
    self.actionSheetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    self.actionSheetView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    
    [self.view addSubview:self.actionSheetView];
    
    self.actionSheetView.hidden = YES;
    
    UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAction)]];
    
    [self.actionSheetView addSubview:tapView];
    
    self.actionSheet = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height320(252))];
    
    self.actionSheet.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.actionSheetView addSubview:self.actionSheet];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(10), Width320(200), Height320(15))];
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.text = @"分享给朋友";
    
    label.font = AllFont(12);
    
    [self.actionSheet addSubview:label];
    
    ShareButton *wechatBtn = [[ShareButton alloc]initWithFrame:CGRectMake(Width320(27), label.bottom+Height320(21.7), Width320(60), Height320(55))];
    
    wechatBtn.image = [UIImage imageNamed:@"wechat"];
    
    wechatBtn.title = @"微信";
    
    wechatBtn.tag = 1;
    
    [wechatBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionSheet addSubview:wechatBtn];
    
    ShareButton *friendBtn = [[ShareButton alloc]initWithFrame:CGRectMake(wechatBtn.right+Width320(48), wechatBtn.top, wechatBtn.width, wechatBtn.height)];
    
    friendBtn.image = [UIImage imageNamed:@"friend"];
    
    friendBtn.title = @"朋友圈";
    
    friendBtn.tag = 2;
    
    [friendBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionSheet addSubview:friendBtn];
    
    ShareButton *linkBtn = [[ShareButton alloc]initWithFrame:CGRectMake(friendBtn.right+Width320(48),wechatBtn.top, wechatBtn.width, wechatBtn.height)];
    
    linkBtn.image = [UIImage imageNamed:@"copy_link"];
    
    linkBtn.title = @"复制链接";
    
    linkBtn.tag = 3;
    
    [linkBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionSheet addSubview:linkBtn];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(114)-OnePX, MSW, OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [self.actionSheet addSubview:sep];
    
    UIButton *joinButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height320(114), MSW, Height320(46))];
    
    joinButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    joinButton.tag = 1;
    
    [joinButton addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionSheet addSubview:joinButton];
    
    UIImageView *joinImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(11), Width320(24), Height320(24))];
    
    joinImg.image = [UIImage imageNamed:@"homepage_join"];
    
    [joinButton addSubview:joinImg];
    
    UILabel *joinLabel = [[UILabel alloc]initWithFrame:CGRectMake(joinImg.right+Width320(12), 0, Width320(120), Height320(46))];
    
    joinLabel.text = @"对接到微信公众号";
    
    joinLabel.textColor = UIColorFromRGB(0x333333);
    
    joinLabel.font = AllFont(14);
    
    [joinButton addSubview:joinLabel];
    
    self.joinedLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(94), 0, Width320(70), Height320(46))];
    
    self.joinedLabel.textColor = UIColorFromRGB(0x999999);
    
    self.joinedLabel.text = @"未对接";
    
    self.joinedLabel.font = AllFont(12);
    
    self.joinedLabel.textAlignment = NSTextAlignmentRight;
    
    [joinButton addSubview:self.joinedLabel];
    
    UIImageView *joinArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(19), Height320(17), Width320(7), Height320(12))];
    
    joinArrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [joinButton addSubview:joinArrow];
    
    UIButton *codeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, joinButton.bottom, MSW, Height320(46))];
    
    codeButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    codeButton.layer.borderWidth = OnePX;
    
    codeButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    codeButton.tag = 2;
    
    [codeButton addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionSheet addSubview:codeButton];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(11), Width320(24), Height320(24))];
    
    codeImg.image = [UIImage imageNamed:@"homepage_qrcode"];
    
    [codeButton addSubview:codeImg];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(codeImg.right+Width320(12), 0, Width320(120), Height320(46))];
    
    codeLabel.text = @"会员端页面二维码";
    
    codeLabel.textColor = UIColorFromRGB(0x333333);
    
    codeLabel.font = AllFont(14);
    
    [codeButton addSubview:codeLabel];
    
    UIImageView *codeArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(19), Height320(17), Width320(7), Height320(12))];
    
    codeArrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [codeButton addSubview:codeArrow];
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, codeButton.bottom, MSW, Height320(46))];
    
    moreButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    moreButton.tag = 3;
    
    [moreButton addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionSheet addSubview:moreButton];
    
    UIImageView *moreImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(11), Width320(24), Height320(24))];
    
    moreImg.image = [UIImage imageNamed:@"homepage_more"];
    
    [moreButton addSubview:moreImg];
    
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(moreImg.right+Width320(12), 0, Width320(120), Height320(46))];
    
    moreLabel.text = @"更多推广方式";
    
    moreLabel.textColor = UIColorFromRGB(0x333333);
    
    moreLabel.font = AllFont(14);
    
    [moreButton addSubview:moreLabel];
    
    UIImageView *moreArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(19), Height320(17), Width320(7), Height320(12))];
    
    moreArrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [moreButton addSubview:moreArrow];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.webView];
    
    [self.webView addSubview:self.hud];
    
    [self.hud showAnimated:YES];
    
}

-(void)functionClick:(UIButton*)button
{
    
    [self closeAction];
    
    if (button.tag == 1) {
        
        JoinWeChatController *svc = [[JoinWeChatController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (button.tag == 2){
        
        GymQRCodeAlert *alert = [GymQRCodeAlert defaultAlert];
        
        alert.gymName = AppGym.name;
        
        alert.urlString = AppGym.hintURL.absoluteString;
        
        [alert show];
        
    }else{
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        svc.url = [NSURL URLWithString:MoreURL];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (!self.currentLoad) {
        
        if ([self.navigationController.visibleViewController isKindOfClass:[self class]]) {
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            svc.url = request.URL;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
        return NO;
        
    }else{
        
        return YES;
        
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    self.currentLoad = NO;
    
    [self.hud hideAnimated:YES];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [self.hud hideAnimated:YES];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(void)helpClick
{
    
    [[[UIAlertView alloc]initWithTitle:@"什么是会员端页面？" message:@"会员端页面是健身房提供给会员使用的页面。会员或潜在会员可以通过会员端页面了解健身房信息、购买会员卡、预约课程或参加活动等。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
    
}

-(void)settingClick
{
    
    if ([PermissionInfo sharedInfo].permissions.homepagePermission.editState) {
        
        FunctionHintController *svc = [[FunctionHintController alloc]init];
        
        svc.module = @"/shop/home";
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)popClick
{
    
    [self showAction];
    
}

-(void)showAction
{
    
    self.actionSheetView.hidden = NO;
    
    [self.view bringSubviewToFront:self.actionSheetView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.actionSheet changeTop:MSH-self.actionSheet.height];
        
    }];
    
}

-(void)closeAction
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.actionSheet changeTop:MSH];
        
    } completion:^(BOOL finished) {
        
        self.actionSheetView.hidden = YES;
        
    }];
    
}

-(void)shareClick:(ShareButton*)button
{
    
    [self closeAction];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:[NSString stringWithFormat:@"%@的会员端页面",AppGym.name] forKey:@"title"];
    
    [dict setValue:AppGym.hintURL.absoluteString forKey:@"link"];
    
    [WXAPIManager sharedManager].delegate = self;
    
    if (button.tag == 1) {
        
        if (![WXApi isWXAppInstalled]) {
            
            [[[UIAlertView alloc]initWithTitle:@"尚未安装微信" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        [[WXAPIManager sharedManager]shareWithParameters:dict andScene:0];
        
    }else if (button.tag == 2)
    {
        
        if (![WXApi isWXAppInstalled]) {
            
            [[[UIAlertView alloc]initWithTitle:@"尚未安装微信" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        [[WXAPIManager sharedManager]shareWithParameters:dict andScene:1];
        
    }else if (button.tag == 3){
        
        if (AppGym.hintURL.absoluteString.length) {
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
            pasteboard.string = AppGym.hintURL.absoluteString;
            
            [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }
    
}

@end
