//
//  HomePageEmptyController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "HomePageEmptyController.h"

#import "RootController.h"

#import "LoginController.h"

@interface HomePageEmptyController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIButton *useButton;

@property(nonatomic,strong)UIButton *loginButton;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *subtitleArray;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,assign)BOOL shouldRegister;

@end

@implementation HomePageEmptyController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabTitle = @"健身房";
        
        self.unselectImg = [UIImage imageNamed:@"gym_unselect"];
        
        self.selectedImg = [UIImage imageNamed:@"gym_selected"];
        
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

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

-(void)createData
{
    
    self.titleArray = @[@"课程预约",@"会员管理",@"数据报表",@"运营推广"];
    
    self.subtitleArray = @[@"会员微信约课",@"便捷高效地管理会员、会员卡",@"健身房运营数据一目了然",@"用互联网更高效地获客"];
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    if (StaffId) {
        
        [self.useButton changeLeft:MSW/2-Width320(60)];
        
        self.loginButton.hidden = YES;
        
    }else{
        
        [self.useButton changeLeft:MSW/2-Width320(120)-Width320(7)];
        
        self.loginButton.hidden = NO;
        
    }
    
}

-(void)createUI
{
    
    self.navi.hidden = YES;
    
    self.view.backgroundColor = UIColorFromRGB(0xfafafa);
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-49)];
    
    self.scrollView.backgroundColor = UIColorFromRGB(0xfafafa);
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.delegate = self;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(MSW*4, 0);
    
    for (NSInteger i = 0; i<4; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*MSW, 0, MSW, self.scrollView.height)];
        
        view.backgroundColor = UIColorFromRGB(0xfafafa);
        
        [self.scrollView addSubview:view];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(34), Height320(100), MSW-Width320(68), Height320(183))];
        
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_page_empty_%ld",(long)i+1]];
        
        [view addSubview:imgView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.bottom+Height320(34), MSW, Height320(20))];
        
        titleLabel.text = self.titleArray[i];
        
        titleLabel.textColor = UIColorFromRGB(0x333333);
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        titleLabel.font = AllFont(18);
        
        [view addSubview:titleLabel];
        
        UILabel *subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+Height320(6), MSW, Height320(18))];
        
        subtitleLabel.text = self.subtitleArray[i];
        
        subtitleLabel.textColor = UIColorFromRGB(0x888888);
        
        subtitleLabel.textAlignment = NSTextAlignmentCenter;
        
        subtitleLabel.font = AllFont(13);
        
        [view addSubview:subtitleLabel];
        
    }
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, Height320(370), MSW, Height320(24))];
    
    self.pageControl.numberOfPages = 4;
    
    self.pageControl.currentPage = 0;
    
    self.pageControl.pageIndicatorTintColor = UIColorFromRGB(0xd8d8d8);
    
    self.pageControl.currentPageIndicatorTintColor = kMainColor;
    
    [self.view addSubview:self.pageControl];
    
    self.useButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(120)-Width320(7), self.pageControl.bottom+Height320(32), Width320(120), Height320(38))];
    
    self.useButton.layer.cornerRadius = self.useButton.height/2;
    
    self.useButton.backgroundColor = kMainColor;
    
    [self.useButton setTitle:@"免费使用" forState:UIControlStateNormal];
    
    [self.useButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.useButton.titleLabel.font = AllFont(16);
    
    [self.view addSubview:self.useButton];
    
    [self.useButton addTarget:self action:@selector(pushGuide) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2+Width320(7), self.useButton.top, Width320(120), Height320(38))];
    
    self.loginButton.layer.cornerRadius = self.loginButton.height/2;
    
    self.loginButton.layer.borderColor = kMainColor.CGColor;
    
    self.loginButton.layer.borderWidth = OnePX;
    
    self.loginButton.backgroundColor = UIColorFromRGB(0xfafafa);
    
    [self.loginButton setTitle:@"已有账号登录" forState:UIControlStateNormal];
    
    [self.loginButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    self.loginButton.titleLabel.font = AllFont(16);
    
    [self.view addSubview:self.loginButton];
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.pageControl.currentPage = scrollView.contentOffset.x/MSW;
    
}

-(void)login
{
    
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    appdelegate.brand = nil;
    
    appdelegate.gym = nil;
    
    LoginController *vc = [[LoginController alloc]init];
    
    vc.pushGuide = YES;
    
    if (self.shouldRegister) {
        
        vc.loginOrRegister = 1;
        
        self.shouldRegister = NO;
        
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)pushGuide
{
    
    if (StaffId) {
        
        [[RootController sharedSliderController]pushGuide];
        
    }else{
        
        self.shouldRegister = YES;
        
        [self login];
        
    }
    
}

@end
