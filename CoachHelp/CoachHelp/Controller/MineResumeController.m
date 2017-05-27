//
//  MineResumeController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MineResumeController.h"

#import "MineResumeEditController.h"

#import "WebViewJavascriptBridge.h"

#import "UIWebView+Cache.h"

#import "ShareActionSheet.h"

#import "WebViewController.h"

#import "UserDetailInfo.h"

@interface MineResumeController ()<UIWebViewDelegate,ShareActionSheetDelegate>

@property WebViewJavascriptBridge* bridge;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)MBProgressHUD *activityView;

@property(nonatomic,assign)BOOL currentLoad;

@property(nonatomic,strong)UIView *shareView;

@end

@implementation MineResumeController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        if (self) {
            
            self.currentLoad = YES;
            
        }
        
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    [UIWebView setCache];
    
    if (self.url) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10]];
        
        [self.activityView showAnimated:YES];
        
    }
    
}

-(void)reloadData
{
    
    self.currentLoad = YES;
    
    [self.activityView showAnimated:YES];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"我的简历";
    
    self.rightType = MONaviRightTypeShare;
    
    self.rightSubType = MONaviRightSubTypeEdit;
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.webView.backgroundColor = UIColorFromRGB(0xffffff);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.webView.scrollView.mj_header = header;
    
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    self.activityView = [[MBProgressHUD alloc]initWithView:self.webView];
    
    [self.webView addSubview:self.activityView];
    
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(67), Height320(230), Width320(134), Height320(93))];
    
    self.shareView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.45];
    
    self.shareView.layer.cornerRadius = 2;
    
    self.shareView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.shareView];
    
    self.shareView.hidden = YES;
    
    UIImageView *shareImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(17), Width320(28), Height320(28))];
    
    shareImg.image = [UIImage imageNamed:@"share_success"];
    
    shareImg.center = CGPointMake(self.shareView.width/2, shareImg.center.y);
    
    [self.shareView addSubview:shareImg];
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, shareImg.bottom+Height320(13.8), self.shareView.width, Height320(17))];
    
    shareLabel.textColor = UIColorFromRGB(0xffffff);
    
    shareLabel.text = @"分享成功";
    
    shareLabel.textAlignment = NSTextAlignmentCenter;
    
    shareLabel.font = STFont(13);
    
    [self.shareView addSubview:shareLabel];
    
    [self registerHandle];
    
}

-(void)registerHandle
{
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {}];
    
    [_bridge registerHandler:@"iOSHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([data[@"name"] isEqualToString:@"shareInfo"])
        {
            
            NSString *dataStr = data[@"data"];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
            ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
            
            actionSheet.delegate = self;
            
            actionSheet.title = dict[@"title"];
            
            actionSheet.imgURL = [[dict[@"imgUrl"] componentsSeparatedByString:@"!"]firstObject];
            
            NSString *link = dict[@"link"];
            
            actionSheet.url = [link hasPrefix:@"http"]?link:[@"http://" stringByAppendingString:link];
            
            actionSheet.content = dict[@"desc"];
            
            [actionSheet show];
            
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
    
    [self.activityView hideAnimated:YES];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [self.activityView hideAnimated:YES];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(void)shareResult:(NSInteger)result
{
    
    if (result == WXSuccess) {
        
        self.shareView.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.shareView.hidden = YES;
            
        });
        
    }
    
}

-(void)naviRightClick
{
    
    ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
    
    actionSheet.delegate = self;
    
    actionSheet.title = [NSString stringWithFormat:@"%@教练的简历",CoachName];
    
    actionSheet.content = [NSString stringWithFormat:@"查看%@的个人资料、工作经历及更多信息",CoachName];
    
    if ([CoachIcon rangeOfString:@"!"].length) {
        
        actionSheet.imgURL = CoachIcon;
        
    }else{
        
        actionSheet.imgURL = [NSString stringWithFormat:@"%@!small",CoachIcon];
        
    }
    
    NSString *link = self.url.absoluteString;
    
    actionSheet.url = [link hasPrefix:@"http"]?link:[@"http://" stringByAppendingString:link];
    
    [actionSheet show];
    
}

-(void)naviRightSubClick
{
    
    MineResumeEditController *svc = [[MineResumeEditController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


@end
