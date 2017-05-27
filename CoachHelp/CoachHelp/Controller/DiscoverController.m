//
//  DiscoverController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "DiscoverController.h"

#import "WebViewController.h"

#import "UIWebView+Cache.h"

#import "WebViewJavascriptBridge.h"

#import "SensorsAnalyticsSDK.h"

#define PrivilegeURL @"/mobile/coach/discover/"

@interface DiscoverController ()<UIWebViewDelegate>

@property WebViewJavascriptBridge* bridge;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,assign)BOOL currentLoad;

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation DiscoverController

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.tabTitle = @"发现";
        
        self.selectedImg = [UIImage imageNamed:@"discover_selected"];
        
        self.unselectImg = [UIImage imageNamed:@"discover_unselect"];
        
        self.currentLoad = YES;
        
        self.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ROOT,PrivilegeURL]];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

-(void)reloadData
{
    
    self.currentLoad = YES;
    
    [self.hud showAnimated:YES];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
}

-(void)createData
{
    
    [UIWebView setCache];
    
}

-(void)createUI
{
    
    self.leftType = MONaviLeftTypeNO;
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-49)];
    
    self.webView.scrollView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(endRefresh)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.webView.scrollView.mj_header = header;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.webView];
    
    [self.webView addSubview:self.hud];
    
    [self.hud showAnimated:YES];
    
    [self registerHandle];
    
}

-(void)endRefresh
{
    
    [self reloadData];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(void)registerHandle
{
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {}];
    
    [_bridge registerHandler:@"iOSHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([data[@"name"] isEqualToString:@"sensorsTrack"]) {
            
            NSDictionary *dict = data[@"data"];
            
            [[SensorsAnalyticsSDK sharedInstance]track:dict[@"key"] withProperties:dict[@"data"]];
            
        }
        
    }];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (!self.currentLoad) {
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        svc.url = request.URL;
        
        [self.navigationController pushViewController:svc animated:YES];
        
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


@end
