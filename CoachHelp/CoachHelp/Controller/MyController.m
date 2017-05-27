//
//  MyController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MyController.h"

#import "RootController.h"

#import "CoachInfoController.h"

#import "UserDetailInfo.h"

#import "SettingController.h"

#import "ChangeInfoController.h"

#import "WorkListController.h"

#import "QualityListController.h"

#import "GuideBrandSetController.h"

#import "BPush.h"

#import "LoginController.h"

#import "ChangeInfoController.h"

#import "IntroEditController.h"

#import "MineHomePageController.h"

#import "MineResumeController.h"

#import "MyPlanController.h"

#import "WebViewController.h"

#import "MyCell.h"

#import <TLSSDK/TLSHelper.h>

#import <QALSDK/QalSDKProxy.h>

#import <ImSDK/ImSDK.h>

static NSString *identifier = @"Cell";

@interface MyController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)UIImageView *firstOrderView;

@property(nonatomic,strong)UserDetailInfo *userInfo;

@end

@implementation MyController

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.tabTitle = @"我";
        
        self.selectedImg = [UIImage imageNamed:@"mine_selected"];
        
        self.unselectImg = [UIImage imageNamed:@"mine_unselect"];
        
        self.titleArray = @[@[@"我的主页",@"我的简历"],@[@"我的课件"],@[@"我的订单"]];
        
    }
    
    return self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showFirstOrderView
{
    
    BOOL firstOrder = [[NSUserDefaults standardUserDefaults]boolForKey:@"order_first"];
    
    if (!firstOrder) {
        
        self.firstOrderView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(10), Height320(84)+Height320(40)*3+Height320(12)*2+Height(41), Width(200), Height(40))];
        
        self.firstOrderView.image = [UIImage imageNamed:@"order_first_hint"];
        
        [self.tableView addSubview:self.firstOrderView];
        
        [[RootController sharedSliderController]haveNew:YES AtIndex:4];
        
    }
    
}

-(void)reloadHeader
{
    
    if (self.userInfo.user) {
        
        self.rightType = MONaviRightTypeSetting;
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(72))];
        
        headerView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(72))];
        
        topView.backgroundColor = UIColorFromRGB(0xffffff);
        
        topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [topView addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(48), Height320(48))];
        
        self.iconView.layer.cornerRadius = self.iconView.width/2;
        
        self.iconView.layer.masksToBounds = YES;
        
        self.iconView.layer.borderWidth = 1;
        
        self.iconView.userInteractionEnabled = NO;
        
        self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
        
        [topView addSubview:self.iconView];
        
        if (self.userInfo.user.iconURL.absoluteString) {
            
            if ([self.userInfo.user.iconURL.absoluteString rangeOfString:@"!"].length) {
                
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.user.iconURL.absoluteString]];
                
            }else{
                
                if ([self.userInfo.user.iconURL.absoluteString rangeOfString:@"!/watermark/"].length) {
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.userInfo.user.iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[self.userInfo.user.iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                    
                }else if ([self.userInfo.user.iconURL.absoluteString rangeOfString:@"/watermark/"].length){
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.user.iconURL.absoluteString]];
                    
                }else{
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.userInfo.user.iconURL.absoluteString stringByAppendingString:@"!small"]]];
                    
                }
                
            }
            
        }
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(12), 0,MSW-Width320(100), Height320(72))];
        
        self.nameLabel.textColor = UIColorFromRGB(0x333333);
        
        self.nameLabel.font = AllFont(14);
        
        self.nameLabel.userInteractionEnabled = NO;
        
        self.nameLabel.text = self.userInfo.user.username;
        
        [topView addSubview:self.nameLabel];
        
        UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
        
        topArrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [topView addSubview:topArrow];
        
        [headerView addSubview:topView];
        
        self.tableView.tableHeaderView = headerView;
        
    }else{
        
        self.rightType = MONaviRightTypeNO;
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(116))];
        
        headerView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(116))];
        
        topView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [headerView addSubview:topView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(36))];
        
        label.text = @"登录您的青橙账号\n使用健身房管理等更多功能";
        
        label.textColor = UIColorFromRGB(0x888888);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.numberOfLines = 0;
        
        label.font = AllFont(13);
        
        [topView addSubview:label];
        
        UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), label.bottom+Height320(12), MSW-Width320(32), Height320(38))];
        
        loginButton.layer.cornerRadius = 2;
        
        loginButton.layer.borderColor = kMainColor.CGColor;
        
        loginButton.layer.borderWidth = OnePX;
        
        [loginButton setTitle:@"注册或登录" forState:UIControlStateNormal];
        
        [loginButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        loginButton.titleLabel.font = AllFont(16);
        
        [topView addSubview:loginButton];
        
        [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView.tableHeaderView = headerView;
        
    }
    
}

-(void)login
{
    
    LoginController *vc = [[LoginController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)hideOrderView
{
    
    self.firstOrderView.hidden = YES;
    
    [self.firstOrderView removeFromSuperview];
    
    self.firstOrderView = nil;
    
    [[RootController sharedSliderController]haveNew:NO AtIndex:4];
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"order_first"];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)reloadData
{
    
    UserDetailInfo *userInfo = [[UserDetailInfo alloc]init];
    
    [userInfo requestResult:^(BOOL success, NSString *error) {
        
        self.userInfo = userInfo;
        
        [self.tableView.mj_header endRefreshing];
        
        [self reloadHeader];
        
    }];
    
    UserDetailInfo *orderInfo = [[UserDetailInfo alloc]init];
    
    [orderInfo requestOrder:^(BOOL success, NSString *error) {
        
        if (orderInfo.orderNumber) {
            
            BOOL firstOrder = [[NSUserDefaults standardUserDefaults]boolForKey:@"order_first"];
    
            if (!firstOrder) {
                
                [self showFirstOrderView];
                
            }
            
        }
        
    }];
    
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)createUI
{
    
    self.leftType = MONaviLeftTypeNO;
    
    self.title = @"我";
    
    self.rightType = MONaviRightTypeSetting;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-49) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width(15), 0, 0);
    
    [self.tableView registerClass:[MyCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 0.1)];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
}

-(void)topClick
{
    
    ChangeInfoController *svc = [[ChangeInfoController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.titleArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.titleArray[section] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.title = self.titleArray[indexPath.section][indexPath.row];
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    if (self.firstOrderView) {
        
        [self.tableView bringSubviewToFront:self.firstOrderView];
        
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(12);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    return view;
    
}

-(void)naviRightClick
{
    
    SettingController *svc = [[SettingController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.userInfo.user) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                MineHomePageController *svc = [[MineHomePageController alloc]init];
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coaches/%ld/saas/share/",ROOT,CoachId]];
                
                svc.URL = url;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else if (indexPath.row == 1){
                
                MineResumeController *svc = [[MineResumeController alloc]init];
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/coaches/%ld/share/index/",ROOT,CoachId]];
                
                svc.url = url;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }
            
        }else if (indexPath.section == 1){
            
            MyPlanController *svc = [[MyPlanController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else if (indexPath.section == 2){
            
            [self hideOrderView];
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            svc.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/trades/home/",ROOT]];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else{
        
        [self login];
        
    }
    
}

-(void)quitConfirm
{
    
    AppGym = nil;
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"order_first"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"sessionId"];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"phone"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"coachId"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"userId"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userSig"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"pushVersion"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"eventDate"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [[TIMManager sharedInstance]logout:^{
        
    } fail:^(int code, NSString *msg) {
        
    }];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {}];
    
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    appdelegate.window.rootViewController = [[LoginController alloc]init];
    
}

@end
