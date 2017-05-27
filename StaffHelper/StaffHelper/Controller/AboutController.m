//
//  AboutController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/17.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "AboutController.h"

#define URL @"http://www.qingchengfit.cn/"

@interface AboutController ()<UIWebViewDelegate,MONaviDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)MBProgressHUD *activityView;

@end

@implementation AboutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

-(void)createUI
{
    
    self.title = @"关于我们";
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URL]]];
    
    [self.view addSubview:self.webView];
    
    self.activityView = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.activityView.mode = MBProgressHUDModeIndeterminate;
    
    self.activityView.label.text = @"";
    
    [self.view addSubview:self.activityView];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [self.activityView showAnimated:YES];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self.activityView hideAnimated:YES];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [self.activityView hideAnimated:YES];
    
}

@end
