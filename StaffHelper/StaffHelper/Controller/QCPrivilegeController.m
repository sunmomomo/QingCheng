//
//  QCPrivilegeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QCPrivilegeController.h"

#import "MessageController.h"

#import "WebViewController.h"

#import "UIWebView+Cache.h"

#import "WebViewJavascriptBridge.h"

#import "SensorsAnalyticsSDK.h"

#define PrivilegeURL @"/mobile/staff/discover/"

@interface QCPrivilegeController ()<UIWebViewDelegate>

@property WebViewJavascriptBridge* bridge;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,assign)BOOL currentLoad;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation QCPrivilegeController

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.tabTitle = @"发现";
        
        self.selectedImg = [UIImage imageNamed:@"privilege_selected"];
        
        self.unselectImg = [UIImage imageNamed:@"privilege_unselect"];
        
        self.currentLoad = YES;
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    
    self.currentLoad = YES;
    
    [self.hud showAnimated:YES];
    
    [ [NSURLCache  sharedURLCache ] removeAllCachedResponses];
    
    [UIWebView setCache];
    
    [self.webView reload];
    
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
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.webView.scrollView.mj_header = header;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ROOT,PrivilegeURL]]]];
    
    [self registerHandle];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.webView];
    
    [self.webView addSubview:self.hud];
    
    [self.hud showAnimated:YES];
    
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

-(void)naviRightClick
{
    
    MessageController *svc = [[MessageController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
