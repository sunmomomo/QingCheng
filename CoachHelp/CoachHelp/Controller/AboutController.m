//
//  AboutController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/17.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "AboutController.h"

#define URL @"/aboutus/?oem="

@interface AboutController ()<UIWebViewDelegate>

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
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",ROOT,URL,PushDistribute]]]];
    
    [self.view addSubview:self.webView];
    
    self.activityView = [[MBProgressHUD alloc]initWithView:self.webView];
    
    self.activityView.mode = MBProgressHUDModeIndeterminate;
    
    [self.webView addSubview:self.activityView];
    
}


@end
