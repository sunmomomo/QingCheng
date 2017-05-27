//
//  ProgrammeEmptyController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/5/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ProgrammeEmptyController.h"

#import "RootController.h"

#import "LoginController.h"

@interface ProgrammeEmptyController ()

@property(nonatomic,strong)UIButton *useButton;

@property(nonatomic,strong)UIButton *loginButton;

@property(nonatomic,assign)BOOL shouldRegister;

@end

@implementation ProgrammeEmptyController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabTitle = @"课程";
        
        self.selectedImg = [UIImage imageNamed:@"course_selected"];
        
        self.unselectImg = [UIImage imageNamed:@"course_unselect"];
        
    }
    return self;
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

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    if (CoachId) {
        
        [self.useButton changeLeft:MSW/2-Width320(60)];
        
        self.loginButton.hidden = YES;
        
    }else{
        
        [self.useButton changeLeft:MSW/2-Width320(120)-Width320(7)];
        
        self.loginButton.hidden = NO;
        
    }
    
}

-(void)createUI
{
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.navi.hidden = YES;
    
    self.view.backgroundColor = UIColorFromRGB(0xfafafa);
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(34), Height320(100), MSW-Width320(68), Height320(183))];
    
    imgView.image = [UIImage imageNamed:@"programme_empty_1"];
    
    [self.view addSubview:imgView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.bottom+Height320(34), MSW, Height320(20))];
    
    titleLabel.text = @"查看每日课程，代会员约课";
    
    titleLabel.textColor = UIColorFromRGB(0x333333);
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = AllFont(18);
    
    [self.view addSubview:titleLabel];
    
    self.useButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(120)-Width320(7), Height320(426), Width320(120), Height320(38))];
    
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

-(void)login
{
    
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
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
    
    if (CoachId) {
        
        [[RootController sharedSliderController]pushGuide];
        
    }else{
        
        self.shouldRegister = YES;
        
        [self login];
        
    }
    
}

@end
