//
//  WebViewController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WebViewController.h"

#import "MOActionSheet.h"

#import "WebViewJavascriptBridge.h"

#import "RootController.h"

#import "ShareActionSheet.h"

#import "MOWebView.h"

#import "WXAPIManager.h"

#import "UserDetailInfo.h"

#import "AgentController.h"

#import "ChangeInfoController.h"

#import "UIWebView+Cache.h"

#import "SensorsAnalyticsSDK.h"

#import "NewsCommentsController.h"

#import "ReplyReceivedController.h"

#import "LoginController.h"

@interface UnpreventableUILongPressGestureRecognizer : UILongPressGestureRecognizer {
}
@end

@implementation UnpreventableUILongPressGestureRecognizer

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer {
    return NO;
}
@end

@interface WebViewController ()<UIWebViewDelegate,ShareActionSheetDelegate,WXApiManagerDelegate,UIGestureRecognizerDelegate,MOActionSheetDelegate>

@property(nonatomic,assign)BOOL webShare;

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

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,strong)UnpreventableUILongPressGestureRecognizer* longPressed;

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
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadUrl:(NSURL *)url
{
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10]];
    
}

-(void)reloadData
{
    
    [UIWebView setCache];
    
    [self.webView reload];
    
}

-(void)createData
{
    
    if (self.param) {
        
        self.url = [NSURL URLWithString:self.param[@"url"]];
        
    }
    
    [UIWebView setCache];
    
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
    
    if (self.rootRightTitle) {
        
        self.rightTitle = self.rootRightTitle;
        
    }
    
    self.webView = [[MOWebView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.webView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _longPressed = [[UnpreventableUILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    
    _longPressed.allowableMovement = 20;
    _longPressed.minimumPressDuration = 1.0f;
    
    _longPressed.delegate = self;
    
    [self.webView addGestureRecognizer:_longPressed];
    
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
    
    nonetImg.image = [UIImage imageNamed:@"nonet"];
    
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

- (void)longPressed:(UILongPressGestureRecognizer*)recognizer
{
    
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint touchPoint = [recognizer locationInView:self.webView];
    
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:imgURL];
    
    if (urlToSave.length == 0) {
        return;
    }
    
    self.imageURL = [NSURL URLWithString:urlToSave];
    
    MOActionSheet *sheet = [MOActionSheet actionSheetWithTitie:nil delegate:self destructiveButtonTitle:nil cancelButtonTitle:@"取消" otherButtonTitles:@"保存图片",nil];
    
    [sheet show];
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (!error) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        [self.view addSubview:hud];
        
        hud.mode = MBProgressHUDModeText;
        
        hud.label.text = @"成功保存到相册";
        
        [hud showAnimated:YES];
        
        [hud hideAnimated:YES afterDelay:1.0f];
        
    }
    
}

-(void)actionSheet:(MOActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        NSData *data = [NSData dataWithContentsOfURL:self.imageURL];
        
        if (data) {
            
            UIImage *image = [UIImage imageWithData:data];
            
            if (image) {
                
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
                
            }
            
            self.imageURL = nil;
            
        }
        
    }
    
}

-(void)refresh:(UIButton*)btn
{
    
    self.nonetView.hidden = YES;
    
    [self reloadData];
    
}

-(void)setLeftType:(MONaviLeftType)leftType
{
    
    [super setLeftType:leftType];
    
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
    
    self.rightType = MONaviRightTypeNO;
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    self.rightType = MONaviRightTypeNO;
    
    if (self.shouldShare) {
        
        self.rightType = MONaviRightTypeShare;
    
        _webShare = NO;
        
    }

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
    
    NSLog(@"%@",webView.request.URL.absoluteString);
    
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
    
    if (self.urlArray.count == 1&&self.rootRightTitle) {
        
        self.rightTitle = self.rootRightTitle;
        
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
    
    [self.webView addGestureRecognizer:_longPressed];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    NSArray *array = [str componentsSeparatedByString:@"clientJsonBegin"];
    
    self.title = [array firstObject];
    
}


-(void)registerHandle
{
    
    MJWeakSelf;
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {}];
    
    [_bridge registerHandler:@"iOSHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([data[@"name"]isEqualToString:@"setAction"])
        {
            
            if ([data[@"data"][@"name"] isEqualToString:@"分享"]) {
                
                weakSelf.webShare = YES;
                
                weakSelf.rightType = MONaviRightTypeShare;
                
            }else if ([data[@"data"][@"name"]isEqualToString:@"删除"])
            {
                
                weakSelf.rightType = MONaviRightTypeTrash;
                
            }else
            {
                
                weakSelf.rightTitle = data[@"data"][@"name"];
                
            }
            
        }else if ([data[@"name"]isEqualToString:@"setTitle"]){
            
            weakSelf.title = data[@"data"][@"title"];
            
        }
        else if([data[@"name"]isEqualToString:@"completeAction"])
        {
            
            BOOL agent = NO;
            
            for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[AgentController class]]) {
                    
                    agent = YES;
                    
                }
                
            }
            
            [weakSelf.navigationController popViewControllerAnimated:!agent];
            
            if (weakSelf.completeAction) {
                weakSelf.completeAction();
            }
            
        }else if ([data[@"name"] isEqualToString:@"shareInfo"])
        {
            
            NSString *dataStr = data[@"data"];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
            ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
            
            actionSheet.delegate = weakSelf;
            
            actionSheet.title = dict[@"title"];
            
            actionSheet.imgURL = [[dict[@"imgUrl"] componentsSeparatedByString:@"!"]firstObject];
            
            NSString *link = dict[@"link"];
            
            actionSheet.url = [link hasPrefix:@"http"]?link:[@"http://" stringByAppendingString:link];
            
            actionSheet.content = dict[@"desc"];
            
            [actionSheet show];
            
        }else if ([data[@"name"] isEqualToString:@"wechatPay"]){
            
            [WXAPIManager sharedManager].delegate = weakSelf;
            
            [[WXAPIManager sharedManager] payWithParameters:data[@"data"][@"data"]];
            
        }else if ([data[@"name"] isEqualToString:@"goNativePath"]){
            
            NSString *dataPath = data[@"data"][@"path"];
            
            if ([dataPath hasPrefix:@"qccoach://"])
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
                    
                    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.goNativePathFail(%@)",dataPath]];
                    
                }
                
            }else{
                
                [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.goNativePathFail(%@)",dataPath]];
                
            }
            
        }else if ([data[@"name"] isEqualToString:@"setArea"]){
            
            [weakSelf presentSetting];
            
        }else if ([data[@"name"] isEqualToString:@"sensorsTrack"]) {
            
            NSDictionary *dict = data[@"data"];
            
            [[SensorsAnalyticsSDK sharedInstance]track:dict[@"key"] withProperties:dict[@"data"]];
            
        }else if ([data[@"name"] isEqualToString:@"onFinishLoad"]){
            
            [weakSelf.activityView hideAnimated:YES];
            
        }
        
    }];
    
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
                
                if (self.urlArray.count == 1&& self.rootRightTitle) {
                    
                    self.rightTitle = self.rootRightTitle;
                    
                }
                
            }else
            {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }
        
    }
    
}

-(void)naviRightClick
{
    
    if (self.rightType == MONaviRightTypeShare && !_webShare) {
        
        ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
        
        actionSheet.delegate = self;
        
        actionSheet.title = [NSString stringWithFormat:@"%@教练的主页",CoachName];
        
        actionSheet.content = [NSString stringWithFormat:@"查看%@的课程及更多信息",CoachName];
        
        if ([CoachIcon rangeOfString:@"!"].length) {
            
            actionSheet.imgURL = CoachIcon;
            
        }else{
            
            actionSheet.imgURL = [NSString stringWithFormat:@"%@!small",CoachIcon];
            
        }
        
        NSString *link = self.url.absoluteString;
        
        actionSheet.url = [link hasPrefix:@"http"]?link:[@"http://" stringByAppendingString:link];
        
        [actionSheet show];
        
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

-(void)presentPrivilege
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [RootController sharedSliderController].selectIndex = 2;
    
}

-(void)presentSetting
{
    
    ChangeInfoController *svc = [[ChangeInfoController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)dealloc
{
    
    self.webView.scrollView.mj_header = nil;
    
    _bridge = nil;
    
    if (self.deallocReload) {
        
        if (self.completeAction) {
            
            self.completeAction();
            
        }
        
    }
    
}

@end
