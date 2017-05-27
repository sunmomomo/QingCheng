//
//  QualityListController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/25.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "QualityListController.h"

#import "QualityMatchEditController.h"

#import "QualityMeetingEditController.h"

#import "QualityTrainEditController.h"

#import "QualityDetailController.h"

#import "ChooseOgnController.h"

#import "UIWebView+Cache.h"

#import "MOActionSheet.h"

#import "WebViewController.h"

#import "PictureShowController.h"

@interface QualityListController ()<UIWebViewDelegate,UIGestureRecognizerDelegate,MOActionSheetDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UIView *addView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,strong)UILongPressGestureRecognizer* longPressed;

@property(nonatomic,assign)BOOL currentLoad;

@end

@implementation QualityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self createUI];
    
    [self createData];
    
}

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.currentLoad = YES;
        
    }
    
    return self;
    
}

-(void)createData
{
    
    [self.hud showAnimated:YES];
    
    [UIWebView setCache];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
}

-(void)reloadData
{
    
    self.currentLoad = YES;
    
    [self.hud showAnimated:YES];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeAdd;
    
    self.title = @"我的学习培训";
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.webView.delegate = self;
    
    _longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    
    _longPressed.delegate = self;
    
    [self.webView addGestureRecognizer:_longPressed];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.webView.scrollView.mj_header = header;
    
    [self.view addSubview:self.webView];
    
    self.addView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.addView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.6];
    
    [self.addView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addHide)]];
    
    self.addView.hidden = YES;
    
    [self.view addSubview:self.addView];
    
    UIView *add = [[UIView alloc]initWithFrame:CGRectMake(MSW-Width320(90), 0, Width320(90), Height320(130))];
    
    add.backgroundColor = UIColorFromRGB(0xfafafa);
    
    [self.addView addSubview:add];
    
    UIButton *addButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, add.width, add.height/3)];
    
    [addButton1 setTitle:@"大会" forState:UIControlStateNormal];
    
    [addButton1 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    
    addButton1.titleLabel.font = AllFont(14);
    
    addButton1.tag = 101;
    
    [add addSubview:addButton1];
    
    [addButton1 addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addButton2 = [[UIButton alloc]initWithFrame:CGRectMake(0, addButton1.bottom, add.width, add.height/3)];
    
    [addButton2 setTitle:@"培训" forState:UIControlStateNormal];
    
    [addButton2 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    
    addButton2.titleLabel.font = AllFont(14);
    
    addButton2.tag = 102;
    
    [addButton2 addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [add addSubview:addButton2];
    
    UIButton *addButton3 = [[UIButton alloc]initWithFrame:CGRectMake(0, addButton2.bottom, add.width, add.height/3)];
    
    [addButton3 setTitle:@"赛事" forState:UIControlStateNormal];
    
    [addButton3 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    
    addButton3.titleLabel.font = AllFont(14);
    
    addButton3.tag = 103;
    
    [addButton3 addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [add addSubview:addButton3];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)addClick:(UIButton*)button
{
    
    self.addView.hidden = YES;
    
    ChooseOgnController *svc = [[ChooseOgnController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.quality.type = button.tag-100;
    
    if (svc.quality.type == QualityTypeMeeting) {
        
        svc.title = @"添加大会认证";
        
    }else if (svc.quality.type == QualityTypeTrain){
        
        svc.title = @"添加培训认证";
        
    }else
    {
        
        svc.title = @"添加赛事认证";
        
    }
    
    svc.addSuccess = ^(Quality *quality){
        
        if (quality.type == QualityTypeMeeting) {
            
            QualityMeetingEditController *svc = [[QualityMeetingEditController alloc]init];
            
            svc.isAdd = YES;
            
            svc.quality = quality;
            
            svc.editFinish = ^(Quality *quality){
                
                [weakS createData];
                
                for (MOViewController *vc in weakS.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"MineResumeController"]) {
                        
                        [vc reloadData];
                        
                    }
                    
                }
                
            };
            
            [weakS dismissViewControllerAnimated:NO completion:nil];
            
            [weakS.navigationController pushViewController:svc animated:YES];
            
        }else if (quality.type == QualityTypeTrain){
            
            QualityTrainEditController *svc = [[QualityTrainEditController alloc]init];
            
            svc.isAdd = YES;
            
            svc.quality = quality;
            
            svc.editFinish = ^(Quality *quality){
                
                [weakS createData];
                
                for (MOViewController *vc in weakS.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"MineResumeController"]) {
                        
                        [vc reloadData];
                        
                    }
                    
                }
                
            };
            
            [weakS dismissViewControllerAnimated:NO completion:nil];
            
            [weakS.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            QualityMatchEditController *svc = [[QualityMatchEditController alloc]init];
            
            svc.isAdd = YES;
            
            svc.quality = quality;
            
            svc.editFinish = ^(Quality *quality){
                
                [weakS createData];
                
                for (MOViewController *vc in weakS.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"MineResumeController"]) {
                        
                        [vc reloadData];
                        
                    }
                    
                }
                
            };
            
            [weakS dismissViewControllerAnimated:NO completion:nil];
            
            [weakS.navigationController pushViewController:svc animated:YES];
            
        }
        
        
    };
    
    [self presentViewController:svc animated:YES completion:nil];
    
    
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


- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (!error) {
        
        _hud.mode = MBProgressHUDModeText;
        
        _hud.label.text = @"成功保存到相册";
        
        [_hud showAnimated:YES];
        
        [_hud hideAnimated:YES afterDelay:1.0f];
        
    }
    
}


-(void)addHide{
    
    self.addView.hidden = YES;
    
}

-(void)naviRightClick
{
    
    self.addView.hidden = !self.addView.hidden;
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (!self.currentLoad) {
        
        if ([request.URL.absoluteString hasSuffix:@".jpg"]||[request.URL.absoluteString hasSuffix:@".png"]||[request.URL.absoluteString hasSuffix:@".jpeg"]) {
            
            PictureShowController *svc = [[PictureShowController alloc]init];
            
            svc.imageURL = request.URL;
            
            [self presentViewController:svc animated:YES completion:nil];
            
        }else{
            
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
    
    [self.webView addGestureRecognizer:_longPressed];
    
    [self.hud hideAnimated:YES];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [self.hud hideAnimated:YES];
    
    [self.webView.scrollView.mj_header endRefreshing];
    
}

@end
