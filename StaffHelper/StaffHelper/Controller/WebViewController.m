//
//  WebViewController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WebViewController.h"

#import "WebViewJavascriptBridge.h"

#import "RootController.h"

#import "ShareActionSheet.h"

#import "WXAPIManager.h"

#import "MOWebView+JavaScriptAlert.h"

#import "AgentController.h"

#import "GymDetailController.h"

#import "WebHintView.h"

#import "UIWebView+Cache.h"

#import "ChangeInfoController.h"

#import "SensorsAnalyticsSDK.h"

#import "LoginController.h"

#import "NewsCommentsController.h"
#import "YFCompetitionModule.h"

#import "ReplyReceivedController.h"
#import "NSString+YFCategory.h"

#import "YFMediator+WebViewAction.h"

@interface WebViewController ()<UIWebViewDelegate,ShareActionSheetDelegate,WXApiManagerDelegate,WebHintViewDelegate>

@property WebViewJavascriptBridge* bridge;

@property(nonatomic,strong)MBProgressHUD *activityView;

@property(nonatomic,strong)MOWebView *webView;

@property(nonatomic,assign)BOOL isCurrentPage;

@property(nonatomic,assign)BOOL isBack;

@property(nonatomic,copy)NSString *rightClickSelector;

@property(nonatomic,strong)UIView *nonetView;

@property(nonatomic,copy)NSURL *rootUrl;

@property(nonatomic,strong)NSMutableArray *urlArray;

@property(nonatomic,strong)UIView *shareView;

@property(nonatomic,strong)WebHintView *hintView;

@end

@implementation WebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.urlArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
    if (self.shouldHint) {
        
        [self createHintView];
        
    }
    
}

-(void)createData
{
    
    if (self.param) {
        
        self.url = [NSURL URLWithString:self.param[@"url"]];
        
    }
    
    [UIWebView setCache];
    
}

-(void)reloadData
{
    
    [UIWebView setCache];
    
    [self.webView reload];
    
}

-(void)createHintView
{
    
    self.hintView = [[WebHintView alloc]initWithFrame:self.view.frame];
    
    self.hintView.hintURL = self.hintURL;
    
    [self.view addSubview:self.hintView];
    
    self.hintView.hidden = YES;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (self.hintView && self.shouldHint) {
        
        self.hintView.hidden = NO;
        
        [self.view bringSubviewToFront:self.hintView];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
}

-(void)loadUrl:(NSURL *)url
{
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10]];
    
}

-(void)createUI
{
    
    if(!self.leftType){
        
        self.leftType = MONaviLeftTypeBack;
        
    }
    
    if (self.leftType) {
        self.leftType = self.leftType;
    }
    
    if (self.rightType) {
        self.rightType = self.rightType;
    }
    
    if (self.titleType) {
        self.titleType = self.titleType;
    }
    
    if (self.shouldHint) {
        
        self.rightTitle = @"微信约课";
        
        self.rightColor = UIColorFromRGB(0xffffff);
        
    }
    
    self.webView = [[MOWebView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
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
    
    [self registerHandle];
    
    self.activityView = [[MBProgressHUD alloc]initWithView:self.webView];
    
    [self.webView addSubview:self.activityView];
    
    if (self.url) {
        
        [self loadUrl:self.url];
        
        [self.activityView showAnimated:YES];
        
    }
    
    self.nonetView = [[UIView alloc]initWithFrame:self.webView.frame];
    
    self.nonetView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.nonetView];
    
    self.nonetView.hidden = YES;
    
    UIImageView *nonetImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(85), MSW/3, MSW/3)];
    
    nonetImg.image = [UIImage imageNamed:@"fail"];
    
    [self.nonetView addSubview:nonetImg];
    
    UILabel *nonetLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, nonetImg.bottom+Height320(19.5), MSW-100, Height320(19.5))];
    
    nonetLabel.text = @"网络连接失败";
    
    nonetLabel.textColor = UIColorFromRGB(0x747474);
    
    nonetLabel.textAlignment = NSTextAlignmentCenter;
    
    nonetLabel.font = STFont(14);
    
    [self.nonetView addSubview:nonetLabel];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    refreshBtn.frame = CGRectMake(MSW/2-Width320(58), nonetLabel.bottom+Height320(19.5), Width320(116), Height320(39));
    
    refreshBtn.layer.cornerRadius = 4;
    
    refreshBtn.layer.masksToBounds = YES;
    
    refreshBtn.layer.borderColor = kMainColor.CGColor;
    
    refreshBtn.layer.borderWidth = 1;
    
    [refreshBtn setTitle:@"重 试" forState:UIControlStateNormal];
    
    [refreshBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    
    [refreshBtn addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nonetView addSubview:refreshBtn];
    
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
    
}

-(void)refresh:(UIButton*)btn
{
    
    self.nonetView.hidden = YES;
    
    [self reloadData];
    
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    if (!self.isBack && ![webView.request.URL.absoluteString rangeOfString:@"iframe"].length&& ![webView.request.URL.absoluteString isEqualToString:((NSURL*)[self.urlArray lastObject]).absoluteString] && ![[[((NSURL*)[self.urlArray lastObject]).absoluteString componentsSeparatedByString:@"?"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"?"] firstObject]] && ![[[((NSURL*)[self.urlArray lastObject]).absoluteString componentsSeparatedByString:@"#"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"#"] firstObject]]) {
        
        [self.urlArray addObject:[webView.request.URL copy]];
        
    }
    
    __weak typeof(self)weakS = self;
    
    [self.urlArray enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[[url.absoluteString componentsSeparatedByString:@"?"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"?"] firstObject]] ||[[[url.absoluteString componentsSeparatedByString:@"#"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"#"] firstObject]]) {
            
            if (weakS.urlArray.count) {
                
                weakS.urlArray = [[weakS.urlArray subarrayWithRange:NSMakeRange(0, [weakS.urlArray indexOfObject:url]+1)] mutableCopy];
                
                *stop = YES;
                
            }
            
        }
        
    }];
    
    self.isBack = NO;
    
    [self.activityView hideAnimated:YES];
    
    self.nonetView.hidden = NO;
    
    if ([[error description] rangeOfString:@"iframe"].length) {
        
        self.nonetView.hidden = YES;
        
    }
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [self.activityView showAnimated:YES];
    
    self.rightType = MONaviRightTypeNO;
    
    if ([self.webView canGoForward]||[self.webView canGoBack]) {
        
        self.isCurrentPage = NO;
        
    }else
    {
        
        self.isCurrentPage = YES;
        
    }
    
    if (!self.isCurrentPage) {
        
        [self.activityView showAnimated:YES];
        
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if ([webView.request.URL.absoluteString rangeOfString:@"hide_title=1"].length) {
        
        self.navi.hidden = YES;
        
        self.webView.frame = CGRectMake(0, 0, MSW, MSH);
        
    }else{
        
        self.navi.hidden = NO;
        
        self.webView.frame = CGRectMake(0, 64, MSW, MSH-64);
        
    }
    
    if (!self.isBack && ![webView.request.URL.absoluteString rangeOfString:@"iframe"].length&& ![webView.request.URL.absoluteString isEqualToString:((NSURL*)[self.urlArray lastObject]).absoluteString] && ![[[((NSURL*)[self.urlArray lastObject]).absoluteString componentsSeparatedByString:@"?"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"?"] firstObject]] && ![[[((NSURL*)[self.urlArray lastObject]).absoluteString componentsSeparatedByString:@"#"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"#"] firstObject]]) {
        
        [self.urlArray addObject:[webView.request.URL copy]];
        
    }
    
    __weak typeof(self)weakS = self;
    
    [self.urlArray enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[[url.absoluteString componentsSeparatedByString:@"?"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"?"] firstObject]]||[[[url.absoluteString componentsSeparatedByString:@"#"] firstObject]isEqualToString:[[webView.request.URL.absoluteString componentsSeparatedByString:@"#"] firstObject]]) {
            
            if (weakS.urlArray.count) {
                
                weakS.urlArray = [[weakS.urlArray subarrayWithRange:NSMakeRange(0, [weakS.urlArray indexOfObject:url]+1)] mutableCopy];
                
                *stop = YES;
                
            }
            
        }
        
    }];
    
    self.isBack = NO;
    
    if (!self.rootUrl) {
        
        self.rootUrl = webView.request.URL;
        
    }
    
    if ([webView.request.URL.absoluteString isEqualToString:self.rootUrl.absoluteString]) {
        
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }else
    {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    [self.activityView hideAnimated:YES];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    NSArray *array = [str componentsSeparatedByString:@"clientJsonBegin"];
    
    self.title = [array firstObject];
    
    if (self.shouldHint && self.urlArray.count == 1) {
        
        self.rightTitle = @"微信约课";
        
        self.rightColor = UIColorFromRGB(0xffffff);
        
    }
    
    if (self.isBanner && self.urlArray.count == 1) {
        
        self.rightType = MONaviRightTypeShare;
        
    }
    
    if (self.isCoach && self.urlArray.count == 1) {
        
        self.rightType = MONaviRightTypeShare;
        
        self.title = @"健身教练助手";
        
    }
    
}


-(void)registerHandle
{
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {}];
    
    [_bridge registerHandler:@"iOSHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([data[@"name"]isEqualToString:@"setAction"])
        {
            
            if ([data[@"data"][@"name"] isEqualToString:@"分享"]) {
                
                self.rightType = MONaviRightTypeShare;
                
            }else if ([data[@"data"][@"name"]isEqualToString:@"删除"])
            {
                
                self.rightType = MONaviRightTypeTrash;
                
            }else
            {
                
                self.rightTitle = data[@"data"][@"name"];
                
            }
            
        }else if ([data[@"name"]isEqualToString:@"setTitle"]){
            
            self.title = data[@"data"][@"title"];
            
        }
        else if([data[@"name"]isEqualToString:@"completeAction"])
        {
            
            BOOL containsAgent = NO;
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[AgentController class]]) {
                    
                    containsAgent = YES;
                    
                    [self popToViewControllerName:@"ProgrammeController" isReloadData:YES];
                    
                    break;
                    
                }
                
            }
            
            if (!containsAgent) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                if (self.completeAction) {
                    self.completeAction();
                }
                
            }
            
        }else if ([data[@"name"] isEqualToString:@"shareInfo"])
        {
            
            if ([data[@"data"] isKindOfClass:[NSString class]]) {
                
                NSString *dataStr = data[@"data"];
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                
                if (dict) {
                    
                    ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
                    
                    actionSheet.delegate = self;
                    
                    actionSheet.title = dict[@"title"];
                    
                    actionSheet.content = dict[@"desc"];
                    
                    actionSheet.imgURL = dict[@"imgUrl"];
                    
                    NSString *link = dict[@"link"];
                    
                    actionSheet.url = [link hasPrefix:@"http"]?link:[@"http://" stringByAppendingString:link];
                    
                    [actionSheet show];
                    
                }
                
            }else if([data[@"data"] isKindOfClass:[NSDictionary class]]){
                
                NSDictionary *dict = data[@"data"];
                
                if (dict) {
                    
                    ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
                    
                    actionSheet.delegate = self;
                    
                    actionSheet.title = dict[@"title"];
                    
                    actionSheet.content = dict[@"desc"];
                    
                    actionSheet.imgURL = dict[@"imgUrl"];
                    
                    NSString *link = dict[@"link"];
                    
                    actionSheet.url = [link hasPrefix:@"http"]?link:[@"http://" stringByAppendingString:link];
                    
                    [actionSheet show];
                    
                }
                
            }
            
        }else if ([data[@"name"] isEqualToString:@"wechatPay"]){
            
            [WXAPIManager sharedManager].delegate = self;
            
            [[WXAPIManager sharedManager] payWithParameters:data[@"data"][@"data"]];
            
        }else if ([data[@"name"] isEqualToString:@"goNativePath"]){
            
            NSString *dataPath = data[@"data"][@"path"];
            
            if ([dataPath hasPrefix:@"qcstaff://"])
            {
                
                NSURL *url = [NSURL URLWithString:dataPath];
                
                if ([url.host isEqualToString:@"activities"]) {
                    
                    [self presentPrivilege];
                    
                }else if ([url.host isEqualToString:@"area"]){
                    
                    [self presentSetting];
                    
                }else if ([url.host isEqualToString:@"login"]){
                    
                    [self login];
                    
                }else if ([url.host isEqualToString:@"news"]) {
                    
                    if ([url.relativePath isEqualToString:@"/comments"]) {
                        
                        NSInteger pressId = [[[url.query componentsSeparatedByString:@"="] lastObject]integerValue];
                        
                        [self pushCommentWithPressId:pressId];
                        
                    }else if([url.relativePath isEqualToString:@"/replies"]){
                        
                        [self pushReceive];
                        
                    }
                    
                }else{
                    
                    NSDictionary *param = @{YFViewCKey:self,YFWebViewCKey:self.webView};
                    
                    id result = [[YFMediator sharedInstance] performActionWithWebUrl:[NSURL URLWithString:dataPath] params:param completion:nil];
                    
                    if (!result)
                    {
                        
                        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.goNativePathFail(%@)",dataPath]];
                        
                        
                    }
                    
                }
                
            }else{
                
                [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.goNativePathFail(%@)",dataPath]];
                
            }

        }else if ([data[@"name"] isEqualToString:@"setArea"]){
            
            [self presentSetting];
            
        }else if ([data[@"name"] isEqualToString:@"sensorsTrack"]) {
            
            NSDictionary *dict = data[@"data"];
            
            [[SensorsAnalyticsSDK sharedInstance]track:dict[@"key"] withProperties:dict[@"data"]];
            
        }else if ([data[@"name"] isEqualToString:@"onFinishLoad"]){
            
            [self.activityView hideAnimated:YES];
            
        }
        
        DebugLogParamYF(@"%@",data[@"name"]);
        
        DebugLogParamYF(@"%@",data);

//        [self.webView stringByEvaluatingJavaScriptFromString:@"window.nativeLinkWeb.runCallback(%@)"];

    }];
    
}

-(void)pushReceive
{
    
    if (UserId) {
        
        ReplyReceivedController *vc = [[ReplyReceivedController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [self login];
        
    }
    
}

-(void)pushCommentWithPressId:(NSInteger)pressId
{
    
    if (UserId) {
        
        Press *press = [[Press alloc]init];
        
        press.pressId = pressId;
        
        NewsCommentsController *vc = [[NewsCommentsController alloc]init];
        
        vc.press = press;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [self login];
        
    }
    
}

-(void)payResult:(NSInteger)result
{
    
    if (!result) {
        
        [self.webView stringByEvaluatingJavaScriptFromString:@"window.paySuccessCallback()"];
        
        if (self.paySuccess) {
            
            self.paySuccess();
            
        }
        
    }else
    {
        
        self.webView.noBlock = YES;
        
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.payErrorCallback(%ld)",(long)result]];
        
    }
    
}


-(void)naviLeftClick
{
    
    if ([self.webView.request.URL.absoluteString isEqualToString:self.rootUrl.absoluteString]||self.urlArray.count <= 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else
    {
        
        if (self.urlArray.count) {
            
            [self.urlArray removeObjectAtIndex:self.urlArray.count-1];
            
            if (self.urlArray.count) {
                
                self.isBack = YES;
                
                [self loadUrl:[self.urlArray lastObject]];
                
            }else
            {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }
        
    }
    
}

-(void)naviRightClick
{
    
    if (self.shouldHint && self.urlArray.count == 1) {
        
        self.hintView.hidden = NO;
        
        [self.view bringSubviewToFront:self.hintView];
        
    }else if(self.isBanner && self.rightType == MONaviRightTypeShare){
        
        ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
        
        actionSheet.delegate = self;
        
        actionSheet.title = self.title;
        
        actionSheet.imageName = @"qcicon";
        
        actionSheet.url = self.url.absoluteString;
        
        [actionSheet show];
        
    }else if (self.isCoach && self.rightType == MONaviRightTypeShare){
        
        ShareActionSheet *sheet = [[ShareActionSheet alloc]init];
        
        sheet.delegate = self;
        
        sheet.content = @"健身教练助手";
        
        sheet.title = @"健身教练助手";
        
        sheet.url = @"http://fir.im/qingchengfit";
        
        sheet.imageName = @"trainer_icon";
        
        [sheet show];
        
    }else{
        
        [self.webView stringByEvaluatingJavaScriptFromString:@"window.nativeLinkWeb.callbackLst.setAction()"];
        
    }
    
}

-(void)shareResult:(NSInteger)result andType:(ShareType)type
{
    
    if (result == WXSuccess) {
        
        self.shareView.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.shareView.hidden = YES;
            
        });
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:self.title forKey:@"qc_page_title"];
        
        [para setParameter:self.url.absoluteString forKey:@"qc_page_url"];
        
        [para setParameter:@"1" forKey:@"qc_sharesuccess"];
        
        [para setParameter:type==ShareTypeFreind?@"qc_sharetofriends":@"qc_moments" forKey:@"qc_share_channel"];
        
        [[SensorsAnalyticsSDK sharedInstance]track:@"page_share" withProperties:para.data];
        
    }
}

-(void)showDetailHint
{
    
    self.hintView.hidden = YES;
    
    [self loadUrl:self.detailURL];
    
}

-(void)presentPrivilege
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [RootController sharedSliderController].selectIndex = AppOneGym?1:1;
    
}

-(void)presentSetting
{
    
    ChangeInfoController *svc = [[ChangeInfoController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
       
        [weakS.webView reload];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)login
{
    
    LoginController *vc = [[LoginController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    vc.webLogin = YES;
    
    vc.webLoginSuccess = ^{
        
        [UIWebView setCache];
        
        [weakS.webView stringByEvaluatingJavaScriptFromString:@"window.nativeLinkWeb.callbackLst.login()"];
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)chooseGym
{
    weakTypesYF
    UIViewController *controller = [YFCompetitionModule chooseGymVCCompletion:^(NSDictionary * dic) {
        
        NSString *urlString =[NSString stringWithFormat:@"window.nativeLinkWeb.callbackLst['competition/select_shop'](%@)",[NSString stringFromdictioanry_nn:dic]];
        NSLog(@"%@",urlString);
        
        [weakS.webView stringByEvaluatingJavaScriptFromString:urlString];
        [weakS.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
